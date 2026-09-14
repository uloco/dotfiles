import type { Plugin } from "@opencode-ai/plugin";

// Remove after https://github.com/anomalyco/opencode/pull/48070 ships.
export const BedrockAstraImages: Plugin = async () => ({
  "experimental.chat.messages.transform": async (_input, output) => {
    const user = output.messages.findLast((message) => message.info.role === "user")?.info;
    if (
      user?.role !== "user" ||
      user.model.providerID !== "amazon-bedrock" ||
      !/^(global\.|us\.)openai\.gpt-6-astra$/.test(user.model.modelID)
    ) return;

    const messages = output.messages.flatMap((message) => {
      if (message.info.role !== "assistant" || message.info.error) return [message];

      const images = message.parts.flatMap((part) => {
        if (
          part.type !== "tool" ||
          part.state.status !== "completed" ||
          part.state.time.compacted
        ) return [];

        const attachments = part.state.attachments ?? [];
        const extracted = attachments.filter(
          (attachment) => attachment.mime.startsWith("image/") && attachment.url.startsWith("data:"),
        );
        if (extracted.length) {
          part.state.attachments = attachments.filter((attachment) => !extracted.includes(attachment));
        }
        return extracted;
      });
      if (!images.length) return [message];

      // Converse accepts Astra images beside tool results, not inside them.
      const id = `${message.info.id}-astra-images`;
      return [message, {
        info: { ...user, id },
        parts: [
          {
            id: `${id}-text`,
            sessionID: user.sessionID,
            messageID: id,
            type: "text" as const,
            text: "Attached images from the preceding tool results:",
            synthetic: true,
          },
          ...images.map((image, index) => ({
            ...image,
            id: `${id}-${index}`,
            sessionID: user.sessionID,
            messageID: id,
          })),
        ],
      }];
    });
    output.messages.splice(0, output.messages.length, ...messages);
  },
});
