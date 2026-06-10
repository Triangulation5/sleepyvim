# Neovim Nightly Configuration

<!--toc:start-->
- [Neovim Nightly Configuration](#neovim-nightly-configuration)
  - [Requirements](#requirements)
  - [Features](#features)
  - [Plugins](#plugins)
    - [Installed Plugins](#installed-plugins)
    - [Included mini.nvim Modules](#included-mininvim-modules)
    - [External Tools](#external-tools)
  - [Installation](#installation)
  - [Keymaps](#keymaps)
    - [General](#general)
    - [Navigation](#navigation)
    - [LSP & Diagnostics](#lsp-diagnostics)
    - [Tools](#tools)
  - [LSP Configuration](#lsp-configuration)
  - [Philosophy](#philosophy)
- [License](#license)
<!--toc:end-->

> [!IMPORTANT]
> This configuration only works on Neovim v0.12.0+

Built and tested against Neovim 0.12 Nightly (NVIM v0.12.0-dev-1215+ga897cc17a5i).

## Requirements

* Neovim Nightly (0.12+)
* Git

## Features

* Native package management using `vim.pack.add()`
* Fast startup using `vim.loader`
* Native LSP completion
* Persistent undo with automatic cleanup
* Rounded floating windows
* Oil file explorer, buffer and tab based workflow
* Git integration
* Diagnostics → Quickfix workflow
* Typst preview support
* Minimal Lua configuration
* No plugin manager

## Plugins

### Installed Plugins

* neovim/nvim-lspconfig
* mason-org/mason.nvim
* stevearc/oil.nvim
* echasnovski/mini.nvim
* vague-theme/vague.nvim
* chomosuke/typst-preview.nvim

### Included mini.nvim Modules

* mini.ai
* mini.diff
* mini.git
* mini.icons
* mini.move
* mini.notify
* mini.pairs
* mini.pick
* mini.surround

### External Tools

| Tool       | Purpose                     |
| ---------- | --------------------------- |
| pyright    | Python LSP                  |
| ruff       | Python linting / formatting |
| gopls      | Go LSP                      |
| vtsls      | TypeScript LSP              |
| marksman   | Markdown LSP                |
| tinymist   | Typst LSP                   |
| typst      | Typst compiler              |
| powershell | Terminal integration        |
| git        | Version control             |

## Installation

Linux / macOS

```bash
git clone https://github.com/Triangulation5/sleepyvim ~/.config/nvim
```

Windows (PowerShell)

```powershell
git clone https://github.com/Triangulation5/sleepyvim $env:LOCALAPPDATA\nvim
```

## Keymaps

### General

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>w`  | Save              |
| `<leader>q`  | Quit              |
| `<leader>wq` | Save and Quit     |
| `<leader>n`  | Enter `:norm`     |
| `<leader>i`  | Edit `.gitignore` |

### Navigation

| Key          | Action        |
| ------------ | ------------- |
| `<leader>f`  | Pick Files    |
| `<leader>fg` | Live Grep     |
| `<leader>h`  | Help Picker   |
| `<leader>k`  | Keymap Picker |
| `<leader>e`  | Oil Explorer  |

### LSP & Diagnostics

| Key          | Action                 |
| ------------ | ---------------------- |
| `<leader>lf` | Format Buffer          |
| `<leader>da` | Diagnostics → Quickfix |
| `<C-q>`      | Open Quickfix          |

### Tools

| Key         | Action                                                          |
| ----------- | --------------------------------------------------------------- |
| `<leader>p` | Typst Preview                                                   |
| `<M-t>`     | PowerShell Terminal (Change the terminal for your specific one) |

## LSP Configuration

Enabled Servers:

| Language                | Server        |
| ----------------------- | ------------- |
| Python                  | pyright, ruff |
| Go                      | gopls         |
| TypeScript / JavaScript | vtsls         |
| Markdown                | marksman      |
| Typst                   | tinymist      |

Features:

* Native completion autotrigger
* Rounded diagnostic floats
* Quickfix integration
* Severity sorting
* Underlines and signs enabled
* Custom diagnostic formatting

## Philosophy

This configuration intentionally avoids:

* Telescope
* Treesitter
* Heavy completion frameworks
* Plugin managers
* Large dependency graphs

The goal is to stay close to upstream Neovim while still providing a modern editing experience.

# License

MIT
