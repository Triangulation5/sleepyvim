if vim.loader then vim.loader.enable() end; vim.g.loaded_netrw = 1; vim.g.loaded_netrwPlugin = 1; vim.g.mapleader = " "; local opt = vim.opt
for k, v in pairs({
    number = true, relativenumber = true, numberwidth = 4,
    signcolumn = "yes",
    tabstop = 4, softtabstop = 4, shiftwidth = 4, expandtab = true,
    smartindent = true, breakindent = true,
    list = true,listchars = { tab = "  ", trail = "·", extends = "›", precedes = "‹", nbsp = "␣" }, smartcase = true,
    hlsearch = false, incsearch = true,
    background = "dark", guicursor = "a:block",
    updatetime = 50, timeoutlen = 150,
    scrolloff = 8, sidescrolloff = 8,
    winborder = "rounded", clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    conceallevel = 0, pumheight = 10, pumblend = 15,
    winblend = 25, swapfile = false, shada = "", ruler = false,
    title = true, titlelen = 0,
}) do opt[k] = v end ; opt.fillchars:append({ eob = " ", stl = " ", horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " ", verthoriz = " " }); local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"; if vim.fn.empty(vim.fn.glob(mini_path)) > 0 then vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/echasnovski/mini.nvim", mini_path}) end; vim.cmd("packadd mini.nvim"); local add = require("mini.deps").add; add({ source = "nvim-lua/plenary.nvim" }); add({ source = "ThePrimeagen/harpoon", checkout = "harpoon2" }); local harpoon = require("harpoon"); harpoon:setup()

for _, m in ipairs({
    { "n", "<leader>w", function() MiniTrailspace.trim() MiniTrailspace.trim_last_lines() vim.cmd.write() end, "+1 Trim & Save" },
    { "n", "<leader>q", ":exit<CR>", "Quit" },
    { "n", "<leader>a", function() harpoon:list():add() end, "Harpoon Add" },
    { "n", "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, "Harpoon Menu" },
    { "n", "<C-h>", function() harpoon:list():select(1) end, "Harpoon 1" },
    { "n", "<C-t>", function() harpoon:list():select(2) end, "Harpoon 2" },
    { "n", "<C-n>", function() harpoon:list():select(3) end, "Harpoon 3" },
    { "n", "<C-s>", function() harpoon:list():select(4) end, "Harpoon 4" },
    { "n", "<leader>hx", function() require("harpoon"):list():clear() end, "Harpoon Clear" },
    { "n", "<leader>ff", ":Pick files<CR>", "Pick: Files" }, { "n", "<leader>f", function() end, "+5 MiniPick"},
    { "n", "<leader>fg", ":Pick grep_live<CR>", "Pick: Grep" },
    { "n", "<leader>fw", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, "Pick: Word" },
    { "n", "<leader>fb", ":Pick buffers<CR>", "Pick: Buffers" },
    { "n", "<leader>fc", ":Pick colorschemes<CR>", "Pick: Colorschemes"},
    { "n", "<leader>h", ":Pick help<CR>", "+1 Pick: Help" },
    { "n", "<leader>e", ":Oil<CR>", "+1 Oil: Explorer" },
    { "n", "<leader>ef", function() MiniFiles.open() end, "MiniFiles" },
    { "n", "<leader>wz", function() MiniMisc.zoom() end, "Zoom Window" }, { { "n", "x", "o" }, "<leader>j", function() MiniJump2d.start() end, "MiniJump2d: Start jump" },
    { "n", "<leader>lf", vim.lsp.buf.format, "LSP: Format" }, { "n", "<leader>l", function() end, "+1 Lsp" },
    { "n", "<leader>cm", ":Mason<CR>", "Open Mason" }, { "n", "<leader>c", function() end, "+2 Code Tools" },
    { "n", "<leader>b", ":buffers<CR>", "+4 Buffers" },
    { "n", "<leader>bn", ":bnext<CR>", "Next Buffer" },
    { "n", "<leader>bp", ":bprev<CR>", "Prev Buffer" },
    { "n", "<leader>bd", ":bdelete<CR>", "Delete Buffer" },
    { "n", "<leader>bm", ":bmodified<CR>", "Modified Buffers" },
    { "n", "<leader>d", function() vim.diagnostic.open_float(nil, { scope = "l" }) end, "+1 Show Diagnostic" },
    { "n", "<leader>da", function() vim.diagnostic.setqflist({ open = true, title = "Diagnostics"}) end, "Show All Diagnostics"},
    { { "n", "v" }, "d", '"_d', "Delete (no yank)" },
    { { "n", "v" }, "c", '"_c', "Change (no yank)" },
    { "n", "x", '"_x', "Cut (no yank)" },
    { "n", "<C-p>", function() vim.cmd('botright split term://powershell') end, "Open PowerShell" },
    { "n", "<leader>ca", function() local ft, cmds = vim.bo.filetype, { python = "ruff format && ruff clean", go = "gofmt -w % && goimports -w %", } local cmd = cmds[ft] if not cmd then return vim.notify("No formatter for " .. ft, vim.log.levels.WARN) end vim.fn.jobstart(cmd, { on_exit = function() vim.schedule(function() vim.cmd("edit!") vim.notify("Formatted and cleaned " .. ft .. ", buffer reloaded") end) end, }) end, "Code Actions" },
    { "n", "<leader>gg", function() if vim.fn.executable("lazygit") == 1 then vim.cmd("botright split term://lazygit") else vim.notify("lazygit not found", vim.log.levels.WARN)end end, "Lazygit" }, { "n", "<leader>g", function() end, "+1 Git Integration" },
}) do vim.keymap.set(m[1], m[2], m[3], { desc = m[4] }) end

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
})
require("mason").setup()
require("oil").setup({ keymaps = { q = "actions.close", l = "actions.select", h = "actions.parent", ["<leader>r"] = "actions.refresh" }, view_options = { show_hidden = true } })
for _,m in ipairs({"ai","animate","bracketed","bufremove","comment","completion","diff","extra","git","icons","jump","jump2d","misc","move","pairs","pick","snippets","statusline","tabline","trailspace"}) do require("mini."..m).setup() end
MiniIcons.tweak_lsp_kind(); require("mini.notify").setup({ lsp_progress = { enable = true, duration_last = 1000 }, window = { config = { border = "rounded" }, max_width_share = 0.6 } }) ; require("mini.indentscope").setup({ draw = { animation = require("mini.indentscope").gen_animation.quadratic({ easing = 'in-out', duration = 20 }) }, symbol = "│", options = { try_as_border = true } }); require("mini.hipatterns").setup({ highlighters = { fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" }, hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" }, todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" }, note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" }, hex_color = require("mini.hipatterns").gen_highlighter.hex_color() } }); require("mini.files").setup({ windows = { preview = true, width_focus = 50, width_nofocus = 15, width_preview = 30, }, })

