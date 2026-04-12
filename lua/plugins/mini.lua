-- nvim/lua/plugins/mini.lua
local modules = {
    "ai", "bracketed", "bufremove", "comment", "deps", "diff", "extra", "git",
    "icons", "jump", "misc", "move", "pairs", "snippets", "splitjoin", "surround",
    "tabline", "trailspace"
}

for _, m in ipairs(modules) do
    require("mini." .. m).setup()
end

-- MiniIcons.tweak_lsp_kind()
MiniIcons.mock_nvim_web_devicons()

require("mini.files").setup({
    windows = {
        preview = true,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
    },
})

local animate = require("mini.animate")
_G.cursor_anim_enabled = false
_G.set_cursor_animation = function(e)
    local t = {
        cursor = {
            enable = e,
            timing = animate.gen_timing.quadratic({ easing = "out", duration = 75, unit = "total" }),
            path = function(d)
                local p = animate.gen_path.line({ predicate = function() return true end, max_step = 300 })(d)
                local l = 6
                local r = {}
                for i = 1, #p do
                    for o = 0, l - 1 do
                        local c = p[i][1] - o
                        local col = p[i][2]
                        if c >= 0 then
                            table.insert(r, { c, col })
                        end
                    end
                end
                return r
            end
        }
    }
    animate.setup(t)
    _G.cursor_anim_enabled = e
end
set_cursor_animation(false)

require("mini.pick").setup({
    window = {
        config = nil,
        prompt_caret = '█ ',
        prompt_prefix = '» ',
    },
})

local lt_opts = { action = 'open', pair = '<>', neigh_pattern = '\r.', register = { cr = false }, }
MiniPairs.map('i', '<', lt_opts)
local gt_opts = { action = 'close', pair = '<>', register = { cr = false } }
MiniPairs.map('i', '>', gt_opts)
