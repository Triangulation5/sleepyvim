vim.cmd([[set mouse=]])
if vim.loader then vim.loader.enable() end; vim.g.mapleader = " ";vim.opt.shortmess:append("I"); local opt = vim.opt for k, v in pairs({ nu = true, rnu = true, nuw = 4,
    scl = "yes",
    ts = 4, sts = 4, sw = 4, et = true,
    si = true, bri = true,
    ic = true, scs = true, hls = false, is = true,
    bg = "dark", gcr = "a:block",
    ut = 50, tm = 250,
    so = 8, siso = 8,
    winborder = "rounded", cb = "unnamedplus",
    cot = { "menuone", "noselect" },
    cole = 0, ph = 10, pb = 0,
    winbl = 0, swf = false, sd = "", ru = false,
    title = true, titlestring = "nvim", titlelen = 0,
}) do opt[k] = v end

for _, m in ipairs({
    { "n", "<leader>w", function() require("mini.trailspace").trim(); require("mini.trailspace").trim_last_lines(); vim.cmd.update() end, "Trim & Save" }, { "n", "<leader>q", ":q<CR>", "Quit" }, { "n", "<leader>wq", function() require("mini.trailspace").trim(); require("mini.trailspace").trim_last_lines(); vim.cmd("xa") end, "Save & Quit" },
    { "n", "<leader>f", ":Pick files<CR>", "Pick: Files" },
    { "n", "<leader>fg", ":Pick grep_live<CR>", "Pick: Grep" },
    { "n", "<leader>fw", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, "Pick: Word" },
    { "n", "<leader>fb", ":Pick buffers<CR>", "Pick: Buffers" },
    { "n", "<leader>h", ":Pick help<CR>", "Pick: Help" }, { "n", "<leader>k", function() require("mini.extra").pickers.keymaps() end, "Pick: Keymaps" },
    { { "n", "v", "x" }, "<leader>n", ":norm ", "Enter Norm Commmand" },
    { "n", "<leader>e", function() oil().open() end, "Oil: Explorer" },
    { "n", "<leader>ef", function() require("mini.files").setup({ windows = { preview = true }}); require("mini.files").open() end, "MiniFiles" },
    { "n", "<leader>wz", function() require("mini.misc").zoom() end, "Zoom Window" }, { "n", "<leader>wr", function() require("mini.misc").resize_window() end, "Resize Window" }, { { "n", "x", "o" }, "<leader>j", function() require("mini.jump2d").start() end, "MiniJump2d: Start jump" }, { { "n", "x" }, "<C-d>", "<C-d>zz", "Scroll Down" }, { { "n", "x" }, "<C-u>", "<C-u>zz", "Scroll Up" }, { "n", "n", "nzzzv", "Next search result" }, { "n", "N", "Nzzzv", "Previous search result" },
    { "n", "<leader>lf", vim.lsp.buf.format, "LSP: Format" }, { "n", "<leader>i", [[<Cmd>tabedit .gitignore<CR>]], "Edit .gitignore" }, { "n", "<leader>p", ":TypstPreview<CR>", "Preview Typst File" },
    { "n", "<leader>cm", function() vim.cmd("Mason") end, "Open Mason" },
    { "n", "<leader>bn", ":bn<CR>", "Next Buffer" }, { "n", "<leader>tn", ":tabn<CR>", "Next Tab" },
    { "n", "<leader>bp", ":bp<CR>", "Prev Buffer" }, { "n", "<leader>tp", ":tabp<CR>", "Prev Tab" },
    { "n", "<leader>bd", ":bd<CR>", "Delete Buffer" }, { "n", "<leader>tc", ":tabc<CR>", "Close Tab" },
    { "n", "<leader>bf", ":bd!<CR>", "Force Delete Buffer" }, { "n", "<leader>ba", ":%bw<CR>", "Wipeout All Buffers" }, { "n", "<leader>tf", ":tabo<CR>", "Close All Other Tabs"},
    { "n", "<leader>da", function() vim.diagnostic.setqflist({ open = true, title = "Diagnostics"}) end, "Show Diagnostics in Quickfix"}, { "n", "<C-q>", ":copen<CR>", "Opens Quickfix"},
    { { "n", "v" }, "d", '"_d', "Delete (no yank)" },
    { { "n", "v" }, "c", '"_c', "Change (no yank)" },
    { "n", "<M-t>", function() vim.cmd('botright split term://powershell') end, "PowerShell" }, { "n", "<leader>ti", function() vim.notify(string.format("Time: %s | Date: %s | %s", os.date("%I:%M:%S %p"), os.date("%Y-%m-%d"), os.date("%A")), vim.log.levels.INFO, { title = "Clock" }) end, "Time" },
    { "n", "x", '"_x', "Cut (no yank)" }, { "n", "<leader>y", function() if vim.fn.executable("yazi")==1 then local buf=vim.api.nvim_create_buf(false,true); local w,h=math.floor(vim.o.columns*0.9),math.floor(vim.o.lines*0.85); local r,c=math.floor((vim.o.lines-h)/2),math.floor((vim.o.columns-w)/2); local win=vim.api.nvim_open_win(buf,true,{relative="editor",width=w,height=h,row=r,col=c,style="minimal",border="rounded"}); vim.cmd("terminal powershell yazi") else vim.notify("yazi not found",vim.log.levels.WARN) end end, "Yazi" }, { "n", "<leader>g", function() if vim.fn.executable("glow")==1 then local buf=vim.api.nvim_create_buf(false,true); local w,h=math.floor(vim.o.columns*0.9),math.floor(vim.o.lines*0.85); local r,c=math.floor((vim.o.lines-h)/2),math.floor((vim.o.columns-w)/2); local win=vim.api.nvim_open_win(buf,true,{relative="editor",width=w,height=h,row=r,col=c,style="minimal",border="rounded"}); vim.cmd("terminal powershell glow") else vim.notify("glow not found",vim.log.levels.WARN) end end, "Glow" },
    { "n", "<leader>u", "<cmd>UndotreeToggle<CR>", "Toggle Undotree" }, { "n", "<leader>a", ":edit #<CR>", "Switch to alternative buffer"},
}) do vim.keymap.set(m[1], m[2], m[3], { desc = m[4] }) end

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