vim.notify = require("mini.notify").make_notify()

vim.lsp.enable({ "lua_ls","pyright", "ruff", "gopls" })
vim.lsp.config("lua_ls", { settings = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } }); vim.lsp.config("gopls", { settings = { gopls = { analyses = { unusedparams = true, shadow = true, }, staticcheck = true, }, }, })
vim.api.nvim_create_autocmd("LspAttach", { callback = function(ev) local client = vim.lsp.get_client_by_id(ev.data.client_id) if client and client:supports_method("textDocument/completion") then vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true }) end end, }) ; vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true }); vim.diagnostic.config { virtual_text = { prefix = "■", spacing = 4 }, signs = true, underline = true, update_in_insert = false, severity_sort = true }

require("vague").setup({ transparency = true }); require("rose-pine").setup({ variant = "auto", dark_variant = "main", dim_inactive_windows = true, extend_background_behind_borders = true, styles = { bold = true, italic = true, transparency = false }, groups = { border = "highlight_med", background = "base", panel = "surface", comment = "muted", link = "iris", punctuation = "subtle", error = "love", hint = "iris", info = "foam", warn = "gold", git_add = "foam", git_change = "rose", git_delete = "love", git_dirty = "rose", git_ignore = "muted", git_merge = "iris", git_rename = "pine", git_stage = "iris", git_text = "rose", head = "iris", hunk = "rose" } })

local transparency_enabled, current_scheme, idx = false, nil, 1; local schemes = {  "rose-pine-main", "vague", "tokyonight-night", "retrobox",  "rose-pine-moon" }; local apply_transparency = function() if transparency_enabled then for _, group in ipairs({ "Normal", "NormalFloat", "SignColumn", "VertSplit", "StatusLine", "StatusLineNC", "TabLine", "TabLineSel", "TabLineFill", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb", "CursorLine", "LineNr", "CursorLineNr", "MsgArea", "Folded", "FoldColumn" }) do vim.api.nvim_set_hl(0, group, { bg = "NONE" }) end end end; local set_colorscheme = function(name, notify) if not pcall(vim.cmd.colorscheme, name) then vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.ERROR) return end if notify and name ~= current_scheme then vim.notify("Switched Colorscheme: " .. name, vim.log.levels.INFO) end current_scheme = name apply_transparency() end

vim.keymap.set("n", "<leader>t", function() idx = (idx % #schemes) + 1; set_colorscheme(schemes[idx], true) end, { desc = "UI: Cycle Colorschemes" }); vim.keymap.set("n", "<leader>tt", function() transparency_enabled = not transparency_enabled; set_colorscheme(current_scheme, false); vim.notify("Transparency: " .. (transparency_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO) end, { desc = "Toggle Transparency" })

set_colorscheme(schemes[idx], false)
