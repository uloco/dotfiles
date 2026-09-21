import { Plugin } from "@opencode/plugin"
import { readdir, readFile } from "fs/promises"
import { join } from "path"
import { homedir } from "os"
import { spawn } from "child_process"

const SSO_CACHE_DIR = join(homedir(), ".aws", "sso", "cache")
const PROFILE = "llm"

async function isSsoTokenExpired(): Promise<boolean> {
  try {
    const files = await readdir(SSO_CACHE_DIR)
    for (const file of files) {
      if (!file.endsWith(".json")) continue
      const raw = await readFile(join(SSO_CACHE_DIR, file), "utf-8")
      const data = JSON.parse(raw)
      // SSO session token has accessToken + expiresAt
      if (data.accessToken && data.expiresAt) {
        return new Date(data.expiresAt) <= new Date()
      }
    }
  } catch {
    // no cache at all
  }
  return true
}

export default Plugin.define({
  id: "bedrock-sso-auth",
  async setup() {
    if (!(await isSsoTokenExpired())) return

    console.log(`[bedrock-sso-auth] SSO token expired, running aws sso login --profile ${PROFILE}`)
    await new Promise<void>((resolve, reject) => {
      const child = spawn("aws", ["sso", "login", "--profile", PROFILE], {
        stdio: "inherit",
      })
      child.on("error", reject)
      child.on("close", (code) => {
        if (code === 0) resolve()
        else reject(new Error(`aws sso login exited with code ${code}`))
      })
    })
  },
})
