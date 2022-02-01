local plugin_status = require("core.utils").load_config().plugins.status

local plugins = {
   ["neovim/nvim-lspconfig"] = {
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
   },
   ["ray-x/lsp_signature.nvim"] = {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      disable = not plugin_status.lsp_signature,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.lspsignature_cmp"
      end,
   },
   ["folke/lua-dev.nvim"] = {
      "folke/lua-dev.nvim",
      ft='lua',
      after="nvim-lspconfig",
      disable = not plugin_status.luadev,
   },
   ["bfredl/nvim-luadev"] = {
      "bfredl/nvim-luadev",
      ft='lua',
      cmd={"Luadev", "Luadev-run", "Luadev-RunWord", "Luadev-Complete"},
      after="nvim-lspconfig",
      config = function()
         vim.schedule(function()
            require("luadev")
         end)
      end,
   },
   ["folke/trouble.nvim"] = {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      after = "nvim-lspconfig",
      disable = not plugin_status.trouble,
      config = function()
         require("custom.plugins.custom_plugin_configs.trouble")
      end
   },
   ["onsails/lspkind-nvim"] = {
      "onsails/lspkind-nvim",
   },
   -- completion stuff
   ['ms-jpq/coq_nvim'] = {
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
   },
   -- load luasnips + cmp related in insert mode only
   ["rafamadriz/friendly-snippets"] = {
      "rafamadriz/friendly-snippets",
      disable = not plugin_status.cmp,
      event = "InsertEnter",
   },
   ["hrsh7th/nvim-cmp"] = {
      "Iron-E/nvim-cmp", --float menu
      branch = "feat/completion-menu-borders",
      after = "friendly-snippets",
      disable = not plugin_status.cmp,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.cmp"
      end,
   },
   ["saadparwaiz1/cmp_luasnip"] = {
      "saadparwaiz1/cmp_luasnip",
      disable = not plugin_status.cmp,
      after = "LuaSnip",
   },
   ["hrsh7th/cmp-nvim-lua"] = {
      "hrsh7th/cmp-nvim-lua",
      disable = not plugin_status.cmp,
      after = "cmp_luasnip",
   },
   ["hrsh7th/cmp-nvim-lsp"] = {
      "hrsh7th/cmp-nvim-lsp",
      disable = not plugin_status.cmp,
      after = "cmp-nvim-lua",
   },

   ["hrsh7th/cmp-buffer"] = {
      "hrsh7th/cmp-buffer",
      disable = not plugin_status.cmp,
      after = "cmp-nvim-lsp",
   },

   ["hrsh7th/cmp-path"] = {
      "hrsh7th/cmp-path",
      disable = not plugin_status.cmp,
      after = "cmp-buffer",
   },
   ["windwp/nvim-autopairs"] = {
      "windwp/nvim-autopairs",
      disable = not plugin_status.autopairs or not plugin_status.cmp,
      after = "nvim-cmp",
      config = function()
         require("custom.plugins.completion_plugins.autopairs")
      end,
   },
   --dap stuff
   ['mfussenegger/nvim-dap'] = {
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
   },
   ["theHamsta/nvim-dap-virtual-text"] = {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      disable = not plugin_status.dap,
      config = function ()
         require("nvim-dap-virtual-text").setup()
      end,
   },
   --misc plugins
   ["akinsho/toggleterm.nvim"] = {
      "akinsho/toggleterm.nvim",
      disable = not plugin_status.toggleterm,
      event = "BufReadPost",
      config = function()
         require "custom.plugins.custom_plugin_configs.toggleterm"
      end,
   },
   ["ggandor/lightspeed.nvim"] = {
      "ggandor/lightspeed.nvim",
      disable = not plugin_status.lightspeed,
      config = function()
         require "custom.plugins.custom_plugin_configs.lightspeed"
      end,
      event = "BufReadPost"
   },
   ["gennaro-tedesco/nvim-jqx"] = {
      "gennaro-tedesco/nvim-jqx",
      disable = not plugin_status.jqx,
      event = "BufReadPost",
   },
   ['monkoose/matchparen.nvim'] = {
      'monkoose/matchparen.nvim',
      disable = not plugin_status.matchparen,
      config = function()
         require("custom.plugins.custom_plugin_configs.matchparen")
      end,
   },
   ['seblj/nvim-tabline'] = {
      'seblj/nvim-tabline',
      requires='kyazdani42/nvim-web-devicons',
      disable = not plugin_status.tabline,
      config=function()
         require "custom.plugins.custom_plugin_configs.tabline"
      end,
   },
   ["karb94/neoscroll.nvim"] = {
      "karb94/neoscroll.nvim",
      disable = not plugin_status.neoscroll,
      opt = true,
      config = function()
         require("custom.plugins.custom_plugin_configs.neoscroll")
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },
   ["L3MON4D3/LuaSnip"] = {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local luasnip = require("luasnip")
         luasnip.config.set_config({
            defaults = {
               history = true,
               updateevents = "TextChanged,TextChangedI",
            }
         })
         require("luasnip.loaders.from_vscode").load()
      end,
   },
   ["chentau/marks.nvim"] = {
      "chentau/marks.nvim",
      disable = not plugin_status.marks,
      config = function ()
         require("custom.plugins.custom_plugin_configs.marks")
      end,
      setup = function()
         require("core.utils").packer_lazy_load "marks.nvim"
      end,
   },
}

return plugins