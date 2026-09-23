import { Plugin } from "@opencode/plugin"
import { readdir, readFile } from "fs/promises"
import { join } from "path"
import { homedir } from "os"
import { spawn } from "child_process"

const SSO_CACHE_DIR = join(homedir(), ".aws", "sso", "cache")
const PROFILE = "llm"
const PROVIDER = "bedrock"
// Refresh early so a long request cannot outlive the token.
const BUFFER_MS = 5 * 60 * 1000
const MAX_RETRY = 2
const AUTH_ERROR = /expired|ExpiredToken|InvalidGrant|credential|sso|token/i

let expiresAt = 0
let pending: Promise<void> | undefined

async function readExpiry(): Promise<number> {
  let latest = 0
  try {
    for (const file of await readdir(SSO_CACHE_DIR)) {
      if (!file.endsWith(".json")) continue
      const raw = await readFile(join(SSO_CACHE_DIR, file), "utf-8")
      const data = JSON.parse(raw)
      if (!data.accessToken || !data.expiresAt) continue
      latest = Math.max(latest, new Date(data.expiresAt).getTime())
    }
  } catch {
    // no cache at all
  }
  return latest
}

function login(): Promise<void> {
  console.log(`[bedrock-sso-auth] running aws sso login --profile ${PROFILE}`)
  return new Promise<void>((resolve, reject) => {
    const child = spawn("aws", ["sso", "login", "--profile", PROFILE], { stdio: "inherit" })
    child.on("error", reject)
    child.on("close", (code) => {
      if (code === 0) resolve()
      else reject(new Error(`aws sso login exited with code ${code}`))
    })
  })
}

async function ensureToken(force = false): Promise<void> {
  if (!force) {
    if (Date.now() + BUFFER_MS < expiresAt) return
    expiresAt = await readExpiry()
    if (Date.now() + BUFFER_MS < expiresAt) return
  }

  // Concurrent requests share one login.
  pending ??= login()
    .then(async () => {
      expiresAt = await readExpiry()
    })
    .finally(() => {
      pending = undefined
    })
  await pending
}

export default Plugin.define({
  id: "bedrock-sso-auth",
  async setup(ctx) {
    await ctx.session.hook("model.request", () => ensureToken(), { providerID: PROVIDER })

    await ctx.session.hook(
      "retry",
      async (input) => {
        if (input.attempt > MAX_RETRY) return
        if (!AUTH_ERROR.test(`${input.error.type} ${input.error.message}`)) return

        await ensureToken(true)
        input.decision = { retry: true, delay: 0 }
      },
      { providerID: PROVIDER },
    )
  },
})
