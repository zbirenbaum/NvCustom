local customPlugins = require "core.customPlugins"
local plugin_status = require("core.utils").load_config().plugins.status

customPlugins.add(function(use)
   --lsp stuff
   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.schedule_wrap(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      config = function()
         plugin_status = require("core.utils").load_config().plugins.status
         local completion_engine = plugin_status.cmp and "cmp" or plugin_status.coq and "coq"
         if completion_engine == "coq" then
            return false
         end
         require("custom.plugins.lsp_plugins.lsp_init").setup_lsp(completion_engine)
      end,
   }
   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      disable = not plugin_status.lsp_signature,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.lspsignature_cmp"
      end,
   }
   use {
      "folke/lua-dev.nvim",
      ft='lua',
      after="nvim-lspconfig",
      disable = not plugin_status.luadev,
   }
   use {
      "bfredl/nvim-luadev",
      ft='lua',
      cmd={"Luadev", "Luadev-run", "Luadev-RunWord", "Luadev-Complete"},
      after="nvim-lspconfig",
      config = function()
         vim.schedule(function()
            require("luadev")
         end)
      end,
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
      "onsails/lspkind-nvim",
   }
   -- completion stuff
   use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      disable = not plugin_status.coq,
      event = "BufReadPost",
      config = function()
         require("custom.plugins.completion_plugins.coq_configs.coq").config()
      end,
      setup = function()
         require("custom.plugins.completion_plugins.coq_configs.coq").setup()
      end,
      requires = {
         {'ms-jpq/coq.artifacts', branch = 'artifacts'},
         {'ms-jpq/coq.thirdparty', branch = '3p'},
      },
   }
   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      disable = not plugin_status.cmp,
      event = "InsertEnter",
   }
   use {
      "Iron-E/nvim-cmp", --float menu
      branch = "feat/completion-menu-borders",
      after = "friendly-snippets",
      disable = not plugin_status.cmp,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.cmp"
      end,
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
      disable = not plugin_status.cmp,
      after = "LuaSnip",
   }
   use {
      "hrsh7th/cmp-nvim-lua",
      disable = not plugin_status.cmp,
      after = "cmp_luasnip",
   }
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
      disable = not plugin_status.autopairs or not plugin_status.cmp,
      after = "nvim-cmp",
      config = function()
         require("custom.plugins.completion_plugins.autopairs")
      end,
   }
   --dap stuff
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
      }
   }
   use {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      disable = not plugin_status.dap,
      config = function ()
         require("nvim-dap-virtual-text").setup()
      end,
   }
   --misc plugins
   use {
      "akinsho/toggleterm.nvim",
      disable = not plugin_status.toggleterm,
      event = "BufReadPost",
      config = function()
         require "custom.plugins.custom_plugin_configs.toggleterm"
      end,
   }
   use {
      "ggandor/lightspeed.nvim",
      disable = not plugin_status.lightspeed,
      config = function()
         require "custom.plugins.custom_plugin_configs.lightspeed"
      end,
      event = "BufReadPost"
   }
   use {
      "gennaro-tedesco/nvim-jqx",
      disable = not plugin_status.jqx,
      event = "BufReadPost",
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
end)

