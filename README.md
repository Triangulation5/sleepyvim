# Neovim Configuration (Modular)

A clean, modular Neovim configuration written in Lua. This setup is structured for maintainability and clarity, separating concerns into logical modules.

## Directory Structure

```text
~/.config/nvim/
├── init.lua           # Entry point: sets leader and requires all modules
└── lua/
    ├── core/          # Core Neovim settings
    │   ├── options.lua    # All vim.opt and related settings
    │   ├── keymaps.lua    # General and plugin keymaps
    │   ├── autocmds.lua   # Autocommands (TextYankPost, etc.)
    │   └── utils.lua      # Helper functions and global constants
    ├── plugins/       # Plugin configurations
    │   ├── init.lua       # Plugin installation (vim.pack.add)
    │   ├── lsp.lua        # LSP server configurations (lspconfig, mason)
    │   ├── cmp.lua        # Completion setup (blink.cmp, codeium)
    │   ├── mini.lua       # mini.nvim module configurations
    │   ├── oil.lua        # oil.nvim file explorer setup
    │   ├── ui.lua         # UI-related plugins (notify, indentscope)
    │   └── git.lua        # Git integration (mini.git)
    └── config/        # Thematic and visual configurations
        ├── theme.lua      # Colorschemes and transparency logic
        ├── statusline.lua # Statusline configuration (mini.statusline)
        └── diagnostics.lua# Diagnostic display settings
```

## Features

- **Modular Design**: Easy to find and update specific parts of your config.
- **Pure Lua**: High performance and modern configuration style.
- **Comprehensive LSP Support**: Pre-configured for Python, Go, Rust, and TypeScript/JavaScript.
- **Rich UI**: Includes statusline, notifications, indentation guides, and more via `mini.nvim`.
- **Fast Completion**: Powered by `blink.cmp` with `codeium` integration.
- **Flexible Themes**: Built-in support for `vague`, `rose-pine`, and `gruvbox` with easy toggling.

## Key Bindings (Highlights)

- `<leader>f`: Find files (MiniPick)
- `<leader>e`: Open Oil explorer
- `<leader>ef`: Open MiniFiles
- `<leader>t`: Cycle colorschemes
- `<leader>tt`: Toggle transparency
- `<leader>gg`: Open Lazygit
- `<leader>w`: Trim whitespace and save

## Extras

See `EXTRA.md` for additional snippets, including configurations for `mini.clue`, `screenkey`, `undotree`, and more colorschemes.
