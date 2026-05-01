local mg = require("mini.git")
local s = function(f) local d = mg.get_buf_data() if d and d.head then pcall(f) end end

for _, m in ipairs({
    { "n", "<leader>w", function() MiniTrailspace.trim() MiniTrailspace.trim_last_lines() vim.cmd.write() end, "+1 Trim & Save" }, { "n", "<leader>q", ":q<CR>", "Quit" }, { "n", "<leader>wq", function() MiniTrailspace.trim() MiniTrailspace.trim_last_lines() vim.cmd("xa") end, "Save & Quit" },
    { "n", "<leader>f", function() require('telescope.builtin').find_files() end, "Telescope: Files" },
    { "n", "<leader>fg", function() require('telescope.builtin').live_grep() end, "Telescope: Grep" },
    { "n", "<leader>fb", function() require('telescope.builtin').buffers() end, "Telescope: Buffers" },
    { "n", "<leader>h", function() require('telescope.builtin').help_tags() end, "Telescope: Help" },
    { "n", "<leader>fd", function() require('telescope.builtin').diagnostics() end, "Telescope: Diagnostics" },
    { "n", "<leader>fr", function() require('telescope.builtin').lsp_references() end, "Telescope: References" }, { "n", "<leader>st", function() require('telescope.builtin').builtin() end, "Telescope: Builtin" },
    { "n", "<leader>fa", ":lua vim.lsp.buf.code_action()<CR>", "Telescope: Code Actions" },
    { "n", "<leader>e", ":Oil<CR>", "Oil: Explorer" },
    { "n", "<leader>ef", function() MiniFiles.open() end, "MiniFiles" },
    { "n", "<leader>wz", function() MiniMisc.zoom() end, "Zoom Window" }, { "n", "<leader>wr", function() MiniMisc.resize_window() end, "Resize Window"}, { { "n", "x", "o" }, "<leader>j", function() MiniJump2d.start() end, "MiniJump2d: Start jump" }, { { "n", "x" }, "<C-d>", "<C-d>zz", "Scroll Down" }, { { "n", "x" }, "<C-u>", "<C-u>zz", "Scroll Up" },
    { "n", "<leader>lf", vim.lsp.buf.format, "LSP: Format" },
    { "n", "<leader>cm", ":Mason<CR>", "Open Mason" },
    { "n", "<leader>bn", ":bn<CR>", "Next Buffer" }, { "n", "<leader>tn", ":tabn<CR>", "Next Tab" },
    { "n", "<leader>bp", ":bp<CR>", "Prev Buffer" }, { "n", "<leader>tp", ":tabp<CR>", "Prev Tab" },
    { "n", "<leader>bd", ":bd<CR>", "Delete Buffer" }, { "n", "<leader>tc", ":tabc<CR>", "Close Tab" },
    { "n", "<leader>bf", ":bd!<CR>", "Force Delete Buffer" }, { "n", "<leader>ba", ":%bw<CR>", "Wipeout All Buffers" }, { "n", "<leader>tf", ":tabo<CR>", "Close All Other Tabs"},
    { "n", "<leader>d", function() vim.diagnostic.open_float(nil, { scope = "l" }) end, "+1 Show Diagnostic" }, { "n", "<leader>da", function() vim.diagnostic.setqflist({ open = true, title = "Diagnostics"}) end, "Show Diagnostics in Quickfix"}, { "n", "<C-q>", ":copen<CR>", "Opens Quickfix"},
    { { "n", "v" }, "d", '"_d', "Delete (no yank)" },
    { { "n", "v" }, "c", '"_c', "Change (no yank)" },
    { "n", "<C-p>", function() vim.cmd('botright split term://powershell') end, "PowerShell" }, { "n", "<leader>ti", function() vim.notify(string.format("Time: %s | Date: %s | %s", os.date("%I:%M:%S %p"), os.date("%Y-%m-%d"), os.date("%A")), vim.log.levels.INFO, { title = "Clock" }) end, "Time" },
    { "n", "x", '"_x', "Cut (no yank)" }, { "n", "<leader>y", function() if vim.fn.executable("yazi")==1 then local buf=vim.api.nvim_create_buf(false,true); local w,h=math.floor(vim.o.columns*0.9),math.floor(vim.o.lines*0.85); local r,c=math.floor((vim.o.lines-h)/2),math.floor((vim.o.columns-w)/2); local win=vim.api.nvim_open_win(buf,true,{relative="editor",width=w,height=h,row=r,col=c,style="minimal",border="rounded"}); vim.cmd("terminal powershell yazi") else vim.notify("yazi not found",vim.log.levels.WARN) end end, "Yazi" },
    { "n", "<leader>u", "<cmd>UndotreeToggle<CR>", "Toggle Undotree" }, { "n", "<leader>a", ":edit #<CR>", "Switch to alternative buffer"},
}) do vim.keymap.set(m[1], m[2], m[3], { desc = m[4] }) end

vim.keymap.set("n", "<leader>gh", function() s(mg.show_range_history) end, { desc = "Git History" })
vim.keymap.set("n", "<leader>gc", function() s(mg.show_at_cursor) end, { desc = "Git Cursor" })
vim.keymap.set("n", "<leader>gd", function() s(mg.show_diff_source) end, { desc = "Git Diff" })

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

for i = 1, 8 do vim.keymap.set("n","<Leader>"..i,function()local b=vim.fn.getbufinfo({buflisted=1})[i]if b then vim.cmd.buffer(b.bufnr)end end,{silent=true});vim.keymap.set("t","<Leader>"..i,function()local b=vim.fn.getbufinfo({buflisted=1})[i]if b then vim.cmd("stopinsert");vim.cmd.buffer(b.bufnr)end end,{silent=true})end
