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
    {src = "https://github.com/vague2k/vague.nvim"},
    {src = "https://github.com/echasnovski/mini.pick"},
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/mason-org/mason.nvim"},
    {src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
    {src = "https://github.com/nvim-lua/plenary.nvim"},
    {src = "https://github.com/nvim-tree/nvim-web-devicons"},
    {src = "https://github.com/MunifTanjim/nui.nvim"},
    {src = "https://github.com/ellisonleao/gruvbox.nvim"},
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
require("neo-tree").setup({
    window = {
        position = "right",
        width = 26,
    },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },
    default_component_configs = {
        indent = { padding = 0 },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "*",
        },
    },
})


vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree toggle right<CR>')
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

require "vague".setup({ transparency = true })
require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = false,
    contrast = "hard",
})

vim.cmd("colorscheme gruvbox")
vim.cmd("hi SignColumn guibg=#1d2021")
vim.cmd(":hi statusline guibg=NONE")
