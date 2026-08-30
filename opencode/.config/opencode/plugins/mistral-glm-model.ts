/**
 * OpenCode plugin that normalizes the SSE stream from `zai-glm-5-2` (served
 * via Mistral's OpenAI-compatible endpoint) so `@ai-sdk/openai-compatible`
 * can parse it.
 *
 * Three transformations:
 *   1. `delta.content` array (thinking parts) -> flat string + reasoning_content
 *   2. Tool-call chunks without `id` -> stable unique id injected
 *   3. Outgoing assistant `reasoning_content` -> Mistral ThinkChunk format
 *      (Mistral rejects `reasoning_content` with HTTP 422)
 *
 * Also injects `reasoning_effort` from model options into the request body,
 * since opencode strips unknown keys.
 */

type LogFn = (level: "debug" | "info" | "warn" | "error", message: string) => void;

const GLM_MODEL_ID = "zai-glm-5-2";

function isGlmProvider(id: string, provider: any): boolean {
  if (!id.toLowerCase().includes("mistral")) return false;
  if (provider?.npm !== "@ai-sdk/openai-compatible") return false;
  const models = provider?.models;
  if (!models || typeof models !== "object") return false;
  return Object.prototype.hasOwnProperty.call(models, GLM_MODEL_ID);
}

export const MistralGlmModelPlugin = async (input: any) => {
  const log: LogFn = (level, message) => {
    try {
      void input.client.app
        .log({
          body: { service: "mistral-glm-model", level, message },
        })
        .catch(() => {});
    } catch {}
  };

  log("info", "plugin loaded");

  return {
    config: async (cfg: any) => {
      if (!cfg.provider) return;

      for (const [id, provider] of Object.entries(cfg.provider)) {
        const p = provider as any;
        if (!isGlmProvider(id, p)) continue;

        if (!p.options) p.options = {};
        const originalFetch = p.options.fetch;

        const effort = p.models?.[GLM_MODEL_ID]?.options?.reasoning_effort;

        p.options.fetch = async (
          fetchInput: RequestInfo | URL,
          init?: RequestInit,
        ) => {
          const fetchFn = originalFetch ?? fetch;

          // Rewrite assistant reasoning_content -> Mistral ThinkChunk array.
          if (typeof init?.body === "string") {
            try {
              const reqJson = JSON.parse(init.body);
              let injected = false;
              if (
                effort &&
                reqJson?.model === GLM_MODEL_ID &&
                reqJson.reasoning_effort === undefined
              ) {
                reqJson.reasoning_effort = effort;
                injected = true;
              }
              if (injected) {
                init.body = JSON.stringify(reqJson);
                log("debug", `injected reasoning_effort=${effort}`);
              }
              if (Array.isArray(reqJson?.messages)) {
                let rewritten = 0;
                for (const msg of reqJson.messages) {
                  if (
                    !msg ||
                    typeof msg !== "object" ||
                    msg.role !== "assistant"
                  )
                    continue;
                  const reasoning =
                    typeof msg.reasoning_content === "string"
                      ? msg.reasoning_content
                      : typeof msg.reasoning === "string"
                        ? msg.reasoning
                        : "";
                  if (reasoning === "") continue;

                  const text =
                    typeof msg.content === "string" ? msg.content : "";
                  const toolCalls = Array.isArray(msg.tool_calls)
                    ? msg.tool_calls
                    : null;

                  const contentArr: any[] = [
                    {
                      type: "thinking",
                      thinking: [{ type: "text", text: reasoning }],
                    },
                  ];
                  if (text !== "") contentArr.push({ type: "text", text });

                  msg.content = contentArr;
                  delete msg.reasoning_content;
                  delete msg.reasoning;
                  if (toolCalls) msg.tool_calls = toolCalls;
                  rewritten++;
                }
                if (rewritten > 0) {
                  init.body = JSON.stringify(reqJson);
                  log(
                    "debug",
                    `rewrote ${rewritten} assistant message(s) reasoning -> ThinkChunk`,
                  );
                }
              }
            } catch {}
          }

          const response = await fetchFn(fetchInput as any, init);

          const contentType = response.headers.get("content-type") ?? "";
          let isStreaming = contentType.includes("text/event-stream");

          if (!isStreaming && init?.body) {
            try {
              const bodyStr =
                typeof init.body === "string"
                  ? init.body
                  : JSON.stringify(init.body);
              if (bodyStr.includes('"stream"') && bodyStr.includes("true")) {
                isStreaming = true;
              }
            } catch {}
          }

          if (!isStreaming || !response.body) return response;

          const url =
            typeof fetchInput === "string"
              ? fetchInput
              : (fetchInput as URL).toString?.() ?? "unknown";
          log("debug", `wrapping SSE response from ${url}`);

          const transformedBody = response.body
            .pipeThrough(new TextDecoderStream())
            .pipeThrough(
              new TransformStream<string, string>(new GlmStreamNormalizer()),
            )
            .pipeThrough(new TextEncoderStream());

          return new Response(transformedBody, {
            status: response.status,
            statusText: response.statusText,
            headers: response.headers,
          });
        };

        log("info", `injected fetch into provider: ${id}`);
      }
    },
  };
};

