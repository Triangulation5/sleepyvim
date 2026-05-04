return {
    {
        "echasnovski/mini.nvim",
        config = function()
            for _, m in ipairs({ "ai", "bracketed", "colors", "comment", "cmdline", "diff", "git", "icons", "jump", "jump2d", "misc", "move", "pairs", "splitjoin", "surround", "tabline", "trailspace" }) do
                require("mini." .. m).setup()
            end
            require("mini.notify").setup({
                lsp_progress = { enable = true, duration_last = 250 },
                window = { config = { border = "rounded" }, max_width_share = 0.6 }
            })
            require("mini.indentscope").setup({
                draw = {
                    animation = require("mini.indentscope").gen_animation.quadratic({ easing = 'in-out', duration = 20 })
                },
                symbol = "╎",
                options = { try_as_border = true }
            })
            -- Alternative options for a indentscope symbol ┆ │ ┊ ╎
            require("mini.hipatterns").setup({
                highlighters = {
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color()
                }
            })
            require("mini.files").setup({
                windows = { preview = true, width_focus = 50, width_nofocus = 15, width_preview = 25, },
            })
            local mode_map = {
                n = "NORMAL",
                no = "OP PENDING",
                nov = "OP PENDING (VISUAL)",
                noV = "OP PENDING (V-LINE)",
                ["no\22"] = "OP PENDING (V-BLOCK)",
                niI = "NORMAL (INSERT)",
                niR = "NORMAL (REPLACE)",
                niV = "NORMAL (V-REPLACE)",
                nt = "TERMINAL",
                v = "VISUAL",
                V = "V-LINE",
                ["\22"] = "V-BLOCK",
                s = "SELECT",
                S = "S-LINE",
                ["\19"] = "S-BLOCK",
                i = "INSERT",
                ic = "INSERT (COMPL)",
                ix = "INSERT (COMPL)",
                R = "REPLACE",
                Rc = "REPLACE (COMPL)",
                Rv = "V-REPLACE",
                Rx = "REPLACE (COMPL)",
                c = "COMMAND",
                cv = "VIM EX",
                ce = "EX",
                r = "PROMPT",
                rm = "MORE",
                ["r?"] = "CONFIRM",
                ["!"] = "SHELL",
                t = "TERMINAL"
            }
            require("mini.statusline").setup({
                use_icons = true,
                content = {
                    active = function()
                        local mode_code = vim.fn.mode()
                        local mode_name = mode_map[mode_code] or mode_code
                        local mode_hl_map = {
                            n = "MiniStatuslineModeNormal",
                            no = "MiniStatuslineModeNormal",
                            nov = "MiniStatuslineModeVisual",
                            noV = "MiniStatuslineModeVisual",
                            ["no\22"] = "MiniStatuslineModeVisual",
                            niI = "MiniStatuslineModeInsert",
                            niR = "MiniStatuslineModeReplace",
                            niV = "MiniStatuslineModeReplace",
                            nt = "MiniStatuslineModeTerminal",
                            v = "MiniStatuslineModeVisual",
                            V = "MiniStatuslineModeVisual",
                            ["\22"] = "MiniStatuslineModeVisual",
                            s = "MiniStatuslineModeSelect",
                            S = "MiniStatuslineModeSelect",
                            ["\19"] = "MiniStatuslineModeSelect",
                            i = "MiniStatuslineModeInsert",
                            ic = "MiniStatuslineModeInsert",
                            ix = "MiniStatuslineModeInsert",
                            R = "MiniStatuslineModeReplace",
                            Rc = "MiniStatuslineModeReplace",
                            Rv = "MiniStatuslineModeReplace",
                            Rx = "MiniStatuslineModeReplace",
                            c = "MiniStatuslineModeCommand",
                            cv = "MiniStatuslineModeCommand",
                            ce = "MiniStatuslineModeCommand",
                            r = "MiniStatuslineModePrompt",
                            rm = "MiniStatuslineModePrompt",
                            ["r?"] = "MiniStatuslineModePrompt",
                            ["!"] = "MiniStatuslineModeShell",
                            t = "MiniStatuslineModeTerminal"
                        }
                        local mode_hl = mode_hl_map[mode_code] or "MiniStatuslineModeNormal"
                        local mode_section = "%#" .. mode_hl .. "# " .. mode_name .. " "
                        local file = "%#MiniStatuslineFilename#  " ..
                            (vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]") .. " "
                        local branch = ""
                        if vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.head then
                            branch = "%#MiniStatuslineGit#  " .. vim.b.gitsigns_status_dict.head .. " "
                        end
                        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                        local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                        local infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                        local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                        local diagnostics = ""
                        if errors > 0 then diagnostics = diagnostics .. "%#MiniStatuslineError#  " .. errors .. " " end
                        if warns > 0 then diagnostics = diagnostics .. "%#MiniStatuslineWarn#  " .. warns .. " " end
                        if infos > 0 then diagnostics = diagnostics .. "%#MiniStatuslineInfo#  " .. infos .. " " end
                        if hints > 0 then diagnostics = diagnostics .. "%#MiniStatuslineHint#  " .. hints .. " " end
                        local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "-"
                        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
                        local ff = vim.bo.fileformat
                        local file_info = "%#MiniStatuslineFileinfo# " .. ft .. " " .. enc .. " " .. ff .. " "
                        local pos = "%#MiniStatuslinePosition# " .. vim.fn.line(".") .. ":" .. vim.fn.col(".") .. " "
                        local pct = "%#MiniStatuslinePercent# " ..
                            math.floor((vim.fn.line(".") / math.max(vim.fn.line("$"), 1)) * 100) .. "%% "
                        local left = table.concat({ mode_section, branch, file, diagnostics })
                        local right = table.concat({ file_info, pct, pos })
                        return left .. "%=" .. right
                    end,
                    inactive = function()
                        local file = "%#MiniStatuslineFilename# " ..
                            (vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]") .. " "
                        local pos = "%#MiniStatuslinePosition# " .. vim.fn.line(".") .. ":" .. vim.fn.col(".") .. " "
                        return file .. "%=" .. pos
                    end
                }
            })
            local lt_opts = { action = 'open', pair = '<>', neigh_pattern = '\r.', register = { cr = false }, }
            MiniPairs.map('i', '<', lt_opts)
            local gt_opts = { action = 'close', pair = '<>', register = { cr = false } }
            MiniPairs.map('i', '>', gt_opts)
            local mg = require("mini.git")
            mg.enable()
            local s = function(f)
                local d = mg.get_buf_data()
                if d and d.head then pcall(f) end
            end
            vim.keymap.set("n", "<leader>gh", function() s(mg.show_range_history) end, { desc = "Git History" })
            vim.keymap.set("n", "<leader>gc", function() s(mg.show_at_cursor) end, { desc = "Git Cursor" })
            vim.keymap.set("n", "<leader>gd", function() s(mg.show_diff_source) end, { desc = "Git Diff" })

            vim.notify = require("mini.notify").make_notify()
        end
    }
}
