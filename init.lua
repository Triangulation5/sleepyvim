if vim.loader then vim.loader.enable() end
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
for k, v in pairs({
    number = true, relativenumber = true, numberwidth = 4,
    signcolumn = "yes",
    tabstop = 4, softtabstop = 4, shiftwidth = 4, expandtab = true,
    autoindent = true, smartindent = true, breakindent = true,
    list = true, ignorecase = true, smartcase = true,
    hlsearch = false, incsearch = true,
    termguicolors = true, background = "dark", guicursor = "a:block",
    updatetime = 50, timeoutlen = 150,
    scrolloff = 8, sidescrolloff = 8,
    winborder = "rounded", clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    conceallevel = 0, pumheight = 10, pumblend = 10,
    winblend = 28, swapfile = false, ruler = false,
    title = true, titlelen = 0,
}) do opt[k] = v end
opt.fillchars:append({
    eob = " ", stl = " ",
    horiz = " ", horizup = " ", horizdown = " ",
    vertleft = " ", vertright = " ", verthoriz = " ",
})
opt.shortmess:append("c")

for _, m in ipairs({
    { "n", "<leader>o", ":update<CR>:source<CR>", "Write and source file" },
    { "n", "<leader>w", function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
        vim.cmd.write()
    end, "Trim + save" },
    { "n", "<leader>q", ":exit<CR>", "Quit" },
    { "n", "<leader>a", function() require("harpoon"):list():add() end, "Harpoon add" },
    { "n", "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, "Harpoon menu" },
    { "n", "<C-h>", function() require("harpoon"):list():select(1) end, "Harpoon 1" },
    { "n", "<C-t>", function() require("harpoon"):list():select(2) end, "Harpoon 2" },
    { "n", "<C-n>", function() require("harpoon"):list():select(3) end, "Harpoon 3" },
    { "n", "<C-s>", function() require("harpoon"):list():select(4) end, "Harpoon 4" },
    { "n", "<leader>hx", function() require("harpoon"):list():clear() end, "Harpoon clear" },
    { "n", "<leader>ff", ":Pick files<CR>", "Pick: files" },
    { "n", "<leader>fg", ":Pick grep_live<CR>", "Pick: grep" },
    { "n", "<leader>fw", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, "Pick: word" },
    { "n", "<leader>fb", ":Pick buffers<CR>", "Pick: buffers" },
    { "n", "<leader>fr", ":Pick oldfiles<CR>", "Pick: recent" },
    { "n", "<leader>h", ":Pick help<CR>", "Pick: help" },
    { "n", "<leader>e", ":Oil<CR>", "Oil: explorer" },
    { "n", "<leader>ef", function() MiniFiles.open() end, "MiniFiles" },
    { "n", "<leader>wz", function() MiniMisc.zoom() end, "Zoom window" },
    { "n", "<leader>lf", vim.lsp.buf.format, "LSP: format" },
    { "n", "<leader>cm", ":Mason<CR>", "Open Mason" },
    { "n", "<leader>b", ":buffers<CR>", "List buffers" },
    { "n", "<leader>bn", ":bnext<CR>", "Next buffer" },
    { "n", "<leader>bp", ":bprev<CR>", "Prev buffer" },
    { "n", "<leader>bd", ":bdelete<CR>", "Delete buffer" },
    { "n", "<leader>bm", ":bmodified<CR>", "Modified buffers" },
    { { "n", "v" }, "d", '"_d', "Delete (no yank)" },
    { { "n", "v" }, "c", '"_c', "Change (no yank)" },
    { "n", "x", '"_x', "Cut (no yank)" },
    { "n", "<C-p>", function() vim.cmd('botright split term://powershell') end, "Open PowerShell" },
    { "n", "<leader>ca", function() vim.cmd('botright split term://ruff format && ruff clean') end, "Ruff clean" },
    { "n", "<leader>gg", function()
        if vim.fn.executable("lazygit") == 1 then
            vim.cmd("botright split term://lazygit")
        else
            vim.notify("lazygit not found", vim.log.levels.WARN)
        end
    end, "Lazygit" },
}) do vim.keymap.set(m[1], m[2], m[3], { desc = m[4] }) end

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
  keymaps = { q = "actions.close", l = "actions.select", h = "actions.parent", ["<leader>r"] = "actions.refresh" },
  view_options = { show_hidden = true },
})
require("harpoon").setup()
for _, mod in ipairs({
    "ai", "animate", "completion", "diff", "extra", "files", "git", "icons",
    "indentscope", "jump", "misc", "move", "pairs", "pick", "snippets",
    "tabline", "statusline", "trailspace"
}) do require("mini." .. mod).setup() end
require("mini.notify").setup({
    lsp_progress = { enable = true, duration_last = 1000 },
    window = { config = { border = "rounded" }, max_width_share = 0.4 },
})
vim.notify = require("mini.notify").make_notify()
require("mini.clue").setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' }, { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' }, { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' }, { mode = 'n', keys = "'" },
        { mode = 'n', keys = "`" }, { mode = 'x', keys = "'" },
        { mode = 'x', keys = "`" }, { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' }, { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' }, { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' }, { mode = 'x', keys = 'z' },
    },
    clues = {
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
    },
    window = {
        config = { border = "rounded" },
        delay = 200,
    },
})

vim.lsp.enable({ "lua_ls", "ruff-lsp", "pylsp", "pyright" })
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
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

require("vague").setup({ transparency = true })
require("gruvbox").setup({ terminal_colors = true, transparent_mode = false, contrast = "hard" })

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
local idx = 0

vim.keymap.set("n", "<leader>t", function()
    idx = (idx % #schemes) + 1
    set_colorscheme(schemes[idx])
end, { desc = "UI: Cycle colorschemes" })

set_colorscheme("retrobox")
