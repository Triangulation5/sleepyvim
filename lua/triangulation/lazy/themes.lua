return {
    {
        "vague-theme/vague.nvim",
        commit = "24cd29d",
        -- priority = 1000
        lazy = false,
        config = function()
            require("vague")
            vim.cmd.colorscheme("vague")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        config = function()
            require("rose-pine").setup({ styles = { transparency = true } })
            -- vim.cmd.colorscheme("rose-pine-moon")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    }
}
