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
      config = function ()
         require("nvim-dap-virtual-text").setup()
      end,
   }
   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      config = function()
         
         require("plugins.configs.others").lsp_handlers()

         local function on_attach(_, bufnr)
            local function buf_set_option(...)
               vim.api.nvim_buf_set_option(bufnr, ...)
            end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

            require("core.mappings").lspconfig()
         end

         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
         capabilities.textDocument.completion.completionItem.snippetSupport = true
         capabilities.textDocument.completion.completionItem.preselectSupport = true
         capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
         capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
         capabilities.textDocument.completion.completionItem.deprecatedSupport = true
         capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
         capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
         capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
               "documentation",
               "detail",
               "additionalTextEdits",
            },
         }

         -- requires a file containing user's lspconfigs
         require("custom.plugins.overrides.cmp_configs.lsp_config_cmp").setup_lsp(on_attach, capabilities)
      end,
      -- lazy load!
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      opt = true,
   }
   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.overrides.cmp_configs.lspsignature_cmp"
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
      after = "friendly-snippits",
      config = function()
         require "custom.plugins.overrides.cmp_configs.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local luasnip = require "luasnip"
         luasnip.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
         }
         require("luasnip/loaders/from_vscode").load()
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
      disable = not plugin_status.autopairs,
      after = "nvim-cmp",
      config = function()
         local autopairs = require "nvim-autopairs"
         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
         autopairs.setup { fast_wrap = {} }
         local cmp = require "cmp"
         cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
   }
end)

