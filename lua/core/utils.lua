-- nvim/lua/core/utils.lua
_G.pick_border = function()
    local height = math.floor(0.658 * vim.o.lines)
    local width = math.floor(0.818 * vim.o.columns)
    return {
        anchor = 'nw',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
    }
end

_G.mode_map = {
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
