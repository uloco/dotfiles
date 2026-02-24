# Macros Auto-Save & Label System

## Goal

Replace the manual macro save workflow (`<leader>ms`) with automatic saving on
every recording, and add the ability to label/describe macros from within the
picker. Provide filtered views (all, labeled, unlabeled) both as keymaps and as
an in-picker toggle.

---

## Schema Change

### Current format (`saved_macros.json`)

```json
{ "name": "string", "description": "string", "register": "string", "keys": "string" }
```

### New format

```json
{
  "label": "string",
  "description": "string",
  "register": "string",
  "keys": "string",
  "timestamp": "string (ISO 8601)"
}
```

- `name` → renamed to `label`. Empty string means unlabeled.
- `timestamp` — set at recording time, used for display of unlabeled macros.

### Migration

`M.load()` checks each entry: if `name` exists but `label` does not, rename the
field and write the file back once. Entries without a `timestamp` get `""`.

---

## 1. Auto-Save (`macros.lua`)

### `M.setup()`

Register two autocommands:

- **`RecordingEnter`**: Capture `vim.fn.reg_recording()` into a module-local
  variable (`_recording_register`). This is needed because the register is no
  longer available after recording stops.

- **`RecordingLeave`**: Read keystrokes from `_recording_register` via
  `vim.fn.getreg()`. Skip if empty. Deduplicate by checking if any existing
  entry has identical `keys` — if so, skip saving. Otherwise prepend a new entry:

  ```lua
  {
    label = "",
    description = "",
    register = _recording_register,
    keys = keys,
    timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
  }
  ```

  Use `vim.schedule()` inside `RecordingLeave` so the register contents are
  fully committed before we read them.

### Remove `M.save_macro()`

No longer needed. Delete the function and the `<leader>ms` keymap.

### New helpers

- **`M.set_label(idx, label)`** — Update the label of macro at index `idx` and
  write to disk.
- **`M.set_description(idx, description)`** — Update the description of macro at
  index `idx` and write to disk.

### Call site for `setup()`

Call `M.setup()` from the snacks.lua `init` function (it runs early, before
lazy loading, so autocommands are registered immediately).

---

## 2. Picker Changes (`snacks.lua`)

### Finder

Accept a filter mode via `ctx.picker.state.filter` (default `"all"`):

- `"all"` — return every macro
- `"labeled"` — return only macros where `label ~= ""`
- `"unlabeled"` — return only macros where `label == ""`

### Format

- **Labeled**: `  label  description  @a  <keystrokes>`
- **Unlabeled**: `  (unlabeled)  @a  <keystrokes>  2026-02-24 15:30`

Show timestamp for unlabeled macros so the user can tell them apart.

### Preview

No changes needed — the existing inline diff preview works with the new schema
as-is (it only uses `keys` and `name`/`label` for the title).

Update the title line from `macro.name` to `macro.label` (or show `"(unlabeled)"`).

### New Actions

| Action             | Keybind  | Behavior                                                        |
| ------------------ | -------- | --------------------------------------------------------------- |
| `macro_label`      | `<C-l>`  | Open `Snacks.input()` prefilled with current label. Save + refresh. |
| `macro_describe`   | `<C-d>`  | Open `Snacks.input()` prefilled with current description. Save + refresh. |
| `macro_filter`     | `<C-f>`  | Cycle filter: `all → labeled → unlabeled → all`. Update title + refresh. |

### Existing Actions (unchanged)

| Action         | Keybind  |
| -------------- | -------- |
| `macro_delete` | `<C-x>`  |
| `macro_yank`   | `<C-y>`  |

### Dynamic Title

Update picker title based on filter state:

- `"all"` → `"Saved Macros"`
- `"labeled"` → `"Saved Macros (Labeled)"`
- `"unlabeled"` → `"Saved Macros (Unlabeled)"`

---

## 3. Keymaps

| Keymap        | Action                                             |
| ------------- | -------------------------------------------------- |
| `<leader>lm`  | Open macros picker — all macros (filter toggleable) |
| `<leader>lM`  | Open macros picker — labeled only                   |
| `<leader>ms`  | **Remove**                                          |

Both keymaps open the same picker source, just with a different initial filter
state.

---

## 4. Files to Modify

### `lua/utils/macros.lua`

- Add `M.setup()` with `RecordingEnter` / `RecordingLeave` autocommands
- Add migration logic in `M.load()` (`name` → `label`, add `timestamp`)
- Add `M.set_label(idx, label)`
- Add `M.set_description(idx, description)`
- Remove `M.save_macro()`

### `lua/plugins/snacks.lua`

- Call `require("utils.macros").setup()` in `init`
- Update `macros` picker source:
  - Finder: filter by `state.filter`
  - Format: handle labeled vs unlabeled display
  - Preview title: use `label` instead of `name`
  - Add actions: `macro_label`, `macro_describe`, `macro_filter`
  - Add keybinds: `<C-l>`, `<C-d>`, `<C-f>`
  - Dynamic title based on filter state
- Add `<leader>lM` keymap (labeled-only picker)
- Remove `<leader>ms` keymap

---

## 5. Edge Cases

- **Empty recordings**: Skip auto-save if register is empty after `RecordingLeave`
  (user pressed `q` twice quickly or aborted).
- **Deduplication**: Compare raw `keys` strings. If a duplicate exists and has a
  label, the labeled version is kept and no new entry is created.
- **Legacy data**: Migration runs transparently on `M.load()`. Old entries get
  `label` from `name` and `timestamp = ""`.
- **Register independence**: Macros execute via `M.execute(keys)` which loads
  into a temp register (`m`). The stored `register` field is purely informational.
