local M = {}
--local userPlugins = require "custom.plugins_table" -- path to table

-- require('impatient')
-- require('impatient').enable_profile()

vim.g.python_host_skip_check=1

require "custom.utils.set_globals"
require "custom.utils.mappings".navigation()


M.options = {
   -- NeoVim/Vim options
   clipboard = "unnamedplus",
   cmdheight = 1,
   ruler = false,
   hidden = true,
   ignorecase = true,
   mapleader = " ",
   mouse = "",
   number = true,
   nav_wrapper = true,
   -- relative numbers in normal mode tool at the bottom of options.lua
   numberwidth = 2,
   relativenumber = true,
   expandtab = true,
   shiftwidth = 3,
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
      theme_toggler = false,
      -- used for updater
      update_url = "https://github.com/NvChad/NvChad",
      update_branch = "main",
   }
}

-- ui configs
M.ui = {
   hl_override = "custom.plugins.overrides.hl_override",
   italic_comments = true,
   transparency = true,
   theme = "onedark",
}

-- these are plugin related options
M.plugins = {
   --  install = userPlugins,
   -- enable and disable plugins (false for disable)
   status = {
      autosave = false, -- to autosave files
      bufferline = false, -- buffer shown as tabs
      dashboard = false, -- a nice looking dashboard
      esc_insertmode = true, -- escape from insert mode using custom keys
      feline = true, -- statusline
      gitsigns = true, -- gitsigns in statusline
      lsp_signature = false, -- lsp enhancements
      neoscroll = true, -- smooth scroll
      telescope_media = true, -- see media files in telescope picker
      truezen = true, -- no distraction mode for nvim
      nvimtree=false,

      --My Plugins
      autopairs = true,
      marks = false,
      gps = false,
      luadev = false,

      -- Completions, choose 1
      coq = false,
      cmp = true,
      dap = true,
      tabline=false,
      --organized diagnostics
      trouble = false,
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
      hop = false,
      --disabled for testing
      lightspeed = true,
      jqx = true,
      toggleterm = false,
      blankline = true, -- beautified blank lines
      cheatsheet = false, -- fuzzy search your commands/keymappings
      colorizer = true,
      comment = true, -- universal commentor
   },
   options = {
      lspconfig = {
--         setup_lspconf = "custom.plugins.overrides.cmp_configs.lsp_config_cmp",
         --setup_lspconf = require('custom.plugins.overrides.lsp_config_selection'),
      },
   },
   --default_plugin_config_replace = tbl
   default_plugin_config_replace = {
      feline = function () require("custom.plugins.overrides.statusline_builder.builder") end,
      --      signature="custom.plugins.overrides.cmp_configs.lspsignature_cmp",
      --      nvim_cmp="custom.plugins.overrides.cmp_configs.cmp",
      --bufferline="custom.plugins.overrides.bufferline",
      nvim_treesitter = "custom.plugins.overrides.treesitter",
      --feline="custom.plugins.feline",
      --nvim_autopairs=require("custom.plugins.autopairs_selection"),
      --signature="custom.plugins.lspsignature_coq",
   },
   default_plugin_remove= {
      "nvim-telescope/telescope.nvim",
      "lukas-reineke/indent-blankline.nvim",
      "nvim-telescope/telescope.nvim",
   },
}

M.mappings = {plugins = {}}

return M
