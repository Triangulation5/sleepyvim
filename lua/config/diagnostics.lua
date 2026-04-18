-- nvim/lua/config/diagnostics.lua
vim.diagnostic.config({
    virtual_text = {
        prefix = "■",
        spacing = 6,
        hl_mode = "combine",
        format = function(d)
            return string.format("%s [%s]", d.message, d.source or d.code or "")
        end
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "solid",
        header = "Diagnostic(s):",
        source = "always",
        focusable = true
    }
})
