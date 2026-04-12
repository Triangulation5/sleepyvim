-- Neovim Entry Point
-- Sets mapleader and requires all modular configuration files.

-- Set mapleader and maplocalleader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core Neovim Settings
require("core.options")
require("core.utils")
require("core.keymaps")
require("core.autocmds")

-- Plugin Installation and Setup
require("plugins") -- Loads plugins using vim.pack.add
require("plugins.lsp")
require("plugins.cmp")
require("plugins.mini")
require("plugins.oil")
require("plugins.ui")
require("plugins.git")

-- Visual and UI Configurations
require("config.diagnostics")
require("config.statusline")
require("config.theme")
