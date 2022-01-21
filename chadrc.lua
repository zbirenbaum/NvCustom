local M = {}

require('impatient')
require('impatient').enable_profile()

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
   transparency = true,
}

-- these are plugin related options
M.plugins = {
   -- enable and disable plugins (false for disable)
   status = {
      autosave = false, -- to autosave files
      blankline = true, -- beautified blank lines
      --re-enable for testing
      bufferline = true, -- buffer shown as tabs
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
      nvimtree=false,

      --My Plugins
      toggleterm = true,
      jqx = true,
      autopairs = true,
      marks = false,
      gps = false,
      luadev = false,

      -- Completions, choose 1
      -- currently coq unsupported due to updates in cmp making it fall behind in usefulness. coq will work again soonish but will be temp broken due to new dir structure
      coq_nvim = false,
      cmp = true,
      dap = true,
      tabline=false,
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
      },
   },
   --default_plugin_config_replace = tbl
   default_plugin_config_replace = {
      telescope = { defaults = { prompt_prefix = " ?  "}},
      nvim_treesitter = { highlight = { enable = true}},
      nvim_autopairs = {},
      nvim_web_devicons = {
         override ={
            lua = {
               icon = "L",
               name = "lua",
            },
         }
      },
      gitsigns = {
         signs = {
            add = { hl = "DiffAdd", text = ">", numhl = "GitSignsAddNr" },
         }
      },
      nvim_colorizer = { --#000000
         user_default_options = {
              mode = "foreground"
         },
      },
      bufferline = { options= {buffer_close_icon = "+"}},

      signature="custom.plugins.overrides.cmp_configs.lspsignature_cmp",
      feline="custom.plugins.overrides.statusline_builder.builder",
      nvim_cmp = {
         formatting = {
            format = function(entry, vim_item)
               local icons = require "plugins.configs.lspkind_icons"
               
               icons = vim.tbl_deep_extend("force", icons, { Text="[]", TypeParameter="[]", Unit="[]"})
               vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

               vim_item.menu = ({
                  nvim_lsp = "[LSP]",
                  nvim_lua = "[Lua]",
                  buffer = "[BUF]",
               })[entry.source.name]

               return vim_item
            end,
         },
      }
      --nvim_cmp="custom.plugins.overrides.cmp_configs.cmp",
      --bufferline="custom.plugins.overrides.bufferline",
      --feline="custom.plugins.feline",
      --nvim_autopairs=require("custom.plugins.autopairs_selection"),
      --signature="custom.plugins.lspsignature_coq",
   },
}

M.mappings = {
}

M.mappings.plugins = {
}

return M

