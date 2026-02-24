# Macro Inline Diff Preview -- Implementation Plan

## Goal

When browsing saved macros with `<leader>lm`, the Snacks picker preview pane shows
an inline diff of what the macro would do on the current buffer -- deleted text with
red background, added text with green background, mimicking live-command.nvim behavior.

## Files to Modify

| File | Change |
|------|--------|
| `lua/utils/macros.lua` | Add diff computation engine + inline diff rendering helpers |
| `lua/plugins/snacks.lua` | Replace static `preview = "preview"` with custom preview function |

## Architecture

### 1. Capture buffer context on picker open

In the macros picker source, add an `on_show` callback (or lazily on first preview
call via `ctx.preview.state`) that captures:

- `state.lines` -- full buffer content (`nvim_buf_get_lines`)
- `state.cursor` -- cursor position (`nvim_win_get_cursor`)
- `state.ft` -- filetype of the original buffer
- `state.buf_options` -- any relevant buffer options (expandtab, shiftwidth, etc.)

Store these on `ctx.preview.state` so they persist across preview calls.

### 2. Diff computation (`utils/macros.lua`)

Add `M.compute_diff(original_lines, keys, cursor_pos)`:

1. Create an unlisted scratch buffer (`nvim_create_buf(false, true)`)
2. Copy `original_lines` into it (`nvim_buf_set_lines`)
3. Set relevant buffer options to match the original buffer
4. Load the macro keys into register `m` (`vim.fn.setreg("m", keys)`)
5. Execute the macro in the scratch buffer via `nvim_buf_call(scratch_buf, function() ... end)`:
   - Set cursor to `cursor_pos`
   - Run `vim.cmd("noautocmd normal @m")`
   - Wrap in `pcall` to catch errors
6. Read the resulting lines from the scratch buffer
7. Delete the scratch buffer (`nvim_buf_delete`)
8. Return `{ old_lines, new_lines }` (or `nil, error_message` on failure)

### 3. Inline diff rendering helpers (`utils/macros.lua`)

#### Line-level diff

Add `M.line_diff(old_lines, new_lines)`:

- Use `vim.diff(old_text, new_text, { result_type = "indices" })` to get hunks
- Each hunk is `{ start_a, count_a, start_b, count_b }`
- Classify each hunk:
  - `count_a > 0 and count_b == 0` -> pure deletion
  - `count_a == 0 and count_b > 0` -> pure insertion
  - `count_a > 0 and count_b > 0` -> change (needs character-level diff)

#### Character-level diff (for changed lines)

Add `M.char_diff(old_line, new_line)`:

- Splice each string so every character is on its own line:
  `"abc"` -> `"a\nb\nc\n"`
- Run `vim.diff(spliced_old, spliced_new, { result_type = "indices" })`
- Map the resulting hunks back to byte column offsets
- Return a list of `{ col_start, col_end, kind }` segments

#### Build annotated lines + highlights

Add `M.build_preview(old_lines, new_lines, hunks)`:

- Walk through hunks and build a merged line array where:
  - Unchanged lines are kept as-is
  - Deleted lines are re-inserted at their original position (will be highlighted red)
  - Added lines are present from `new_lines` (will be highlighted green)
  - Changed lines: re-insert deleted characters into the line text at their original
    position, then highlight deleted chars red and added chars green
- Return `{ lines = merged_lines, highlights = highlight_list }`
- Each highlight entry: `{ line = 0-indexed, col_start = byte, col_end = byte, hl_group = "DiffAdd"|"DiffDelete"|"DiffChange" }`

### 4. Custom preview function in snacks.lua

Replace `preview = "preview"` with:

```lua
preview = function(ctx)
  local macros_util = require("utils.macros")
  local state = ctx.preview.state

  -- Lazy capture of buffer context on first preview call
  if not state.original_lines then
    state.original_lines = vim.api.nvim_buf_get_lines(state.source_buf, 0, -1, false)
    state.cursor = vim.api.nvim_win_get_cursor(state.source_win)
    state.ft = vim.bo[state.source_buf].filetype
  end

  -- Compute diff
  local old_lines = state.original_lines
  local result, err = macros_util.compute_diff(old_lines, ctx.item.item.keys, state.cursor)

  if not result then
    -- Macro errored: fall back to showing keystrokes + error
    ctx.preview:reset()
    ctx.preview:set_lines({ "Error executing macro:", err or "unknown error", "", "Keystrokes: " .. macros_util.format_keys(ctx.item.item.keys) })
    return
  end

  local new_lines = result
  local diff_result = macros_util.build_preview(old_lines, new_lines)

  if not diff_result.has_changes then
    -- No changes: show message
    ctx.preview:reset()
    ctx.preview:set_lines({ "No changes on current buffer", "", "Keystrokes: " .. macros_util.format_keys(ctx.item.item.keys) })
    return
  end

  -- Scope to +-20 lines around cursor for focus
  local display = macros_util.scope_preview(diff_result, state.cursor[1], 20)

  -- Render
  ctx.preview:reset()
  ctx.preview:set_lines(display.lines)
  ctx.preview:highlight({ ft = state.ft })

  -- Apply diff highlights via extmarks
  local ns = vim.api.nvim_create_namespace("macros_preview")
  for _, hl in ipairs(display.highlights) do
    vim.api.nvim_buf_set_extmark(ctx.buf, ns, hl.line, hl.col_start, {
      end_col = hl.col_end,
      hl_group = hl.hl_group,
    })
  end
end
```

Also need to capture `source_buf` and `source_win` before the picker opens. Either:
- Save them in the picker `on_show` callback
- Or capture them in the keymap function before calling `Snacks.picker.pick("macros")`
  and pass them via picker opts / state

### 5. Scoping to cursor region

Add `M.scope_preview(diff_result, cursor_line, context_lines)`:

- Given the full merged lines + highlights from `build_preview`, extract only the
  lines within `[cursor_line - context_lines, cursor_line + context_lines]`
- Adjust highlight line numbers to be relative to the extracted slice
- If the buffer extends beyond the slice, prepend/append a `"..."` indicator line
- Return `{ lines, highlights }`

### 6. Highlight groups used

| Group | Meaning | Standard Neovim group |
|-------|---------|----------------------|
| `DiffDelete` | Removed text/lines (red bg) | Yes |
| `DiffAdd` | Added text/lines (green bg) | Yes |
| `DiffChange` | Changed lines with mixed add/delete | Yes |

No custom highlight groups needed -- these are standard and will match the user's
colorscheme automatically.

### 7. Edge cases

- **Macro causes error**: `pcall` around execution, fall back to keystrokes display
- **No visible changes**: Show "No changes on current buffer" message
- **Large buffers**: Scope to +-20 lines around cursor, diff computed on full buffer
  but only the relevant slice is rendered
- **Macro depends on external state** (registers, marks, etc.): Best-effort, the
  scratch buffer won't have these -- acceptable limitation
- **Macro modifies multiple distant regions**: The +-20 line scope might miss some
  changes -- could add a "N more changes outside view" indicator
- **Empty macro list**: No preview triggered (already handled by picker)

### 8. Keymap changes

Capture source buffer/window before opening the picker:

```lua
{
  "<leader>lm",
  function()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()
    Snacks.picker.pick("macros", {
      on_show = function(picker)
        picker.preview.state.source_buf = buf
        picker.preview.state.source_win = win
      end,
    })
  end,
  desc = "Saved Macros",
},
```
