-- nvim/lua/core/options.lua
local opt = vim.opt

local options = {
    nu = true,
    rnu = true,
    nuw = 4,
    scl = "yes",
    ts = 4,
    sts = 4,
    sw = 4,
    et = true,
    si = true,
    bri = true,
    list = true,
    lcs = {
        tab = "  ",
        trail = "·",
        extends = "›",
        precedes = "‹",
        nbsp = "␣"
    },
    scs = true,
    hls = false,
    is = true,
    bg = "dark",
    gcr = "a:block",
    ut = 50,
    tm = 150,
    so = 8,
    siso = 8,
    winborder = "solid",
    cb = "unnamedplus",
    cot = { "menuone", "noselect" },
    cole = 0,
    ph = 10,
    pb = 0,
    winbl = 0,
    swf = false,
    sd = "",
    ru = false,
    title = true,
    titlelen = 0,
}

for k, v in pairs(options) do
    opt[k] = v
end

opt.fcs:append({
    eob = " ",
    stl = " ",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    verthoriz = "┼",
    trunc = "›",
    truncrl = "‹"
})

-- Duplicate logic from init.lua (maintained as requested)
vim.opt.undofile = true
local u = vim.fn.stdpath("state") .. "/undo"
vim.opt.undodir = u
vim.fn.mkdir(u, "p")
local t = u .. "/.last_cleanup"
local n = os.time()
local l = vim.fn.filereadable(t) == 1 and tonumber(vim.fn.readfile(t)[1]) or 0
if n - l > 86400 then
    for _, f in ipairs(vim.fn.glob(u .. "/*", true, true)) do
        if f ~= t then
            os.remove(f)
        end
    end
    vim.fn.writefile({ tostring(n) }, t)
end

-- Second duplicate logic from init.lua
vim.opt.undofile = true
local u2 = vim.fn.stdpath("state") .. "/undo"
vim.opt.undodir = u2
vim.fn.mkdir(u2, "p")
local t2 = u2 .. "/.last_cleanup"
local n2 = os.time()
local l2 = vim.fn.filereadable(t2) == 1 and tonumber(vim.fn.readfile(t2)[1]) or 0
if n2 - l2 > 86400 then
    for _, f in ipairs(vim.fn.glob(u2 .. "/*", true, true)) do
        if f ~= t2 then
            os.remove(f)
        end
    end
    vim.fn.writefile({ tostring(n2) }, t2)
end
