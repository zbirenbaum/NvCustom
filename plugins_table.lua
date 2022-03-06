-- local present, packer = pcall(require, "custom.plugins.packer_init")
local plugin_status = require("custom.status")

local user_plugins = {
   ["nvim-lua/plenary.nvim"] = {"nvim-lua/plenary.nvim"},
   ["lewis6991/impatient.nvim"] = { "lewis6991/impatient.nvim" },
   ["wbthomason/packer.nvim"] = {"wbthomason/packer.nvim", event = "VimEnter"},
   ["lewis6991/gitsigns.nvim"] = {
      "lewis6991/gitsigns.nvim",
      disable = not plugin_status.gitsigns,
      opt = true,
      config = function () require("plugins.configs.others").gitsigns() end,
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   },
   ["max397574/better-escape.nvim"] = {
      "max397574/better-escape.nvim",
      disable = not plugin_status.better_escape,
      event = "InsertCharPre",
      config = function () require("plugins.configs.others").better_escape() end,
   },
   ["NvChad/nvim-colorizer.lua"] = {
      "NvChad/nvim-colorizer.lua",
      disable = not plugin_status.colorizer,
      after = {"indent-blankline.nvim"},
      config = function()
         vim.defer_fn(function ()
            require("plugins.configs.others").colorizer()
         end, 5)
      end,
   },
   ["kyazdani42/nvim-web-devicons"] = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
      after = {"nvim-base16.lua"},
      config = function () require("custom.plugins.overrides.icons").setup() end
   },
   ["lukas-reineke/indent-blankline.nvim"] = {
      "lukas-reineke/indent-blankline.nvim",
      disable = not plugin_status.blankline,
      after = {"feline.nvim"},
      config = function()
         vim.defer_fn(function ()
            require("custom.plugins.custom_plugin_configs.indent_blankline")
         end, 10)
      end,
   },
   ["feline-nvim/feline.nvim"] = {
      "feline-nvim/feline.nvim",
      disable = not plugin_status.feline,
      opt = true,
      after = {"nvim-base16.lua", "nvim-web-devicons"},
      config = function() vim.defer_fn(function() require("custom.plugins.overrides.statusline_builder.builder") end, 25) end
   },
   ["nvim-treesitter/nvim-treesitter"] = {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = {"BufRead", "BufNewFile"},
      config = function ()
         require("custom.plugins.overrides.treesitter")
      end,
   },
   ["numToStr/Comment.nvim"] = {
      "numToStr/Comment.nvim",
      disable = not plugin_status.comment,
      module = "Comment",
      keys = { "gcc" },
      config = function() require("plugins.configs.others").comment() end,
      setup = function()
         require("core.mappings").comment()
      end,
   },
   ["zbirenbaum/nvim-base16.lua"] = {
      "zbirenbaum/nvim-base16.lua",
      after = "packer.nvim",
      config = function()
         require("custom.colors").init()
      end,
   },
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
   ["rafamadriz/friendly-snippets"] = {
      "rafamadriz/friendly-snippets",
      disable = not plugin_status.cmp,
      event = "InsertEnter",
   },
   ["hrsh7th/nvim-cmp"] = {
      "hrsh7th/nvim-cmp", --float menu
      branch = "dev",
      after = "friendly-snippets",
      disable = not plugin_status.cmp,
      config = function()
         require "custom.plugins.completion_plugins.cmp_configs.cmp"
      end,
      requires = {"onsails/lspkind-nvim"}
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
   ["nvim-neorg/neorg"] = {
      "nvim-neorg/neorg",
      ft = "norg",
      after = "nvim-treesitter", -- You may want to specify Telescope here as well
      setup = function ()
         vim.cmd[[packadd neorg]]
      end,
      config = function ()
         require('neorg').setup {
            load = {
               ["core.defaults"] = {},
               ["core.norg.concealer"] = {},
            },
         }
      end
   },
   ['glacambre/firenvim'] = {
      'glacambre/firenvim',
      run = function()
         vim.fn['firenvim#install'](0)
      end,
      disable = not plugin_status.firenvim,
   },
   ["nathom/filetype.nvim"] = {
      "nathom/filetype.nvim",
      config = function ()
         require("filetype").setup({
            overrides = { function_extensions = {["norg"] = function () vim.bo.filetype = "norg" end,}}
         })
      end,
   },
   ["neovim/nvim-lspconfig"] = {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      setup = function()
         vim.cmd[[packadd nvim-lspconfig]]
      end,
      config = function()
         vim.schedule(function()
            plugin_status = require("core.utils").load_config().plugins.status
            local completion_engine = plugin_status.cmp and "cmp" or plugin_status.coq and "coq"
            if completion_engine == "coq" then
               return false
            end
            require("custom.plugins.lsp_plugins.lsp_init").setup_lsp(completion_engine)
         end, 20)
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
      after = {"nvim-web-devicons", "nvim-lspconfig", "nvim-treesitter"},
      disable = not plugin_status.trouble,
      config = function()
         vim.defer_fn(function() require("custom.plugins.custom_plugin_configs.trouble") end, 100)
      end
   },
   -- completion stuff
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
      opt=true,
      event = "BufReadPost",
      setup = function ()
         vim.schedule(function ()
            vim.cmd[[packadd nvim-dap]]
            vim.cmd[[packadd one-small-step-for-vimkind]]
            vim.cmd[[packadd DAPInstall.nvim]]
            require("custom.utils.mappings").debug()
            vim.schedule_wrap(require("custom.plugins.dap.dap_setup").config())
         end)
      end,
      requires = {
         "Pocco81/DAPInstall.nvim",
         "jbyuki/one-small-step-for-vimkind",
      },
   },
   ["theHamsta/nvim-dap-virtual-text"] = {
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      disable = not plugin_status.dap_vtext,
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
      after = "nvim-treesitter",
      config = function()
         vim.schedule_wrap(require "custom.plugins.custom_plugin_configs.lightspeed")
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

return user_plugins
