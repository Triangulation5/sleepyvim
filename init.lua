if vim.loader then vim.loader.enable() end
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
local o = vim.opt

o.number = true
o.relativenumber = true
o.numberwidth = 4
o.signcolumn = "yes"
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.breakindent = true
o.list = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.background = "dark"
o.updatetime = 50
o.timeoutlen = 150
o.guicursor = "a:block"
o.scrolloff = 8
o.sidescrolloff = 8
o.winborder = "rounded"
o.clipboard = "unnamedplus"
o.completeopt = "menuone,noselect"
o.conceallevel = 0
o.pumheight = 10
o.pumblend = 10
o.swapfile = false
o.winblend = 28
opt.ruler = false
opt.title = true
opt.titlelen = 0
opt.fillchars = opt.fillchars + "eob: "
opt.fillchars:append({
    stl = " ",
    horiz = " ", horizup = " ", horizdown = " ",
    vertleft = " ", vertright = " ", verthoriz = " "
})
opt.shortmess:append("c")

local map = vim.keymap.set

map('n', '<leader>o', ':update<CR>:source<CR>')
map('n', '<leader>w', ':lua MiniTrailspace.trim()<CR>:lua MiniTrailspace.trim_last_lines()<CR>:write<CR>')
map('n', '<leader>q', ':exit<CR>')
map('n', '<leader>a', function() require("harpoon"):list():add() end)
map('n', '<C-e>', function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end)
map('n', '<C-h>', function() require("harpoon"):list():select(1) end)
map('n', '<C-t>', function() require("harpoon"):list():select(2) end)
map('n', '<C-n>', function() require("harpoon"):list():select(3) end)
map('n', '<C-s>', function() require("harpoon"):list():select(4) end)
map('n', '<leader>hx', function() require("harpoon"):list():clear() end)
map('n', '<leader>ff', ':Pick files<CR>')
map('n', '<leader>fg', ':Pick grep_live<CR>')
map('n', '<leader>fw', ':lua MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })<CR>')
map('n', '<leader>fb', ':Pick buffers<CR>')
map('n', '<leader>fr', ':Pick oldfiles<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>e', ':Oil<CR>')
map('n', '<leader>ef', ':lua MiniFiles.open()<CR>')
map('n', '<leader>wz', ':lua MiniMisc.zoom()<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>cm', ':Mason<CR>')
map('n', '<leader>bn', ':bnext<CR>')
map('n', '<leader>bp', ':bprev<CR>')
map('n', '<leader>bd', ':bdelete<CR>')
map('n', '<leader>bm', ':bmodified<CR>')
map({'n', 'v'}, 'd', '"_d')
map({'n', 'v'}, 'c', '"_c')
map('n', 'x', '"_x')
map('n', '<leader>ca', function() vim.cmd('botright split term://ruff format && ruff clean') end)
map('n', '<leader>gg', function()
  if vim.fn.executable("lazygit") == 1 then
    vim.cmd("botright split term://lazygit")
  else
    vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
  end
end)

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", checkout = "harpoon2" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("mason").setup()
require("oil").setup({
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

require("harpoon").setup()

require("mini.ai").setup()
require("mini.animate").setup()
require("mini.clue").setup()
require("mini.completion").setup()
require("mini.diff").setup()
require("mini.extra").setup()
require("mini.files").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.jump").setup()
require("mini.misc").setup()
require("mini.move").setup()
require("mini.notify").setup({
    lsp_progress = {
        enable = true,
        duration_last = 1000,
    },
    window = {
        config = {
            border = "rounded",
        },
        max_width_share = 0.4,
    },
})
vim.notify = require("mini.notify").make_notify()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.snippets").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.trailspace").setup()

vim.lsp.enable({"lua_ls", "ruff-lsp", "pylsp", "pyright"})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

require("vague").setup({ transparency = true })
require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = false,
    contrast = "hard",
})

local function set_colorscheme(name)
    local ok = pcall(vim.cmd.colorscheme, name)
    if not ok then
        vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.ERROR)
        return
    end
    if name == "gruvbox" then
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1d2021" })
    elseif name == "vague" then
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    end
end

local schemes = { "gruvbox", "vague", "retrobox", "randomhue" }
local current_idx = 0

vim.keymap.set("n", "<leader>tt", function()
    current_idx = (current_idx % #schemes) + 1
    set_colorscheme(schemes[current_idx])
end)

set_colorscheme("vague")
