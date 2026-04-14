-- nvim/lua/plugins/lsp.lua
vim.lsp.enable({ "pyright", "ruff", "gopls", "rust_analyzer", "vtsls", "copilot_ls" })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true
            },
            staticcheck = true
        }
    }
})

local rust_capabilities = vim.lsp.protocol.make_client_capabilities()
rust_capabilities.textDocument.completion.completionItem.snippetSupport = true
rust_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
}

vim.lsp.config("rust_analyzer", {
    capabilities = rust_capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            procMacro = { enable = true },
            lens = { enable = true }
        }
    }
})

vim.lsp.config("vtsls", {
    root_dir = vim.fs.root(0, { "jsconfig.json", "package.json", "tsconfig.js" })
})

vim.g.copilot_nes_debounce = 500