vim.opt.undofile = true; local u = vim.fn.stdpath("state") .. "/undo"; vim.opt.undodir = u; vim.fn.mkdir(u, "p"); local t = u .. "/.last_cleanup"; local n = os.time(); local l = vim.fn.filereadable(t) == 1 and tonumber(vim.fn.readfile(t)[1]) or 0; if n - l > 86400 then for _, f in ipairs(vim.fn.glob(u .. "/*", true, true)) do if f ~= t then os.remove(f) end end; vim.fn.writefile({ tostring(n) }, t) end; for i = 1, 8 do vim.keymap.set("n","<Leader>"..i,function()local b=vim.fn.getbufinfo({buflisted=1})[i]if b then vim.cmd.buffer(b.bufnr)end end,{silent=true});vim.keymap.set("t","<Leader>"..i,function()local b=vim.fn.getbufinfo({buflisted=1})[i]if b then vim.cmd("stopinsert");vim.cmd.buffer(b.bufnr)end end,{silent=true}) end; vim.g.undotree_WindowLayout = 3

for _,m in ipairs({"ai","bracketed","cmdline","diff","git","move","pairs","pick","surround"}) do require("mini."..m).setup() end
-- MiniIcons.tweak_lsp_kind(); MiniIcons.mock_nvim_web_devicons()
require("mini.notify").setup({ lsp_progress = { enable = true, duration_last = 150 }, window = { config = { border = "rounded" }, max_width_share = 0.6 } }) ; require("mini.tabline").setup({ show_icons = false, tabpage_section = "right" }); local lt_opts = { action = 'open', pair = '<>', neigh_pattern = '\r.', register = { cr = false }, }; MiniPairs.map('i', '<', lt_opts); local gt_opts = { action = 'close', pair = '<>', register = { cr = false } }; MiniPairs.map('i', '>', gt_opts); local map_typ = function() MiniPairs.map_buf(0, 'i', '$', { action = 'closeopen', pair = '$$' }) end; vim.api.nvim_create_autocmd( 'FileType', { pattern = 'typst', callback = map_typ }); local mg = require("mini.git"); mg.enable(); local s = function(f) local d = mg.get_buf_data() if d and d.head then pcall(f) end end; vim.keymap.set("n", "<leader>gh", function() s(mg.show_range_history) end, { desc = "Git History" }); vim.keymap.set("n", "<leader>gc", function() s(mg.show_at_cursor) end, { desc = "Git Cursor" }); vim.keymap.set("n", "<leader>gd", function() s(mg.show_diff_source) end, { desc = "Git Diff" })

