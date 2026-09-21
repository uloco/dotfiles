import type { Plugin } from "@opencode-ai/plugin"
import { readdir, readFile } from "fs/promises"
import { join } from "path"
import { homedir } from "os"

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

export const BedrockSsoAuth: Plugin = async ({ $ }) => {
  if (await isSsoTokenExpired()) {
    console.log(`[bedrock-sso-auth] SSO token expired, running aws sso login --profile ${PROFILE}`)
    await $`aws sso login --profile ${PROFILE}`
  }
  return {}
}
