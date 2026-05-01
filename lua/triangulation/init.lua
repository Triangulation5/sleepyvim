-- Installs the plugins and contains require statements and autocommands.
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim", version = "24cd29d" },
    { src = "https://github.com/Saghen/blink.cmp", version = "78336bc" }, { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
})

require("triangulation.options")
require("triangulation.keymaps")
require("triangulation.macros")


for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/triangulation/plugins")) do
    if file:match("%.lua$") then
        require("triangulation.plugins." .. file:gsub("%.lua$", ""))
    end
end

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.rs", callback = function() local ok, _ = pcall(vim.lsp.buf.inlay_hint, 0, true) if not ok then end end })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = "@boolean", timeout = 150, }) end, })
