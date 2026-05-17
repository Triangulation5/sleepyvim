return {
    {
        "vague-theme/vague.nvim",
        commit = "24cd29d",
        lazy = true,
        config = function()
            require("vague")
            -- vim.cmd.colorscheme("vague")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        config = function()
            require("rose-pine").setup({ styles = { transparency = true } })
            vim.cmd.colorscheme("rose-pine-moon")
            vim.opt.colorcolumn = "80"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    }
}
