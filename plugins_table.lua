local plugin_status = require("custom.status")

local user_plugins = {
  ["dylon/vim-antlr"] = {
    ft = "antlr4",
  },
  ["nvim-lua/plenary.nvim"] = {
    module = "plenary",
    "nvim-lua/plenary.nvim"
  },
  ["lewis6991/impatient.nvim"] = {},
  ["wbthomason/packer.nvim"] = {},
  ["NvChad/nvterm"] = {
    keys = {'<C-l>', '<A-h>', '<A-v>', '<A-i>'},
    config = function ()
      require('nvterm').setup()
      require('custom.utils.mappings').terminal()
    end
  },
  ["zbirenbaum/neodim"] = {
    event = {"LspAttach"},
    config = function ()
      require("neodim").setup()
    end
  },
  ["zbirenbaum/copilot.lua"] = {
    branch = "master",
    disable = not plugin_status.copilot,
    after = "nvim-lspconfig",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          ft_disable = {"go"}
        })
      end, 100)
    end,
  },
  ["zbirenbaum/copilot-cmp"] = {
    disable = not plugin_status.copilot,
    after = { "copilot.lua", "nvim-cmp" },
  },
  ["lewis6991/gitsigns.nvim"] = {
    disable = not plugin_status.gitsigns,
    opt = true,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      require("core.utils").packer_lazy_load("gitsigns.nvim")
    end,
  },
  ["max397574/better-escape.nvim"] = {
    disable = not plugin_status.better_escape,
    event = "InsertCharPre",
    config = function()
      require("custom.plugins.overrides.better_escape")
    end,
  },
  ["NvChad/nvim-colorizer.lua"] = {
    disable = not plugin_status.colorizer,
    after = { "indent-blankline.nvim" },
    config = function()
      vim.defer_fn(function()
        require("plugins.configs.others").colorizer()
      end, 5)
    end,
  },
  ["kyazdani42/nvim-web-devicons"] = {
    opt = true,
    after = { "nvim-base16.lua" },
    config = function()
      require("custom.plugins.overrides.icons").setup()
    end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    disable = not plugin_status.blankline,
    after = { "feline.nvim" },
    config = function()
      vim.defer_fn(function()
        require("custom.plugins.custom_plugin_configs.indent_blankline")
      end, 10)
    end,
  },
  ["feline-nvim/feline.nvim"] = {
    disable = not plugin_status.feline,
    config = function()
      vim.defer_fn(function()
        require("custom.plugins.overrides.statusline_builder.builder")
      end, 25)
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      local setup = function() require("custom.plugins.overrides.treesitter") end
      if vim.bo.filetype == 'norg' then setup() else vim.defer_fn(setup, 10) end
    end,
  },
  ["nvim-treesitter/playground"] ={
    disable = not plugin_status.playground,
    after="nvim-treesitter",
    config = function()
      vim.api.nvim_create_autocmd({"CursorHold"}, {
        callback=function()
          vim.cmd(":TSHighlightCapturesUnderCursor")
        end
      })
    end,
  },
  ["numToStr/Comment.nvim"] = {
    disable = not plugin_status.comment,
    module = "Comment",
    keys = { "gcc" },
    setup = function () require("custom.utils.mappings").comment() end,
    config = function() require("Comment").setup() end,
  },
  ["zbirenbaum/nvim-base16.lua"] = {
    after = "packer.nvim",
    config = function()
      require("custom.colors").init()
    end,
  },
  ["ms-jpq/coq_nvim"] = {
    branch = "coq",
    disable = not plugin_status.coq,
    event = "BufReadPost",
    config = function()
      require("custom.plugins.completion_plugins.coq_configs.coq").config()
    end,
    setup = function()
      require("custom.plugins.completion_plugins.coq_configs.coq").setup()
    end,
    requires = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        defaults = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
      })
      require("luasnip.loaders.from_vscode").load()
    end,
  },
  ["rafamadriz/friendly-snippets"] = {
    disable = not plugin_status.cmp,
    event = { "InsertEnter", "CursorHold" },
  },
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    disable = not plugin_status.cmp,
    config = function()
      require("custom.plugins.completion_plugins.cmp_configs.cmp")
    end,
    requires = { "onsails/lspkind-nvim" },
  },
  ["saadparwaiz1/cmp_luasnip"] = {
    disable = not plugin_status.cmp,
    after = "LuaSnip",
  },

  ["hrsh7th/cmp-nvim-lua"] = {
    disable = not plugin_status.cmp,
    after = "cmp_luasnip",
  },
  ["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require("custom.plugins.custom_plugin_configs.neorg")
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    -- module = "lspconfig",
    after = "nvim-treesitter",
    config = function()
      vim.schedule(function()
        plugin_status = require("core.utils").load_config().plugins.status
        local completion_engine = plugin_status.cmp and "cmp" or plugin_status.coq and "coq"
        if completion_engine == "coq" then
          return false
        end
        require("custom.plugins.lsp_plugins.lsp_init").setup_lsp(completion_engine)
      end)
    end,
  },
  ["ray-x/lsp_signature.nvim"] = {
    after = "nvim-lspconfig",
    disable = not plugin_status.lsp_signature,
    config = function()
      require("custom.plugins.completion_plugins.cmp_configs.lspsignature_cmp")
    end,
  },
  ["folke/lua-dev.nvim"] = {
    ft = "lua",
    after = "nvim-lspconfig",
    disable = not plugin_status.luadev,
  },
  ["bfredl/nvim-luadev"] = {
    ft = "lua",
    cmd = { "Luadev", "Luadev-run", "Luadev-RunWord", "Luadev-Complete" },
    after = "nvim-lspconfig",
    config = function()
      vim.schedule(function()
        require("luadev")
      end)
    end,
  },
  ["folke/trouble.nvim"] = {
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh", "TroubleClose"},
    disable = not plugin_status.trouble,
    config = function() require("plugins.custom_plugin_configs.trouble") end,
  },
  -- completion stuff
  ["hrsh7th/cmp-nvim-lsp"] = {
    disable = not plugin_status.cmp,
    after = "cmp-nvim-lua",
  },

  ["hrsh7th/cmp-buffer"] = {
    disable = not plugin_status.cmp,
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-path"] = {
    disable = not plugin_status.cmp,
    after = "cmp-buffer",
  },
  ["kylechui/nvim-surround"] = {
    after = "nvim-cmp",
    config = function ()
      require("nvim-surround").setup()
    end,
  },
  ["windwp/nvim-autopairs"] = {
    disable = not plugin_status.autopairs or not plugin_status.cmp,
    after = "nvim-cmp",
    config = function()
      require("custom.plugins.completion_plugins.autopairs")
    end,
  },
  --dap stuff
  ["mfussenegger/nvim-dap"] = {
    disable = not plugin_status.dap,
    opt = true,
    keys = require("custom.utils.mappings").debug_bindings.mappings,
    config = function ()
      require("custom.plugins.dap.dap_setup").config()
      require("custom.utils.mappings").debug()
    end,
    requires = {
      "jbyuki/one-small-step-for-vimkind",
    },
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    after = "nvim-dap",
    disable = not plugin_status.dap_vtext,
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  --misc plugins
  ["ggandor/lightspeed.nvim"] = {
    disable = not plugin_status.lightspeed,
    keys = {'f', 's', 'F', 'S'},
    config = function()
      vim.schedule_wrap(require("custom.plugins.custom_plugin_configs.lightspeed"))
    end,
  },
  ["gennaro-tedesco/nvim-jqx"] = {
    cmd = {"JqxList", "JqxQuery"},
    disable = not plugin_status.jqx,
  },
  ["monkoose/matchparen.nvim"] = {
    disable = not plugin_status.matchparen,
    config = function()
      require("custom.plugins.custom_plugin_configs.matchparen")
    end,
  },
  ["karb94/neoscroll.nvim"] = {
    -- disable = not plugin_status.neoscroll,
    opt = true,
    config = function()
      require("custom.plugins.custom_plugin_configs.neoscroll")
    end,
    setup = function()
      require("core.utils").packer_lazy_load("neoscroll.nvim")
    end,
  },
  ["chentau/marks.nvim"] = {
    disable = not plugin_status.marks,
    config = function()
      require("custom.plugins.custom_plugin_configs.marks")
    end,
    setup = function()
      require("core.utils").packer_lazy_load("marks.nvim")
    end,
  },
}

for k, _ in pairs(user_plugins) do
  user_plugins[k][1] = k
end

return user_plugins

