-- nvim/lua/config/theme.lua
require("vague").setup({
    transparent = false,
    bold = true,
    italic = false
})

require("rose-pine").setup({
    variant = "auto",
    dark_variant = "main",
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    styles = {
        bold = true,
        italic = false,
        transparency = false
    },
    groups = {
        border = "highlight_med",
        background = "base",
        panel = "surface",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",
        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",
        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        head = "iris",
        hunk = "rose"
    }
})

_G.transparency_enabled = true
_G.current_scheme = nil
_G.idx = 1
_G.schemes = { "rose-pine-moon", "vague",  }

_G.apply_transparency = function()
    if _G.transparency_enabled then
        for _, group in ipairs({
            "Normal", "NormalFloat", "SignColumn", "VertSplit", "StatusLine", "StatusLineNC", "TabLine", "TabLineSel",
            "TabLineFill", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb", "CursorLine", "LineNr", "CursorLineNr", "MsgArea",
            "Folded", "FoldColumn"
        }) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE" })
        end
    end
end

_G.set_colorscheme = function(name, notify)
    if not pcall(vim.cmd.colorscheme, name) then
        vim.notify("Colorscheme " .. name .. " not found", vim.log.levels.ERROR)
        return
    end
    if notify and name ~= _G.current_scheme then
        vim.notify("Switched Colorscheme: " .. name, vim.log.levels.INFO)
    end
    _G.current_scheme = name
    _G.apply_transparency()
end

_G.set_colorscheme(_G.schemes[_G.idx], false)
