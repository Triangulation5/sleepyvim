-- nvim/lua/plugins/init.lua
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim",     version = "24cd29d", },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/Saghen/blink.cmp", version = "78336bc" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },

    -- { src = "https://github.com/gcmt/vessel.nvim" },
    -- { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/copilotlsp-nvim/copilot-lsp" },
})

-- require("vessel").setup({
--    create_commands = true,
--    commands = {
--        view_marks = "Marks",
--        view_jumps = "Jumps",
--        view_buffers = "Buffers"
--    }
-- })

require("mason").setup()