const seenToolCallIds = new Set<string>();

function stableToolCallId(
  preferred: string | undefined,
  idx: number,
): string {
  if (preferred && preferred !== "" && !seenToolCallIds.has(preferred)) {
    seenToolCallIds.add(preferred);
    return preferred;
  }
  let candidate = `callglm${idx}${crypto.randomUUID().replace(/-/g, "")}`;
  while (seenToolCallIds.has(candidate)) {
    candidate = `callglm${idx}${crypto.randomUUID().replace(/-/g, "")}`;
  }
  seenToolCallIds.add(candidate);
  return candidate;
}

class GlmStreamNormalizer {
  private lineBuffer = "";
  private toolCallIds = new Map<number, string>();

  transform(
    chunk: string,
    controller: TransformStreamDefaultController<string>,
  ): void {
    this.lineBuffer += chunk;
    const lines = this.lineBuffer.split("\n");
    this.lineBuffer = lines.pop() ?? "";
    for (const line of lines) {
      const out = this.processLine(line);
      if (out !== null) controller.enqueue(out);
    }
  }

  flush(controller: TransformStreamDefaultController<string>): void {
    if (this.lineBuffer.trim()) {
      const out = this.processLine(this.lineBuffer);
      if (out !== null) controller.enqueue(out);
      this.lineBuffer = "";
    }
  }

  private processLine(line: string): string | null {
    const trimmed = line.trim();
    if (!trimmed || !trimmed.startsWith("data:")) return line + "\n";
    const data = trimmed.slice(5).trim();
    if (data === "[DONE]") return line + "\n";

    let json: any;
    try {
      json = JSON.parse(data);
    } catch {
      return line + "\n";
    }

    const result = this.processChunk(json);
    if (result === null) return null;
    return "data: " + JSON.stringify(result) + "\n";
  }

  private processChunk(json: any): any | null {
    const choices = json.choices;
    if (!choices || !choices.length) return json;

    const choice = choices[0];
    const delta = choice.delta;
    if (!delta) return json;

    // Normalize content array -> string + reasoning_content string.
    if (Array.isArray(delta.content)) {
      const textParts: string[] = [];
      const reasoningParts: string[] = [];
      for (const part of delta.content) {
        if (!part || typeof part !== "object") continue;
        const t = part.type;
        if (t === "text" && typeof part.text === "string") {
          textParts.push(part.text);
        } else if (t === "thinking") {
          const thinking = part.thinking;
          if (typeof thinking === "string") {
            reasoningParts.push(thinking);
          } else if (Array.isArray(thinking)) {
            for (const tp of thinking) {
              if (tp && typeof tp === "object" && typeof tp.text === "string") {
                reasoningParts.push(tp.text);
              }
            }
          }
        }
      }
      const text = textParts.join("");
      const reasoning = reasoningParts.join("");
      if (text !== "") delta.content = text;
      else delete delta.content;
      if (reasoning !== "") {
        const existing =
          typeof delta.reasoning_content === "string"
            ? delta.reasoning_content
            : "";
        delta.reasoning_content = existing + reasoning;
      }
    }

    // Ensure tool-call deltas with a name always carry a stable unique id.
    if (Array.isArray(delta.tool_calls)) {
      for (const tc of delta.tool_calls) {
        if (!tc || typeof tc !== "object") continue;
        const idx = typeof tc.index === "number" ? tc.index : 0;
        const hasName =
          typeof tc.function?.name === "string" && tc.function.name !== "";
        const hasId = typeof tc.id === "string" && tc.id !== "";
        if (hasName && !hasId) {
          const existing = this.toolCallIds.get(idx);
          const id = stableToolCallId(existing, idx);
          this.toolCallIds.set(idx, id);
          tc.id = id;
        } else if (hasId) {
          seenToolCallIds.add(tc.id);
          this.toolCallIds.set(idx, tc.id);
        }
      }
    }

    return json;
  }
}
