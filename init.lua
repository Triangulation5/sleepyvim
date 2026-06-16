vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.wrap = true
vim.g.mapleader = " "
vim.o.winborder = "rounded"

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>wq', ':wqall<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
		{ src = "https://github.com/vague-theme/vague.nvim", version = "24cd29d" },
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/echasnovski/mini.pick" },
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/chomosuke/typst-preview.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client:supports_method('textDocument/completion') then
						vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
				end
		end,
})
vim.cmd("set completeopt+=noselect")
vim.diagnostic.config({ virtual_text = { prefix = "■" }})

require("mini.pick").setup()
require("oil").setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>" )
vim.keymap.set('n', '<leader>fg', ":Pick grep_live<CR>" )
vim.keymap.set('n', '<leader>h', ":Pick help<CR>" )
vim.keymap.set('n', '<leader>e', ":Oil<CR>" )
vim.lsp.enable({ "pyright", "ruff", "tinymist" }) -- Enable only needed servers
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=None")
