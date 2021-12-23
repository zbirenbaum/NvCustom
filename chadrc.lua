vim.g.python_host_skip_check=1
require "custom.set_globals"
require "custom.mappings"
require "custom.custom_commands"
--vim.cmd[[ hi TabLineFill guibg=#000000 ]] --broke pls fix, command works, but not staying applied on init
--vim.cmd[[ syntax enable ]]
--require "custom.theme_override"
local M = {}
--M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.options = {
  -- NeoVim/Vim options
  clipboard = "unnamedplus",
  cmdheight = 1,
  ruler = false,
  hidden = true,
  ignorecase = true,
  mapleader = " ",
  mouse = "a",
  number = true,
  nav_wrapper = true,
  -- relative numbers in normal mode tool at the bottom of options.lua
  numberwidth = 2,
  relativenumber = true,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 8, -- Number of spaces that a <Tab> in the file counts for
  timeoutlen = 400,
  -- interval for writing swap file to disk, also used by gitsigns
  updatetime = 250,
  undofile = true, -- keep a permanent undo (across restarts)
  -- NvChad options
  nvChad = {
    copy_cut = true, -- copy cut text ( x key ), visual and normal mode
    copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
    insert_nav = true, -- navigation in insertmode
    window_nav = true,
    theme_toggler = true,
    -- used for updater
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

-- ui configs
M.ui = {
  hl_override = "custom.plugins.hl_override",
  italic_comments = true,
  -- theme to be used, check available themes with `<leader> + t + h`
  --theme = "tokyonight",
  theme = "tokyonight",
  --theme = "onedark",

  -- toggle between two themes, see theme_toggler mappings
  theme_toggler = {
    "tokyonight",
    --"tomorrow-night"
  },
  -- Enable this only if your terminal has the colorscheme set which nvchad uses
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = true,
}

-- these are plugin related options
-- 
M.plugins = {
  -- enable and disable plugins (false for disable)
  status = {
    autosave = false, -- to autosave files
    blankline = true, -- beautified blank lines
    bufferline = false, -- buffer shown as tabs
    cheatsheet = true, -- fuzzy search your commands/keymappings
    colorizer = true,
    comment = true, -- universal commentor
    dashboard = false, -- a nice looking dashboard
    esc_insertmode = true, -- escape from insert mode using custom keys
    feline = true, -- statusline
    gitsigns = true, -- gitsigns in statusline


    lspsignature = true, -- lsp enhancements

    neoformat = true, -- universal formatter
    neoscroll = true, -- smooth scroll
    telescope_media = true, -- see media files in telescope picker
    truezen = true, -- no distraction mode for nvim
    vim_fugitive = true, -- git in nvim

    --My Plugins
    termwrapper = false,
    toggleterm = true,
    jqx = true,
    autopairs = true,
    --     fterm = true,
    -- Completions, choose 1
    coq_nvim = false,
    cmp = true,
    --if coq_nvim is true, set these to false
    dap = false,
    tabline=true,
    --organized diagnostics
    trouble = true,
    --vscode style ex mode
    cmdline = false,
    lspkind = true,
    --cmdheight rfc
    cmdheight = false,
    --its kinda cool and no real slowdown for me, but not lua so disabled out of principle
    wilder=false,
    --choose 1
    vim_matchup = false, -- % magic, match it but improved
    --broken for now
    matchparen=true,
    --choose 1
    lightspeed = true,
    hop = false,
  },
  options = {
    lspconfig = {
      setup_lspconf = require('custom.plugins.lsp_config_selection'),
      --setup_lspconf = 'custom.plugins.cmp_configs.lsp_config_cmp'
      --setup_lspconf = "custom.plugins.lsp_config",
    },
    nvimtree = {
      enable_git = 0,
    },
    luasnip = {
      snippet_path = {},
    },
    statusline = { -- statusline related options
      -- these are filetypes, not pattern matched
      -- shown filetypes will overrule hidden filetypes
      hidden = {
        "help",
        "dashboard",
        "NvimTree",
        "terminal",
      },
      -- show short statusline on small screens
      shortline = true,
      shown = {},
      -- default, round , slant , block , arrow
      style = "custom",
    },
    esc_insertmode_timeout = 300,
  },
  --default_plugin_config_replace = tbl
  default_plugin_config_replace = {
    signature="custom.plugins.cmp_configs.lspsignature_cmp",
    --signature=require("custom.plugins.lspsignature_selection"),
    feline="custom.plugins.statusline_builder.builder",
    nvim_cmp="custom.plugins.cmp_configs.cmp",
    bufferline="custom.plugins.bufferline",
    --feline="custom.plugins.feline",
    --nvim_autopairs=require("custom.plugins.autopairs_selection"),
    --signature="custom.plugins.lspsignature_coq",
  },
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
  -- custom = {}, -- all custom user mappings
  -- close current focused buffer
  close_buffer = "<leader>x",
  copy_whole_file = "<C-a>", -- copy all contents of the current buffer
  line_number_toggle = "<leader>n", -- show or hide line number
  new_buffer = "<S-t>", -- open a new buffer
  new_tab = "<C-t>b", -- open a new vim tab
  save_file = "<C-s>", -- save file using :w
  theme_toggler = "<leader>tt", -- for theme toggler, see in ui.theme_toggler
  -- navigation in insert mode, only if enabled in options
  insert_nav = {
    backward = "<C-h>",
    end_of_line = "<C-e>",
    forward = "<C-l>",
    next_line = "<C-k>",
    prev_line = "<C-j>",
    beginning_of_line = "<C-a>",
  },
  --better window movement
  window_nav = {
    moveLeft = "<C-w>h",
    moveRight = "<C-w>l",
    moveUp = "<C-w>k",
    moveDown = "<C-w>j",
  },
  -- terminal related mappings
  terminal = {
    -- multiple mappings can be given for esc_termmode and esc_hide_termmode
    -- get out of terminal mode
    esc_termmode = { "jk" }, -- multiple mappings allowed
    -- get out of terminal mode and hide it
    esc_hide_termmode = { "JK" }, -- multiple mappings allowed
    -- show & recover hidden terminal buffers in a telescope picker
    pick_term = "<leader>W",
    -- below three are for spawning terminals
    new_horizontal = "<leader>h",
    new_vertical = "<leader>v",
    new_window = "<leader>w",
  },
  -- update nvchad from nvchad, chadness 101
  update_nvchad = "<leader>uu",
}

-- all plugins related mappings
M.mappings.plugins = {
  -- list open buffers up the top, easy switching too
  bufferline = {
    next_buffer = "<TAB>", -- next buffer
    prev_buffer = "<S-Tab>", -- previous buffer
  },
  -- easily (un)comment code, language aware
  comment = {
    toggle = "<leader>/", -- toggle comment (works on multiple lines)
  },
  -- NeoVim 'home screen' on open
  dashboard = {
    bookmarks = "<leader>bm",
    new_file = "<leader>fn", -- basically create a new buffer
    open = "<leader>db", -- open dashboard
    session_load = "<leader>l", -- load a saved session
    session_save = "<leader>s", -- save a session
  },
  -- map to <ESC> with no lag
  better_escape = { -- <ESC> will still work
    --esc_insertmode = { "jk", "kj" }, -- multiple mappings allowed
    esc_insertmode = { "jk" }, -- multiple mappings allowed
  },
-- file explorer/tree
  nvimtree = {
    toggle = "<C-n>",
    focus = "<leader>e",
  },
  -- multitool for finding & picking things
  telescope = {
    buffers = "<leader>fb",
    find_files = "<leader>ff",
    find_hiddenfiles = "<leader>fa",
    git_commits = "<leader>cm",
    git_status = "<leader>gt",
    help_tags = "<leader>fh",
    live_grep = "<leader>fw",
    oldfiles = "<leader>fo",
    themes = "<leader>th", -- NvChad theme picker
    -- media previews within telescope finders
    telescope_media = {
      media_files = "<leader>fp",
    },
  },
}


return M

-- function get_default_config_replace()
  --   if M.plugins.status.coq then
  --     tbl = {
    --       autopairs = "custom.plugins.autopairs",
    --       signature="custom.plugins.lspsignature",
    --       feline="custom.plugins.feline",
    --     }
    --   else
    --     tbl = {"custom.plugins.feline",}
    --   end
    --   return tbl
    -- end
    --
    -- local tbl = {
      --   autopairs = "custom.plugins.autopairs",
      --   signature="custom.plugins.lspsignature",
      --   feline="custom.plugins.feline",
      -- }
      -- local conf_repl = get_default_config_replace()
      -- print(conf_repl)
      -- non plugin normal, available without any plugins
