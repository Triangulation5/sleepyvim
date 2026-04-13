-- nvim/lua/plugins/ui.lua
require("mini.notify").setup({
    lsp_progress = {
        enable = true,
        duration_last = 250
    },
    window = {
        config = { border = "single" },
        max_width_share = 0.6
    }
})

require("mini.indentscope").setup({
    draw = {
        animation = require("mini.indentscope").gen_animation.quadratic({ easing = 'in-out', duration = 20 })
    },
    symbol = "╎",
    options = { try_as_border = true }
})

require("mini.hipatterns").setup({
    highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color()
    }
})

vim.notify = require("mini.notify").make_notify()
