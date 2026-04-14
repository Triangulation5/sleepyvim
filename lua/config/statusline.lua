-- nvim/lua/config/statusline.lua
require("mini.statusline").setup({
    use_icons = true,
    content = {
        active = function()
            local mode_code = vim.fn.mode()
            local mode_name = _G.mode_map[mode_code] or mode_code
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
            local function get_copilot_status()
                if vim.g.copilot_nes_enabled == false then
                    return ""
                end
                local clients = vim.lsp.get_clients({ name = "copilot_ls", bufnr = 0 })
                if #clients > 0 then
                    return "%#MiniStatuslineInfo#  "
                end
                return ""
            end

            local copilot = get_copilot_status()
            local left = table.concat({ mode_section, branch, file, diagnostics, copilot })
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
