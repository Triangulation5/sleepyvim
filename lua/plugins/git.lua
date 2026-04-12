-- nvim/lua/plugins/git.lua
local mg = require("mini.git")
mg.enable()

local s = function(f)
    local d = mg.get_buf_data()
    if d and d.head then
        pcall(f)
    end
end

vim.keymap.set("n", "<leader>gh", function() s(mg.show_range_history) end, { desc = "Git History" })
vim.keymap.set("n", "<leader>gc", function() s(mg.show_at_cursor) end, { desc = "Git Cursor" })
vim.keymap.set("n", "<leader>gd", function() s(mg.show_diff_source) end, { desc = "Git Diff" })
