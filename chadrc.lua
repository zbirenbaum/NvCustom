local M = {}

require "custom.utils.set_globals"
require "custom.utils.mappings".navigation()
local user_plugins = require("custom.plugins_table")

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

M.plugins = {
   install = user_plugins,
   default_plugin_config_replace = {
      feline = function () require("custom.plugins.overrides.statusline_builder.builder") end,
      nvim_treesitter = "custom.plugins.overrides.treesitter",
      indent_blankline = function () require("custom.plugins.custom_plugin_configs.indent_blankline") end
   },
   status = require("custom.status"),
   default_plugin_remove= {
      "akinsho/bufferline.nvim",
      "nvim-telescope/telescope.nvim",
   },
}

M.mappings = {plugins = {}}

return M

--signature="custom.plugins.overrides.cmp_configs.lspsignature_cmp",
--nvim_cmp="custom.plugins.overrides.cmp_configs.cmp",
--bufferline="custom.plugins.overrides.bufferline",
--feline="custom.plugins.feline",
--nvim_autopairs=require("custom.plugins.autopairs_selection"),
--signature="custom.plugins.lspsignature_coq",
--setup_lspconf = "custom.plugins.overrides.cmp_configs.lsp_config_cmp",
--setup_lspconf = require('custom.plugins.overrides.lsp_config_selection'),
--default_plugin_config_replace = tbl
