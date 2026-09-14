# OpenCode v2

`~/.local/bin/opencode2` runs the beta with separate config, data, cache, and state.
Sidekick uses this launcher on Alt+Shift+A. Alt+A keeps OpenCode v1.

Install the pinned beta runtime:

```sh
npm install --global --prefix "$HOME/.local/share/opencode2/runtime" @opencode/cli@0.0.0-beta-19425
stow --no-folding -t "$HOME" opencode2
```

- Config: `~/.config/opencode2/opencode/`
- Data: `~/.local/share/opencode2/opencode/`
- Cache: `~/.cache/opencode2/opencode/`
- State: `~/.local/state/opencode2/opencode/`

The initial migration copies v1 sessions and supporting files. Later changes do not sync.
The server config keeps supported v1 syntax so the published schema remains usable.
The Mistral plugin is omitted because it requires the v1 plugin API.

Keep `cli.json` and `service.json` local. The beta replaces these files when it saves settings.
The isolated background server uses port 49376.
V2 accepts the LSP setting but does not yet provide an LSP runtime.
