local customPlugins = require "core.customPlugins"
local plugin_status = require("core.utils").load_config().plugins.status

customPlugins.add(function(use)
   use 'lewis6991/impatient.nvim'
   use {
      "akinsho/toggleterm.nvim",
      disable = not plugin_status.toggleterm,
      event = "BufEnter",
      config = function()
         require "custom.plugins.custom_plugin_configs.toggleterm"
      end,
   }
   use {
      "ggandor/lightspeed.nvim",
      disable = not plugin_status.lightspeed,
      event = "BufRead",
      config = function()
         require "custom.plugins.custom_plugin_configs.lightspeed"
      end,
   }
   use {
      "gennaro-tedesco/nvim-jqx",
      disable = not plugin_status.jqx,
      event = "BufRead",
   }
   use {
      "onsails/lspkind-nvim",
   }
   use {
      'monkoose/matchparen.nvim',
      disable = not plugin_status.matchparen,
      config = function()
         require("custom.plugins.custom_plugin_configs.matchparen")
      end,
   }
   use {
      'seblj/nvim-tabline',
      requires='kyazdani42/nvim-web-devicons',
      disable = not plugin_status.tabline,
      config=function()
         require "custom.plugins.custom_plugin_configs.tabline"
      end,
   }
   use {
      "folke/lua-dev.nvim",
      ft='lua',
      after="nvim-lspconfig",
      disable = not plugin_status.luadev,
   }
   use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      after = "nvim-lspconfig",
      disable = not plugin_status.trouble,
      config = function()
         require("custom.plugins.custom_plugin_configs.trouble")
      end
   }
   use {
      "karb94/neoscroll.nvim",
      disable = not plugin_status.neoscroll,
      opt = true,
      config = function()
         require("custom.plugins.custom_plugin_configs.neoscroll")
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   }
   use {
      "chentau/marks.nvim",
      disable = not plugin_status.marks,
      config = function ()
         require("custom.plugins.custom_plugin_configs.marks")
      end,
      setup = function()
         require("core.utils").packer_lazy_load "marks.nvim"
      end,
   }
   use {
      'mfussenegger/nvim-dap',
      disable = not plugin_status.dap,
      config = function ()
         require "custom.plugins.dap.dap_setup".config()
      end,
      setup = function ()
         require("custom.utils.mappings").dap()
      end,
      requires = {
         "Pocco81/DAPInstall.nvim",
         "jbyuki/one-small-step-for-vimkind",
      },
      after="nvim-lspconfig",
   }
   use {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      disable = not plugin_status.dap,
      config = function ()
         require("nvim-dap-virtual-text").setup()
      end,
   }
   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      config = function() require("custom.plugins.lsp_plugins.lsp_config") end,
   }
   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      disable = not plugin_status.lsp_signature,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.lspsignature_cmp"
      end,
   }
      -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      disable = not plugin_status.cmp,
      event = "InsertEnter",
   }
   
   use {
      "hrsh7th/nvim-cmp",
      after = "nvim-lspconfig",
      disable = not plugin_status.cmp,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.cmp"
      end,
      setup = require("core.utils").packer_lazy_load "nvim-cmp"
   }

   use {
      "L3MON4D3/LuaSnip",
      disable = not plugin_status.cmp,
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local present, luasnip = pcall(require, "luasnip")
         if present then
            local default = {
               history = true,
               updateevents = "TextChanged,TextChangedI",
            }
            luasnip.config.set_config(default)
            require("luasnip/loaders/from_vscode").load()
         end
      end,
   }
   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }
   use {"hrsh7th/cmp-nvim-lua", after = "cmp_luasnip",}
   use {
      "hrsh7th/cmp-nvim-lsp",
      disable = not plugin_status.cmp,
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      disable = not plugin_status.cmp,
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      disable = not plugin_status.cmp,
      after = "cmp-buffer",
   }
   use {
      "windwp/nvim-autopairs",
      disable = not plugin_status.autopairs,
      after = "nvim-cmp",
      config = function()
         require("custom.plugins.lsp_plugins.autopairs")
      end,
   }
end)
