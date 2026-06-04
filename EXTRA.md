# Extras:

<!--toc:start-->
- [Extras:](#extras)
  - [Extra: Plugins](#extra-plugins)
  - [Extra: Keymaps](#extra-keymaps)
  - [Extra: Themes](#extra-themes)
    - [Extra: Mini Pick Configurations:](#extra-mini-pick-configurations)
    - [Extra: Obsidian Support](#extra-obsidian-support)
<!--toc:end-->

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

-- Add this to use mini.snippets using friendly-snippets or any other snippet plugin
{ src = "https://github.com/rafamadriz/friendly-snippets" },

require("mini.snippets").setup({
    snippets = { require("mini.snippets").gen_loader.from_lang() },
    mappings = {
        expand = "<C-j>",
        jump_next = "<Tab>",
        jump_prev = "<S-Tab>",
        stop = "<C-c>",
    },
})
require("mini.snippets").start_lsp_server({ match = false })

-- blink.cmp
-- Install it using vim.pack.add(): { src = "https://github.com/Saghen/blink.cmp" },
-- Add this to enable it:
require('blink.cmp').setup({keymap={preset='default',['<CR>']={'accept','fallback'},['<Tab>']={'select_next','fallback'},['<S-Tab>']={'select_prev','fallback'}},completion={accept={auto_brackets={enabled=true}},list={selection={preselect=true,auto_insert=false},autotrigger=true},menu={border='rounded',max_height=12,winblend=15},documentation={auto_show=true,auto_show_delay_ms=150,max_height=20,max_width=80,window={border='rounded',winblend=10,max_height=20,max_width=80,wrap=true}}},sources={default={'lsp','path','buffer'},providers={lsp={module='blink.cmp.sources.lsp',score_offset=100},path={module='blink.cmp.sources.path',score_offset=80},buffer={module='blink.cmp.sources.buffer',score_offset=70}}},fuzzy={implementation='lua',use_exact=true},signature={enabled=true,trigger={enabled=true,chars={'(',','}},window={border='rounded',winblend=15}},snippets={}})

-- Add for Screenkey
-- vim.pack.add(): { src = "https://github.com/NStefan002/screenkey.nvim" },
require("screenkey").setup({win_opts={row=(vim.o.lines-vim.o.cmdheight)/2-1,col=vim.o.columns-1,relative="editor",anchor="NE",width=20,height=3,border="rounded",title=" Screenkey ",title_pos="center",style="minimal",focusable=false,noautocmd=true},hl_groups={["screenkey.hl.key"]={link="Normal"},["screenkey.hl.map"]={link="Normal"},["screenkey.hl.sep"]={link="Normal"}},compress_after=3,clear_after=4,emit_events=true,disable={filetypes={},buftypes={}},show_leader=true,group_mappings=false,display_infront={},display_behind={},filter=function(keys)return keys end,colorize=function(keys)return keys end,separator=" ",keys={["<TAB>"]="󰌒",["<CR>"]="󰌑",["<ESC>"]="Esc",["<SPACE>"]="␣",["<BS>"]="󰌥",["<DEL>"]="Del",["<LEFT>"]="",["<RIGHT>"]="",["<UP>"]="",["<DOWN>"]="",["<HOME>"]="Home",["<END>"]="End",["<PAGEUP>"]="PgUp",["<PAGEDOWN>"]="PgDn",["<INSERT>"]="Ins",["<F1>"]="󱊫",["<F2>"]="󱊬",["<F3>"]="󱊭",["<F4>"]="󱊮",["<F5>"]="󱊯",["<F6>"]="󱊰",["<F7>"]="󱊱",["<F8>"]="󱊲",["<F9>"]="󱊳",["<F10>"]="󱊴",["<F11>"]="󱊵",["<F12>"]="󱊶",CTRL="Ctrl",ALT="Alt",SUPER="󰘳",["<leader>"]="<leader>"}})

-- Add this for undotree: { src = "https://github.com/mbbill/undotree" },
vim.opt.undofile = true; local u = vim.fn.stdpath("state") .. "/undo"; vim.opt.undodir = u; vim.fn.mkdir(u, "p"); local t = u .. "/.last_cleanup"; local n = os.time(); local l = vim.fn.filereadable(t) == 1 and tonumber(vim.fn.readfile(t)[1]) or 0; if n - l > 86400 then for _, f in ipairs(vim.fn.glob(u .. "/*", true, true)) do if f ~= t then os.remove(f) end end; vim.fn.writefile({ tostring(n) }, t) end
-- The kaymap that you have to add to the keymap section:
{ "n", "<leader>u", "<cmd>UndotreeToggle<CR>", "Toggle Undotree" },
-- The code about makes it so that the undo file clears after every day.

-- Add this for mini.starter for a starting screen when opening up Neovim:
local starter, logo = require("mini.starter"), table.concat({ "            ███████╗██╗     ███████╗███████╗██████╗ ██╗   ██╗██╗   ██╗██╗███╗   ███╗        Z  ", "            ██╔════╝██║     ██╔════╝██╔════╝██╔══██╗╚██╗ ██╔╝██║   ██║██║████╗ ████║     Z     ", "            ███████╗██║     █████╗  █████╗  ██████╔╝ ╚████╔╝ ██║   ██║██║██╔████╔██║   z       ", "            ╚════██║██║     ██╔══╝  ██╔══╝  ██╔═══╝   ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         ", "            ███████║███████╗███████╗███████╗██║        ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           ", "            ╚══════╝╚══════╝╚══════╝╚══════╝╚═╝        ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           " }, "\n"); starter.setup({ evaluate_single = true, header = logo, items = { { name = "Pick Files", action = function() require("mini.pick").builtin.files() end, section = string.rep(" ", 22) .. "MiniPick" }, { name = "New file", action = function() vim.cmd("ene | startinsert") end, section = string.rep(" ", 22) .. "Built-in" }, { name = "Find text", action = function() require("mini.pick").builtin.grep_live() end, section = string.rep(" ", 22) .. "MiniPick" }, { name = "Pick Buffers", action = function() require("mini.pick").builtin.buffers() end, section = string.rep(" ", 22) .. "MiniPick" }, { name = "Quit", action = function() vim.cmd("q!") end, section = string.rep(" ", 22) .. "Built-in" } }, content_hooks = { starter.gen_hook.adding_bullet(string.rep(" ", 22) .. "░ ", false), starter.gen_hook.aligning("center", "center") } })

-- Add this for nvim-tree: { src = "https://github.com/nvim-tree/nvim-tree.lua" },
require("nvim-tree").setup({
  hijack_netrw = false,
  hijack_cursor = false,
  sync_root_with_cwd = false,
  respect_buf_cwd = false,
  update_focused_file = { enable = false },
  view = {
    side = "left",
    width = 26,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "single",
        width = 50,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    highlight_opened_files = "none",
    root_folder_label = false,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
        },
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          deleted = "",
          ignored = "",
        },
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  diagnostics = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = { ".DS_Store", ".git", "thumbs.db" },
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'a', api.fs.create, opts('Create File or Directory'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete File or Directory'))
    end,
})
vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer (Left)" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3a3a3a" })
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

    -- Flexoki theme
    { src = "https://github.com/nuvic/flexoki-nvim" },

    -- Koda theme
    { src = "https://github.com/oskarnurm/koda.nvim" },

    -- Techbase theme
    { src = "https://github.com/mcauley-penney/techbase.nvim" },

    -- Best commit hashes for Vague.nvim theme:
    { src = "https://github.com/vague-theme/vague.nvim", version = "24cd29d", }, -- Very clean more modern
    { src = "https://github.com/vague-theme/vague.nvim", version = "6c44ca6", }, -- Old but nice
    { src = "https://github.com/vague-theme/vague.nvim", version = "53b6060", }, -- Old version

    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    -- Some things for Gruvbox:
    require("gruvbox").setup({ terminal_colors = true, transparent_mode = false, contrast = "hard" })
    -- Add this to the keymap toggle:
    if name == "gruvbox" then
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1d2021" })

    { src = "https://github.com/catppuccin/nvim" },
    -- Custom settings for catppuccin:
    require("catppuccin").setup({ flavour = "mocha", color_overrides = { mocha = { base = "#000000", mantle = "#000000", crust = "#000000" } }, integrations = { notify = true, mini = true }, no_italic = true, custom_highlights = function(colors) return { FloatBorder = { fg = colors.surface2, bg = colors.base }, NormalFloat = { bg = colors.base } } end })
```

### Extra: Mini Pick Configurations:
```lua
-- Default configuration with different prompt prefix and caret
require("mini.pick").setup({ window = { config = nil, prompt_caret = '█ ', prompt_prefix = '» ', }, })

-- Cursor attached search bar
require("mini.pick").setup({ window = { config = { relative = 'cursor', anchor = 'NW', row = 0, col = 0, width = 40, heiht}, prompt_prefix = '» ', }, })

-- Another Cursor attached micro picker
require("mini.pick").setup({
  window = {
    config = {
      relative = "cursor",
      anchor = "NW",
      row = 1,
      col = 0,
      width = 50,
      height = 12,
      border = "single",
    },
    prompt_prefix = "» ",
  },
})

-- Floating command-palette style
require("mini.pick").setup({
  window = {
    config = {
      relative = "editor",
      anchor = "NW",
      width = math.floor(vim.o.columns * 0.42),
      height = math.floor(vim.o.lines * 0.48),
      row = math.floor(vim.o.lines * 0.18),
      col = math.floor(vim.o.columns * 0.29),
      border = "rounded",
    },
    prompt_prefix = "   ",
  },
})

-- Minimalist transparent sidebar (super cool)
require("mini.pick").setup({
  window = {
    config = {
      relative = "editor",
      anchor = "NE",
      width = 42,
      height = vim.o.lines - 4,
      row = 1,
      col = vim.o.columns,
      border = "none",
    },
    prompt_prefix = "▌ ",
  },
})

-- Telescope-like centered layout
require("mini.pick").setup({
  window = {
    config = function()
      local height = math.floor(0.45 * vim.o.lines)
      local width = math.floor(0.55 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
        border = "double",
      }
    end,
    prompt_prefix = "   ",
  },
})

-- Bottom command-line dock
require("mini.pick").setup({
  window = {
    config = {
      relative = "editor",
      anchor = "SW",
      width = vim.o.columns,
      height = 15,
      row = vim.o.lines - 2,
      col = 0,
    },
    prompt_prefix = " ",
  },
})

-- IDE-style wide search panel
require("mini.pick").setup({
  window = {
    config = {
      relative = "editor",
      anchor = "NW",
      row = 1,
      col = 2,
      width = vim.o.columns - 4,
      height = math.floor(vim.o.lines * 0.35),
      border = "solid",
    },
    prompt_prefix = " Search  ",
  },
})

-- Hard-left utility panel
require("mini.pick").setup({
  window = {
    config = {
      relative = "editor",
      anchor = "NW",
      row = 0,
      col = 0,
      width = 30,
      height = vim.o.lines,
      border = "rounded",
    },
    prompt_prefix = " ",
  },
})

-- Bottom-center dock
require("mini.pick").setup({
  window = {
    config = function()
      local w = 70
      return {
        relative = "editor",
        anchor = "SW",
        row = vim.o.lines - 2,
        col = math.floor((vim.o.columns - w) / 2),
        width = w,
        height = 12,
        border = "rounded",
      }
    end,
    prompt_prefix = " ",
  },
})

-- Hyper-compact command runner
require("mini.pick").setup({
  window = {
    config = {
      relative = "cursor",
      anchor = "NW",
      row = 1,
      col = 0,
      width = 38,
      height = 1,
      border = "rounded",
    },
    prompt_prefix = "› ",
  },
})
```
### Extra: Obsidian Support

```lua
-- Plugins for it
{ src = "https://github.com/epwalsh/obsidian.nvim" },
{ src = "https://github.com/nvim-lua/plenary.nvim" },

-- Configuration for it
require("obsidian").setup({
  workspaces = {
    {
      name = "notes",
      path = vim.fn.expand(""), -- Add the path to your vault or notes here
    },
  },
})
```
