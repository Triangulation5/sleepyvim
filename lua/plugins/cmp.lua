-- nvim/lua/plugins/cmp.lua
require("copilot-lsp").setup({
  nes = {
    move_count_threshold = 3,
  },
})

vim.g.copilot_nes_enabled = true
vim.api.nvim_create_user_command("CopilotToggle", function()
  vim.g.copilot_nes_enabled = not vim.g.copilot_nes_enabled
  local ok, config = pcall(require, "copilot-lsp.config")
  if ok and config.options then
    config.options.nes.enabled = vim.g.copilot_nes_enabled
  end

  if not vim.g.copilot_nes_enabled then
    pcall(function() require("copilot-lsp.nes").clear() end)
  end

  vim.notify("Copilot NES: " .. (vim.g.copilot_nes_enabled and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, {})

vim.keymap.set("n", "<leader>ct", ":CopilotToggle<CR>", { desc = "Toggle Copilot NES" })

require('blink.cmp').setup({
    keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = {
          function(cmp)
            local col = vim.fn.col('.') - 1
            if col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s') then
                return false
            end

            if vim.g.copilot_nes_enabled == false then
                return false
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local nes = require("copilot-lsp.nes")

            local state = vim.b[bufnr].nes_state

            if state then
              cmp.hide()

              local ok = nes.apply_pending_nes()
              if ok then
                nes.walk_cursor_end_edit()
                return true
              end

              return false
            end

            if cmp.visible() then
              return cmp.select_and_accept()
            end

            if cmp.snippet_active() then
              return cmp.accept()
            end

            return false
          end,
          'snippet_forward',
          'fallback',
        },
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
        menu = {
            auto_show = true,
            draw = {
                columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
            },
            border = 'solid',
            winblend = 0,
            scrollbar = false
        },
        documentation = { auto_show = true, auto_show_delay_ms = 150 },
        ghost_text = { enabled = true }
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
    signature = {
        enabled = true,
        trigger = { enabled = true },
        window = { border = 'solid', winblend = 0 }
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
