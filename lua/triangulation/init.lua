require("triangulation.lazy_init")
require("triangulation.options")
require("triangulation.keymaps")
require("triangulation.macros")

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.rs", callback = function() local ok, _ = pcall(vim.lsp.buf.inlay_hint, 0, true) if not ok then end end })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = "@boolean", timeout = 150, }) end, })
