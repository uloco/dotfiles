# NeoComposer.nvim Alternative: nvim-recorder

## Issue
NeoComposer.nvim (https://github.com/ecthelionvi/NeoComposer.nvim) is archived and no longer maintained as of late 2025.

## Solution: nvim-recorder
We've replaced NeoComposer.nvim with **nvim-recorder** by chrisgrieser, which is actively maintained (last updated February 2026).

### Why nvim-recorder?
- ✅ **Actively maintained** - Regular updates and bug fixes
- ✅ **Feature-rich** - Multiple macro slots, visual feedback, editing capabilities
- ✅ **Modern** - Built with Lua, uses modern Neovim APIs
- ✅ **Status line integration** - Shows recording status in lualine
- ✅ **Performance optimizations** - Handles large macros efficiently
- ✅ **Macro breakpoints** - Pause execution during replay

### Key Features
1. **Multiple Macro Slots**: Store macros in different registers (a, b, c)
2. **Visual Status**: See recording status and current slot in lualine
3. **Macro Editing**: Edit macros interactively with `cq`
4. **Easy Management**: Yank, delete, or switch between macro slots
5. **Performance Mode**: Automatic optimization for large macros
6. **Breakpoints**: Add breakpoints with `##` for debugging macros

### Keybindings
- `q` - Start/stop recording macro
- `Q` - Play macro from current slot
- `<C-q>` - Switch between macro slots
- `cq` - Edit current macro
- `dq` - Delete all macros
- `yq` - Yank (copy) current macro
- `##` - Add breakpoint in macro (pauses execution)

### Status Line Integration
The lualine status bar shows:
- 🔴 Recording indicator when recording a macro
- Current macro slot (e.g., "Slot: a")
- Appears in the lualine_x section with orange color for visibility

## Other Alternatives Considered

### 1. Native Vim Macros
- **Pros**: No plugin needed, always available
- **Cons**: No visual feedback, limited management features
- **Use case**: Minimal setups, basic macro needs

### 2. registers.nvim
- **Plugin**: https://github.com/tversteeg/registers.nvim
- **Pros**: Browse and edit all registers (including macros)
- **Cons**: Not macro-specific, less specialized features
- **Use case**: When you need general register management

### 3. vim-peekaboo
- **Plugin**: https://github.com/junegunn/vim-peekaboo
- **Pros**: View registers during operations
- **Cons**: Vimscript-based, view-only
- **Use case**: Quick register inspection

### 4. Custom Lua Solutions
- **Pros**: Fully customizable to your workflow
- **Cons**: Requires maintenance and Lua knowledge
- **Use case**: Unique requirements not met by existing plugins

## Migration from NeoComposer.nvim

Since NeoComposer.nvim was not previously configured in this dotfiles repository, no migration is needed. The nvim-recorder plugin is ready to use immediately after installation.

### If you were using NeoComposer:
1. Remove NeoComposer plugin declaration
2. Add nvim-recorder (already done in `lua/plugins/nvim-recorder.lua`)
3. Update keybindings if you customized them (defaults are similar)
4. Your saved macros in registers will continue to work

## Configuration Files
- Plugin config: `nvim/.config/nvim/lua/plugins/nvim-recorder.lua`
- Lualine integration: `nvim/.config/nvim/lua/plugins/lualine.lua`

## Resources
- nvim-recorder GitHub: https://github.com/chrisgrieser/nvim-recorder
- NeoComposer.nvim (archived): https://github.com/ecthelionvi/NeoComposer.nvim
- Awesome Neovim plugins: https://github.com/rockerBOO/awesome-neovim

## Usage Tips

### Basic Workflow
1. Press `q` to start recording in the current slot
2. Perform your actions
3. Press `q` again to stop recording
4. Press `Q` to replay the macro
5. Use `<C-q>` to switch slots if you need multiple macros

### Advanced Features
- **Edit a macro**: Press `cq` to open the macro in a buffer for editing
- **Debug macros**: Add `##` in your macro recording to create breakpoints
- **Copy macros**: Use `yq` to yank the current macro for pasting elsewhere
- **Performance mode**: Automatically enabled for macros with 100+ operations

### Best Practices
- Use descriptive slot names: Keep a mental note of what each slot (a, b, c) contains
- Start simple: Begin with basic macros and gradually add complexity
- Use breakpoints: When debugging complex macros, `##` breakpoints are invaluable
- Clean up: Use `dq` to clear old macros when starting a new editing session
