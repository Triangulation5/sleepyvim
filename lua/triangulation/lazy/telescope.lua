return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        cmd = "Telescope",
        config = function()
            require("telescope").setup({
                defaults = {
                    preview = { treesitter = false },
                    sorting_strategy = "ascending",
                    prompt_prefix = "» ",
                    selection_caret = "  ",
                    borderchars = { "", "", "", "", "", "", "", "" },
                    path_displays = { "smart" },
                    layout_config = { height = 100, width = 400, prompt_position = "top", preview_cutoff = 40 },
                    history = false,
                }
            })
            require("telescope").load_extension("ui-select")
        end
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = true,
    }
}
