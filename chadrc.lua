require('impatient')
require('impatient').enable_profile()
-- j
--require('packer_compiled')
vim.g.python_host_skip_check=1
require "custom.utils.set_globals"
require "custom.utils.mappings"
--require "custom.custom_commands"
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
  expandtab = false,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
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
  hl_override = "custom.plugins.overrides.hl_override",
  italic_comments = true,
  -- theme to be used, check available themes with `<leader> + t + h`
  --theme = "tokyonight",
 -- theme = "tokyonight",
  --theme = "onedark",

  -- toggle between two themes, see theme_toggler mappings
  -- theme_toggler = {
  --   "tokyonight",
  --   --"tomorrow-night"
  -- },
  -- Enable this only if your terminal has the colorscheme set which nvchad uses
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = true,
}

-- these are plugin related options
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
		-- currently coq unsupported due to updates in cmp making it fall behind in usefulness. coq will work again soonish but will be temp broken due to new dir structure
    coq_nvim = false,
    cmp = true,
    --if coq_nvim is true, set these to false
    dap = true,
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
    	setup_lspconf = require('custom.plugins.overrides.lsp_config_selection'),
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
      ------------------style = "custom",
    },
    esc_insertmode_timeout = 300,
  },
  --default_plugin_config_replace = tbl
  default_plugin_config_replace = {
    signature="custom.plugins.overrides.cmp_configs.lspsignature_cmp",
    feline="custom.plugins.overrides.statusline_builder.builder",
    nvim_cmp="custom.plugins.overrides.cmp_configs.cmp",
    bufferline="custom.plugins.overrides.bufferline",
    nvim_treesitter = "custom.plugins.overrides.treesitter",
    --feline="custom.plugins.feline",
    --nvim_autopairs=require("custom.plugins.autopairs_selection"),
    --signature="custom.plugins.lspsignature_coq",
  },
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
}

-- all plugins related mappings
M.mappings.plugins = {
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
