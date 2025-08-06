if vim.loader then vim.loader.enable() end
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.list = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.background = "dark"
opt.guicursor = "a:block"
opt.updatetime = 50
opt.timeoutlen = 150
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.winborder = "rounded"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 28
opt.swapfile = false
opt.ruler = false
opt.title = true
opt.titlelen = 0
opt.fillchars:append({
    eob = " ",
    stl = " ",
    horiz = " ", horizup = " ", horizdown = " ",
    vertleft = " ", vertright = " ", verthoriz = " ",
})
opt.shortmess:append("c")

local map = vim.keymap.set

map('n', '<leader>o', ':update<CR>:source<CR>', { desc = 'Write and source current file' })
map('n', '<leader>w', ':lua MiniTrailspace.trim()<CR>:lua MiniTrailspace.trim_last_lines()<CR>:write<CR>', { desc = 'Trim whitespace and save' })
map('n', '<leader>q', ':exit<CR>', { desc = 'Exit current window' })
map('n', '<leader>a', function() require("harpoon"):list():add() end, { desc = 'Harpoon: Add file' })
map('n', '<C-e>', function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = 'Harpoon: Toggle menu' })
map('n', '<C-h>', function() require("harpoon"):list():select(1) end, { desc = 'Harpoon: Go to file 1' })
map('n', '<C-t>', function() require("harpoon"):list():select(2) end, { desc = 'Harpoon: Go to file 2' })
map('n', '<C-n>', function() require("harpoon"):list():select(3) end, { desc = 'Harpoon: Go to file 3' })
map('n', '<C-s>', function() require("harpoon"):list():select(4) end, { desc = 'Harpoon: Go to file 4' })
map('n', '<leader>hx', function() require("harpoon"):list():clear() end, { desc = 'Harpoon: Clear list' })
map('n', '<leader>ff', ':Pick files<CR>', { desc = 'Pick: Files' })
map('n', '<leader>fg', ':Pick grep_live<CR>', { desc = 'Pick: Live grep' })
map('n', '<leader>fw', ':lua MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })<CR>', { desc = 'Pick: Grep word under cursor' })
map('n', '<leader>fb', ':Pick buffers<CR>', { desc = 'Pick: Buffers' })
map('n', '<leader>fr', ':Pick oldfiles<CR>', { desc = 'Pick: Recent files' })
map('n', '<leader>h', ':Pick help<CR>', { desc = 'Pick: Help tags' })
map('n', '<leader>e', ':Oil<CR>', { desc = 'Oil: Open file explorer' })
map('n', '<leader>ef', ':lua MiniFiles.open()<CR>', { desc = 'MiniFiles: Open file manager' })
map('n', '<leader>wz', ':lua MiniMisc.zoom()<CR>', { desc = 'MiniMisc: Zoom window' })
map('n', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP: Format buffer' })
map('n', '<leader>cm', ':Mason<CR>', { desc = 'Mason' })
map('n', '<leader>b', ':buffers<CR>', { desc = 'Buffers' })
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Buffer: Next' })
map('n', '<leader>bp', ':bprev<CR>', { desc = 'Buffer: Previous' })
map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Buffer: Delete' })
map('n', '<leader>bm', ':bmodified<CR>', { desc = 'Buffer: Modified list' })
map({'n', 'v'}, 'd', '"_d', { desc = 'Delete without yank' })
map({'n', 'v'}, 'c', '"_c', { desc = 'Change without yank' })
map('n', 'x', '"_x', { desc = 'Cut character without yank' })
map('n', '<C-p>', function() vim.cmd('botright split term://powershell') end, { desc = 'Terminal: Open PowerShell' })
map('n', '<leader>ca', function() vim.cmd('botright split term://ruff format && ruff clean') end, { desc = 'Ruff: Format and clean' })
map('n', '<leader>gg', function()
  if vim.fn.executable("lazygit") == 1 then
    vim.cmd("botright split term://lazygit")
  else
    vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
  end
end, { desc = 'Git: Open lazygit' })

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", checkout = "harpoon2" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/projekt0n/github-nvim-theme"},
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
require("mini.clue").setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = "" },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = "" },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        require('mini.clue').gen_clues.builtin_completion(),
        require('mini.clue').gen_clues.g(),
        require('mini.clue').gen_clues.marks(),
        require('mini.clue').gen_clues.registers(),
        require('mini.clue').gen_clues.windows(),
        require('mini.clue').gen_clues.z(),
    },
    window = {
        config = {
            width = 'auto',
            border = 'rounded',
        },
    },
})
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

local schemes = { "gruvbox", "vague", "retrobox", "randomhue", "github_dark_high_contrast" }
local current_idx = 0

vim.keymap.set("n", "<leader>t", function()
    current_idx = (current_idx % #schemes) + 1
    set_colorscheme(schemes[current_idx])
end, { desc = 'UI: Cycle colorschemes' })

set_colorscheme("github_dark_default")
