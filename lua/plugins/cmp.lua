-- nvim/lua/plugins/cmp.lua
require("codeium").setup({
    enable_cmp_source = true,
    virtual_text = {
        enabled = false,
    },
})

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
        menu = { border = 'single', winblend = 0, scrollbar = false },
        documentation = { auto_show = true, auto_show_delay_ms = 150 },
        ghost_text = { enabled = true }
    },
    sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets', 'codeium' },
        providers = {
            lsp = { module = 'blink.cmp.sources.lsp', score_offset = 100 },
            path = { module = 'blink.cmp.sources.path', score_offset = 80 },
            buffer = { module = 'blink.cmp.sources.buffer', score_offset = 70 },
            snippets = { module = 'blink.cmp.sources.snippets', score_offset = 90 },
            codeium = { name = "Codeium", module = "codeium.blink", async = true, score_offset = 110 },
        }
    },
    fuzzy = { implementation = 'lua' },
    signature = {
        enabled = true,
        trigger = { enabled = true },
        window = { border = 'single', winblend = 0 }
    },
});

local blink_highlights = {
    BlinkCmpKindFunction = { fg = "#3b82f6", bg = "#3b82f6", bold = true },
    BlinkCmpKindMethod = { fg = "#2563eb", bg = "#2563eb", bold = true },
    BlinkCmpKindVariable = { fg = "#22c55e", bg = "#22c55e" },
    BlinkCmpKindConstant = { fg = "#16a34a", bg = "#16a34a" },
    BlinkCmpKindValue = { fg = "#15803d", bg = "#15803d" },
    BlinkCmpKindField = { fg = "#4ade80", bg = "#4ade80" },
    BlinkCmpKindProperty = { fg = "#86efac", bg = "#86efac" },
    BlinkCmpKindClass = { fg = "#eab308", bg = "#eab308", bold = true },
    BlinkCmpKindInterface = { fg = "#facc15", bg = "#facc15", bold = true },
    BlinkCmpKindStruct = { fg = "#ca8a04", bg = "#ca8a04", bold = true },
    BlinkCmpKindTypeParameter = { fg = "#fde047", bg = "#fde047" },
    BlinkCmpKindModule = { fg = "#f97316", bg = "#f97316" },
    BlinkCmpKindPackage = { fg = "#fb923c", bg = "#fb923c" },
    BlinkCmpKindKeyword = { fg = "#ec4899", bg = "#ec4899" },
    BlinkCmpKindOperator = { fg = "#db2777", bg = "#db2777" },
    BlinkCmpKindSnippet = { fg = "#f43f5e", bg = "#f43f5e" },
    BlinkCmpKindText = { fg = "#a3a3a3", bg = "#a3a3a3" },
    BlinkCmpKindString = { fg = "#d4d4d4", bg = "#d4d4d4" },
    BlinkCmpKindEnum = { fg = "#9333ea", bg = "#9333ea" },
    BlinkCmpKindEnumMember = { fg = "#a855f7", bg = "#a855f7" },
    BlinkCmpKindConstructor = { fg = "#0ea5e9", bg = "#0ea5e9" },
    BlinkCmpKindBoolean = { fg = "#06b6d4", bg = "#06b6d4" },
    BlinkCmpKindNumber = { fg = "#0891b2", bg = "#0891b2" }
}

for k, v in pairs(blink_highlights) do
    vim.api.nvim_set_hl(0, k, v)
end
