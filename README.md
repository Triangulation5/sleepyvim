# Neovim Nightly Configuration

<!--toc:start-->
- [Neovim Nightly Configuration](#neovim-nightly-configuration)
  - [This configuration only works in Neovim Nightly](#this-configuration-only-works-in-neovim-nightly)
  - [NVIM v0.12.0-dev-1215+ga897cc17a5](#nvim-v0120-dev-1215ga897cc17a5)
  - [Configuration Screenshots](#configuration-screenshots)
    - [MiniFiles Explorer](#minifiles-explorer)
    - [blink.cmp Autocomplete](#blinkcmp-autocomplete)
    - [MiniPick File Picker](#minipick-file-picker)
    - [Diagnostics & LSP Info](#diagnostics-lsp-info)
  - [Designed for](#designed-for)
  - [Features](#features)
  - [All plugins managed entirely through native vim.pack.add()](#all-plugins-managed-entirely-through-native-vimpackadd)
    - [Installed Plugins:](#installed-plugins)
    - [Included mini.nvim Modules](#included-mininvim-modules)
    - [Requirements:](#requirements)
    - [External Tools (optional but recommended):](#external-tools-optional-but-recommended)
  - [Installation:](#installation)
  - [Keymaps](#keymaps)
    - [General](#general)
    - [File Navigation](#file-navigation)
    - [Window Management](#window-management)
    - [Buffers & Tabs](#buffers-tabs)
    - [Git](#git)
    - [Diagnostics & LSP](#diagnostics-lsp)
    - [Motion](#motion)
    - [Editing](#editing)
    - [Terminal Tools](#terminal-tools)
    - [LSP Configuration](#lsp-configuration)
  - [Philosophy](#philosophy)
- [License](#license)
<!--toc:end-->

## This configuration only works in Neovim Nightly
## NVIM v0.12.0-dev-1215+ga897cc17a5

This is a high-performance, minimal, and extensible Neovim Nightly configuration designed around fast startup, sane defaults, and modern plugin architecture. Built for Neovim 0.10+.
A fast, minimal, and modern Neovim configuration built entirely around native Neovim APIs, vim.pack, and the mini.nvim ecosystem.

---

## Configuration Screenshots

### MiniFiles Explorer
![MiniFiles](screenshots/configuration0.png)

### blink.cmp Autocomplete
![blink.cmp](screenshots/configuration1.png)

### MiniPick File Picker
![MiniPick](screenshots/configuration2.png)

### Diagnostics & LSP Info
![Diagnostics](screenshots/configuration3.png)

## Designed for

- Low startup latency
- Minimal dependencies
- Native LSP workflow
- Keyboard-driven navigation
- Lightweight extensibility
- Terminal-centric development

No Telescope. No Treesitter. No heavyweight plugin managers.

## Features

- Native package management using vim.pack.add()
- Fast startup using vim.loader
- Minimal Lua-only configuration
- Built around the mini.nvim ecosystem
- Native Neovim completion (vim.lsp.completion)
- Persistent undo history with automatic cleanup
- Rounded floating windows everywhere
- Integrated file explorer with oil.nvim
- Floating terminal launcher
- Typst preview support
- Git integration using mini.git
- Quickfix-driven diagnostics workflow
- Smart no-yank editing mappings
- Buffer navigation using <leader>1-8
- Floating yazi and glow integration

Built-in LSP support for:
- Python
- Go
- TypeScript
- Markdown
- Typst
- Plugin Architecture

## All plugins managed entirely through native vim.pack.add()

### Installed Plugins:
- neovim/nvim-lspconfig
- mason-org/mason.nvim
- stevearc/oil.nvim
- echasnovski/mini.nvim
- vague-theme/vague.nvim
- mbbill/undotree
- chomosuke/typst-preview.nvim

### Included mini.nvim Modules
- mini.ai
- mini.bracketed
- mini.cmdline
- mini.diff
- mini.git
- mini.icons
- mini.jump2d
- mini.move
- mini.notify
- mini.pairs
- mini.pick
- mini.surround
- mini.tabline
- mini.trailspace
- mini.misc
- mini.files

### Requirements:
- Neovim Nightly (0.12+)
- Git

### External Tools (optional but recommended):

| Tool         | Purpose                                                |
|------------- | ------------------------------------------------------ |
| ruff         | Python linting/formatting                              |
| gopls        | Go LSP                                                 |
| pyright      | Python LSP                                             |
| vtsls        | TypeScript LSP                                         |
| tinymist     | Typst LSP                                              |
| yazi         | Flating terminal file manager                          |
| glow         | Markdown preview                                       |
| typst        | Typst compiler                                         |
| powershell   | Terminal integration on Windows (depends on your OS)   |

## Installation:

Linux / macOS
```bash
git clone https://github.com/Triangulation5/minimalvim ~/.config/nvim
```

Windows (PowerShell)
```pwsh
git clone https://github.com/Triangulation5/minimalvim $env:LOCALAPPDATA\nvim
```

## Keymaps

### General

| Key            | Action                             |
|--------------- | ---------------------------------- |
| <leader>w      | Trim whitespace and save           |
| <leader>wq     | Save and quit                      |
| <leader>q      | Quit                               |
| <leader>cm     | Open Mason                         |
| <leader>u      | Toggle Undotree                    |
| <leader>a      | Alternate buffer                   |
| <leader>ti     | Show time/date                     |
| <leader>n      | Enter :norm command (for sweats)   |

### File Navigation

| Key            | Action               |
|--------------- | -------------------- |
| <leader>f      | Pick files           |
| <leader>fg     | Live grep            |
| <leader>fw     | Grep current word    |
| <leader>fb     | Pick buffers         |
| <leader>h      | Help picker          |
| <leader>k      | Keymap picker        |
| <leader>e      | Oil file explorer    |
| <leader>ef     | MiniFiles explorer   |

### Window Management

| Key   | Action    |
|--------------- | --------------- |
| <leader>wz   | Zoom Window   |
| <leader>wr   | Resize window   |

### Buffers & Tabs

| Key   | Action    |
|--------------- | --------------- |
| <leader>bn   | Next buffer   |
| <leader>bp   | Previous buffer   |
| <leader>bd   | Delete buffer   |
| <leader>bf   | Force delete buffer   |
| <leader>ba   | Wipe all buffers |
| <leader>tn   | Next tab |
| <leader>tp   | Previous tab |
| <leader>tc   | Close tab |
| <leader>tf   | Close other tabs |

### Git

| Key | Action |
| -------------- | --------------- |
| <leader>gh | Git history |
| <leader>gc | Git cursor history |
| <leader>gd | Git diff source |

### Diagnostics & LSP

| Key | Action |
| -------------- | --------------- |
| <leader>lf | Format buffer |
| <leader>da | Diagnostics → quickfix|
| <C-q> | Open quickfix |

### Motion

| Key   | Action    |
|--------------- | --------------- |
| <leader>j   | Jump2d   |
| <C-d>   | Scroll down and center   |
| <C-u>   | Scroll up and center   |
| n   | Next search result centered   |
| N | Previous search result centered |

### Editing

| Key | Action |
| -------------- | --------------- |
| d | Delete without yanking |
| c | Change without yanking |
| x | Cut without yanking |

### Terminal Tools

| Key | Action |
| -------------- | --------------- |
| <M-t> | Floating Powershell |
| <leader>y | Floating Yazi |
| <leader>g | Floating Glow |

### LSP Configuration

Enabled Servers:
| Language   | LSP    |
|--------------- | --------------- |
| Python   | pyright, ruff   |
| Go   | gopls   |
| Markdown   | marksman   |
| TypstScript / JavaScript   | vtsls   |
| Typst   | tinymist    |

Features:
- Native completion autotrigger
- Diagnostics with rounded floating windows
- Quickfix integration
- Severity sorting
- Underlines and signs enabled
- Custom diagnostic formatting
- UI Design
- Configuration Choices
- Rounded borders everywhere
- Minimal visual clutter
- No statusline plugin
- Native tabline via mini.tabline
- vague.nvim colorscheme
- Hidden startup intro
- Relative line numbers
- Persistent undo
- Integrated notifications via mini.notify
- Typst Support

Includes:

tinymist LSP
typst-preview.nvim
Automatic Typst pair mappings

Preview command:
```vimscript
:TypstPreview
```

## Philosophy

This configuration intentionally avoids:
- Telescope
- Treesitter
- Heavy completion frameworks
- Large plugin dependency graphs
- Lua framework abstractions
The goal is to stay close to upstream Neovim while still providing a modern editing experience.

# License

MIT
