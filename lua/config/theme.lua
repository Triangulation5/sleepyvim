-- nvim/lua/config/theme.lua
require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,
    contrast = "hard",
    palette_overrides = {},
    overrides = {
        ["String"] = { fg = "#99FF20" },
        ["@string"] = { fg = "#99FF20" },
        ["Type"] = { fg = "#9090FF" },
        ["Function"] = { fg = "#EED030" },
        ["Identifier"] = { fg = "#75EEFF" },
        ["@variable"] = { fg = "#00AAD0" },
        ["@variable.parameter"] = { italic = true, fg = "#b9d3eb" },
        ["@lsp.type.parameter"] = { italic = true, fg = "#b9d3eb" },
        ["@constant"] = { fg = "#00AAD0" },
        ["Boolean"] = { fg = "#FF20FF" },
        ["StorageClass"] = { fg = "#E950A0" }
    },
    dim_inactive = false,
    transparent_mode = true
})

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

_G.transparency_enabled = false
_G.current_scheme = nil
_G.idx = 1
_G.schemes = { "vague", "rose-pine-moon", "rose-pine-main", "gruvbox" }

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
