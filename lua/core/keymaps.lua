-- nvim/lua/core/keymaps.lua
local keymaps = {
    { "n", "<leader>w", function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
        vim.cmd.write()
    end, "+1 Trim & Save" },
    { "n", "<leader>q", ":q<CR>", "Quit" },
    { "n", "<leader>wq", function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
        vim.cmd("xa")
    end, "Save & Quit" },
    { "n", "<leader>f", ":Pick files<CR>", "Pick: Files" },
    { "n", "<leader>fg", ":Pick grep_live<CR>", "Pick: Grep" },
    { "n", "<leader>fw", function()
        MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
    end, "Pick: Word" },
    { "n", "<leader>fb", ":Pick buffers<CR>", "Pick: Buffers" },
    { "n", "<leader>fc", ":Pick colorschemes<CR>", "Pick: Colorschemes" },
    { "n", "<leader>h", ":Pick help<CR>", "Pick: Help" },
    { "n", "<leader>e", ":Oil<CR>", "Oil: Explorer" },
    { "n", "<leader>ef", function() MiniFiles.open() end, "MiniFiles" },
    { "n", "<leader>wz", function() MiniMisc.zoom() end, "Zoom Window" },
    { "n", "<leader>wr", function() MiniMisc.resize_window() end, "Resize Window" },
    { { "n", "x", "o" }, "<leader>j", function() MiniJump2d.start() end, "MiniJump2d: Start jump" },
    { "n", "<leader>lf", vim.lsp.buf.format, "LSP: Format" },
    { "n", "<leader>cm", ":Mason<CR>", "Open Mason" },
    { "n", "<leader>bn", ":bn<CR>", "Next Buffer" },
    { "n", "<leader>tn", ":tabn<CR>", "Next Tab" },
    { "n", "<leader>bp", ":bp<CR>", "Prev Buffer" },
    { "n", "<leader>tp", ":tabp<CR>", "Prev Tab" },
    { "n", "<leader>bd", ":bd<CR>", "Delete Buffer" },
    { "n", "<leader>tc", ":tabc<CR>", "Close Tab" },
    { "n", "<leader>bf", ":bd!<CR>", "Force Delete Buffer" },
    { "n", "<leader>ba", ":%bw<CR>", "Wipeout All Buffers" },
    { "n", "<leader>tf", ":tabo<CR>", "Close All Other Tabs" },
    { "n", "<leader>d", function() vim.diagnostic.open_float(nil, { scope = "l" }) end, "+1 Show Diagnostic" },
    { "n", "<leader>da", function() vim.diagnostic.setqflist({ open = true, title = "Diagnostics" }) end, "Show Quickfix" },
    { { "n", "v" }, "d", '"_d', "Delete (no yank)" },
    { { "n", "v" }, "c", '"_c', "Change (no yank)" },
    { "n", "<C-p>", function() vim.cmd('botright split term://powershell') end, "PowerShell" },
    { "n", "<leader>ti", function()
        vim.notify(string.format("Time: %s | Date: %s | %s", os.date("%I:%M:%S %p"), os.date("%Y-%m-%d"), os.date("%A")),
            vim.log.levels.INFO, { title = "Clock" })
    end, "Time" },
    { "n", "x", '"_x', "Cut (no yank)" },
    { "n", "<leader>y", function()
        if vim.fn.executable("yazi") == 1 then
            local buf = vim.api.nvim_create_buf(false, true)
            local w, h = math.floor(vim.o.columns * 0.9), math.floor(vim.o.lines * 0.85)
            local r, c = math.floor((vim.o.lines - h) / 2), math.floor((vim.o.columns - w) / 2)
            local win = vim.api.nvim_open_win(buf, true,
                { relative = "editor", width = w, height = h, row = r, col = c, style = "minimal", border = "rounded" })
            vim.cmd("terminal powershell yazi")
        else
            vim.notify("yazi not found", vim.log.levels.WARN)
        end
    end, "Yazi" },
    { "n", "<leader>gg", function()
        if vim.fn.executable("lazygit") == 1 then
            vim.cmd("botright split term://lazygit")
        else
            vim.notify("lazygit not found", vim.log.levels.WARN)
        end
    end, "Lazygit" },
    { "n", "<leader>g", function() end, "Git Integration" },
    { "n", "<leader>u", "<cmd>UndotreeToggle<CR>", "Toggle Undotree" },
}

for _, m in ipairs(keymaps) do
    vim.keymap.set(m[1], m[2], m[3], { desc = m[4] })
end

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>t", function()
    _G.idx = (_G.idx % #_G.schemes) + 1
    _G.set_colorscheme(_G.schemes[_G.idx], true)
end, { desc = "Cycle Colorschemes" })

vim.keymap.set("n", "<leader>tt", function()
    _G.transparency_enabled = not _G.transparency_enabled
    _G.set_colorscheme(_G.current_scheme, false)
    vim.notify("Transparency: " .. (_G.transparency_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle Transparency" })

vim.keymap.set("n", "<leader>ta", function()
    _G.set_cursor_animation(not _G.cursor_anim_enabled)
    vim.notify("Cursor Animation " .. (_G.cursor_anim_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Toggle Cursor Animation" })
