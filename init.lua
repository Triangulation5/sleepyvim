vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.list = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.updatetime = 50
vim.o.timeoutlen = 150
vim.o.guicursor = "a:block"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.winborder = "double"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.conceallevel = 0
vim.o.pumheight = 10
vim.o.pumblend = 10
vim.opt.ruler = false
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({ stl = " " })
vim.opt.shortmess:append("c")
vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.swapfile = false
vim.g.mapleader = " "
vim.opt.fillchars:append({ horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " ", verthoriz = " " })

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        checkout = "harpoon2"
    },
    { src = "https://github.com/neanias/everforest-nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then 
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd('set completeopt+=noselect')

require "mason".setup()
require "mini.pick".setup()
require("mini.icons").setup()
local icons = require("mini.icons")
require("Oil").setup({
    keymaps = {
        ["q"] = "actions.close",
        ["l"] = "actions.select",
        ["h"] = "actions.parent",
        ["<leader>r"] = "actions.refresh",
    },
    view_options = {
        show_hidden = true,
    },
})

vim.o.winblend = 10

require("harpoon").setup()

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>hx", function() harpoon:list():clear() end)

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>cm', ':Mason<CR>')
vim.keymap.set({'n', 'v'}, 'd', '"_d')
vim.keymap.set({'n', 'v'}, 'c', '"_c')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '<leader>gg', function()
    vim.cmd('botright split term://lazygit')
end)
vim.lsp.enable({"lua_ls", "ruff-lsp"})
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})

require("vague").setup({ transparency = true })
require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = false,
    contrast = "hard",
})
require("everforest").setup({
    background = "hard",
    transparent_background_level = 0,
    italics = true,
    disable_italic_comments = false,
    inlay_hints_background = "dimmed",
    on_highlights = function(hl, _)
        hl["@string.special.symbol.ruby"] = { link = "@field" }
    end,
})

local function set_colorscheme(name)
    local success, _ = pcall(vim.cmd, "colorscheme " .. name)
    if not success then
        vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.ERROR)
        return
    end
    if name == "gruvbox" then
        vim.cmd("hi SignColumn guibg=#1d2021")
    elseif name == "vague" then
        vim.cmd("hi statusline guibg=NONE")
    elseif name == "everforest" then
        vim.cmd("hi Normal guibg=#282828")
    end
end

local schemes = { "gruvbox", "vague", "everforest" }
local current_idx = 1

vim.keymap.set("n", "<leader>tt", function()
    current_idx = (current_idx % #schemes) + 1
    set_colorscheme(schemes[current_idx])
end)

set_colorscheme("vague")
_G.mini_icons = mini_icons