vim.notify = require("mini.notify").make_notify()

require("mason").setup(); oil_loaded, oil = false, function() if oil_loaded then return require("oil") end  require("oil").setup({ default_file_explorer = true, columns = { "icon" }, keymaps = { q = "actions.close", l = "actions.select", h = "actions.parent", ["<leader>r"] = "actions.refresh" }, use_default_keymaps = true, view_options = { show_hidden = false, is_hidden_file = function(name, bufnr) return name:match("^%.") ~= nil end, { "name", "asc" } }, float = { padding = 2, max_width = 0, max_height = 0, border = "rounded", win_options = { winblend = 0 }, get_win_title = nil, preview_split = "auto", override = function(conf) return conf end }, preview_win = { update_on_cursor_moved = true, preview_method = "fast_scratch", disable_preview = function() return false end, win_options = {} }, confirmation = { max_width = 0.9, min_width = { 40, 0.4 }, width = nil, max_height = 0.9, min_height = { 5, 0.1 }, height = nil, border = "rounded", win_options = { winblend = 0 } }, progress = { max_width = 0.9, min_width = { 40, 0.4 }, width = nil, max_height = { 10, 0.9 }, min_height = { 5, 0.1 }, height = nil, border = "rounded", minimized_border = "rounded", win_options = { winblend = 0 } }, ssh = { border = "rounded" }, keymaps_help = { border = "rounded" } }) oil_loaded = true return require("oil") end

vim.cmd.colorscheme("vague"); require("vague").setup({ transparency = false })

vim.api.nvim_create_autocmd("LspAttach", { callback = function(ev) local client = vim.lsp.get_client_by_id(ev.data.client_id); if client then vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc"); if client:supports_method("textDocument/completion") then vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true }) end end end })
vim.lsp.enable({ "pyright", "ruff", "gopls", "marksman", "vtsls", "tinymist" })
vim.lsp.config("gopls", { settings = { gopls = { completeUnimported = true, usePlaceholders = true, analyses = { unusedparams = true, shadow = true }, staticcheck = true } } }); vim.lsp.config("vtsls", { root_dir = vim.fs.root(0, { "jsconfig.json", "package.json", "tsconfig.js" }) }); vim.lsp.config("tinymist", { settings = { formatterMode = "typstyle", exportPdf = "never" } }); vim.diagnostic.config({ virtual_text = { prefix = "■", spacing = 6, hl_mode = "combine", format = function(d) return string.format("%s [%s]", d.message, d.source or d.code or "") end }, signs = true, underline = true, update_in_insert = false, severity_sort = true, float = { border = "rounded", header = "Diagnostic(s):", source = "always", focusable = true } }); local typst_loaded = false; vim.api.nvim_create_autocmd("FileType", { pattern = "typst", callback = function() if typst_loaded then return end typst_loaded = true vim.schedule(function() vim.cmd.packadd("typst-preview.nvim") local ok, typst = pcall(require, "typst-preview") if not ok then print("typst-preview failed to load") return end typst.setup({}) print("typst-preview initialized") end) end, })
