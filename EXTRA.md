# Extras:

## Extra: Plugins

```lua
-- Add this for mini.clue:
require("mini.clue").setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' }, { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' }, { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' }, { mode = 'n', keys = "'" },
        { mode = 'n', keys = "`" }, { mode = 'x', keys = "'" },
        { mode = 'x', keys = "`" }, { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' }, { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' }, { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' }, { mode = 'x', keys = 'z' },
    },
    clues = {
        require("mini.clue").gen_clues.builtin_completion(),
        require("mini.clue").gen_clues.g(),
        require("mini.clue").gen_clues.marks(),
        require("mini.clue").gen_clues.registers(),
        require("mini.clue").gen_clues.windows(),
        require("mini.clue").gen_clues.z(),
    },
    window = {
        config = { border = "double" },
        delay = 200,
    },
})
-- blink.cmp
-- Install it using vim.pack.add(): { src = "https://github.com/Saghen/blink.cmp" },
-- Add this to enable it:
require('blink.cmp').setup({keymap={preset='default',['<CR>']={'accept','fallback'},['<Tab>']={'select_next','fallback'},['<S-Tab>']={'select_prev','fallback'}},completion={accept={auto_brackets={enabled=true}},list={selection={preselect=true,auto_insert=false},autotrigger=true},menu={border='rounded',max_height=12,winblend=15},documentation={auto_show=true,auto_show_delay_ms=150,max_height=20,max_width=80,window={border='rounded',winblend=10,max_height=20,max_width=80,wrap=true}}},sources={default={'lsp','path','buffer'},providers={lsp={module='blink.cmp.sources.lsp',score_offset=100},path={module='blink.cmp.sources.path',score_offset=80},buffer={module='blink.cmp.sources.buffer',score_offset=70}}},fuzzy={implementation='lua',use_exact=true},signature={enabled=true,trigger={enabled=true,chars={'(',','}},window={border='rounded',winblend=15}},snippets={}})
-- Add for Screenkey
-- vim.pack.add(): { src = "https://github.com/NStefan002/screenkey.nvim" },
require("screenkey").setup({win_opts={row=(vim.o.lines-vim.o.cmdheight)/2-1,col=vim.o.columns-1,relative="editor",anchor="NE",width=20,height=3,border="rounded",title=" Screenkey ",title_pos="center",style="minimal",focusable=false,noautocmd=true},hl_groups={["screenkey.hl.key"]={link="Normal"},["screenkey.hl.map"]={link="Normal"},["screenkey.hl.sep"]={link="Normal"}},compress_after=3,clear_after=4,emit_events=true,disable={filetypes={},buftypes={}},show_leader=true,group_mappings=false,display_infront={},display_behind={},filter=function(keys)return keys end,colorize=function(keys)return keys end,separator=" ",keys={["<TAB>"]="󰌒",["<CR>"]="󰌑",["<ESC>"]="Esc",["<SPACE>"]="␣",["<BS>"]="󰌥",["<DEL>"]="Del",["<LEFT>"]="",["<RIGHT>"]="",["<UP>"]="",["<DOWN>"]="",["<HOME>"]="Home",["<END>"]="End",["<PAGEUP>"]="PgUp",["<PAGEDOWN>"]="PgDn",["<INSERT>"]="Ins",["<F1>"]="󱊫",["<F2>"]="󱊬",["<F3>"]="󱊭",["<F4>"]="󱊮",["<F5>"]="󱊯",["<F6>"]="󱊰",["<F7>"]="󱊱",["<F8>"]="󱊲",["<F9>"]="󱊳",["<F10>"]="󱊴",["<F11>"]="󱊵",["<F12>"]="󱊶",CTRL="Ctrl",ALT="Alt",SUPER="󰘳",["<leader>"]="<leader>"}}) 
```

## Extra: Keymaps

```lua
    { "n", "<leader>o", ":update<CR>:source<CR>", "Write and source file" },
    -- If you want oldfiles to work remove shada from the opt section.
    { "n", "<leader>fr", ":Pick oldfiles<CR>", "Pick: recent" },
```

## Extra: Themes

```lua
    { src = "https://github.com/projekt0n/github-nvim-theme"},
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/olimorris/onedarkpro.nvim" },
```
