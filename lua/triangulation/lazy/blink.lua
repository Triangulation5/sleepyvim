return {
    {
        "Saghen/blink.cmp",
        version = "v1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        config = function()
            require('blink.cmp').setup({
                keymap = {
                    ['<CR>'] = { 'accept', 'fallback' },
                    ['<Tab>'] = { 'select_next', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                    ['<C-N>'] = { 'select_next', 'fallback' },
                    ['<C-P>'] = { 'select_prev', 'fallback' },
                    ['<C-K>'] = false,
                    ['<C-Y>'] = false,
                    ['<C-E>'] = false
                },
                completion = {
                    accept = { auto_brackets = { enabled = true } },
                    list = { selection = { preselect = true, auto_insert = false } },
                    menu = { border = 'none', winblend = 0, scrollbar = false },
                    documentation = { auto_show = true, auto_show_delay_ms = 150, window = { border = "none" } },
                    ghost_text = { enabled = false }
                },
                sources = {
                    default = { 'lsp', 'path', 'buffer', 'snippets' },
                    providers = {
                        lsp = { module = 'blink.cmp.sources.lsp', score_offset = 100 },
                        path = { module = 'blink.cmp.sources.path', score_offset = 80 },
                        buffer = { module = 'blink.cmp.sources.buffer', score_offset = 70 },
                        snippets = { module = 'blink.cmp.sources.snippets', score_offset = 90 },
                    }
                },
                fuzzy = { implementation = 'lua' },
                signature = { enabled = true, trigger = { enabled = true }, window = { border = 'none', winblend = 0 } },
            });
        end
    },
    {
      "rafamadriz/friendly-snippets",
      lazy = true,
    }
}
