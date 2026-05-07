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
