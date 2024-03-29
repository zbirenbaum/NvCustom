local plugin_status = require("custom.status")

local user_plugins = {
  ["zbirenbaum/copilot.lua"] = {
    branch = "master",
    disable = not plugin_status.copilot,
    after = "nvim-lspconfig",
    config = function()
      vim.defer_fn(function()
        require('custom.plugins.completion_plugins.copilot');
      end, 100)
    end,
  },
  ["zbirenbaum/copilot-cmp"] = {
    disable = not plugin_status.copilot,
    after = { "copilot.lua", "nvim-cmp" },
    config = function ()
      require("copilot_cmp").setup({
        clear_after_cursor=true,
      })
    end
  },

  ["monkoose/matchparen.nvim"] = {
    after = "nvim-treesitter",
    config = function()
      require("matchparen").setup()
    end,
  },
  -- ["NvChad/base46"] = {
  --   config = function()
  --     local ok, base46 = pcall(require, "base46")
  --     if ok then base46.load_theme() end
  --   end,
  -- },
  -- ["EdenEast/nightfox.nvim"] = {
  --   after = "packer.nvim",
  --   config = function()
  --     require("custom.colors.nightfox")
  --   end,
  -- },
  -- ["folke/tokyonight.nvim"] = {
  --   after = {"packer.nvim"},
  --   config = function()
  --     require("custom.colors.tokyonight")
  --   end,
  -- },

  ["zbirenbaum/nvim-base16.lua"] = {
    after = "packer.nvim",
    config = function()
      require("custom.colors").init('onedark')
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    disable = not plugin_status.null_ls,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    config = function ()
      vim.defer_fn(function ()
        require("custom.plugins.lsp_plugins.null_ls")
      end, 200)
    end,
  },
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
  ["lewis6991/gitsigns.nvim"] = {
    disable = not plugin_status.gitsigns,
    opt = true,
    config = function()
      require("gitsigns").setup({
        _extmark_signs = true,
        signs = {
           add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
           change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
           delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
           topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
           changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        },
      })
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
  ["kyazdani42/nvim-web-devicons"] = {
    opt = true,
    module='nvim-web-devicons',
    -- after = { "nvim-base16.lua" },
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
    keys = { "gcc", "<leader>/" },
    config = function()
      require("Comment").setup()
      require("custom.utils.mappings").comment()
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
    -- wants = "friendly-snippets",
    module = "luasnip",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        defaults = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
      })
      -- require("luasnip.loaders.from_vscode").load()
    end,
  },
  ["rafamadriz/friendly-snippets"] = {
    disable = true,
    -- disable = not plugin_status.cmp,
  },
  ["hrsh7th/nvim-cmp"] = {
    -- after = "friendly-snippets",
    event = { "InsertEnter", "CursorHold" },
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
        require("custom.plugins.lsp_plugins.lsp_init").setup_lsp('cmp')
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
    module = 'trouble',
    config = function()
      require("custom.plugins.custom_plugin_configs.trouble")
    end,
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
    module = "dap",
    config = function ()
      require("custom.plugins.dap.dap_setup").config()
    end,
    setup = function ()
      require("custom.utils.mappings").debug()
    end,
  },
  ["jbyuki/one-small-step-for-vimkind"] = {
    module = "osv"
  },
  ["mxsdev/nvim-dap-vscode-js"] = {
    module = {'dap', 'dap-vscode-js'}
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
  -- ["declancm/cinnamon.nvim"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   config = function()
  --     require("cinnamon").setup({
  --       default_config = false,
  --     })
  --   end,
  -- },
  -- ["karb94/neoscroll.nvim"] = {
  --   -- disable = not plugin_status.neoscroll,
  --   opt = true,
  --   config = function()
  --     require("custom.plugins.custom_plugin_configs.neoscroll")
  --   end,
  --   setup = function()
  --     require("core.utils").packer_lazy_load("neoscroll.nvim")
  --   end,
  -- },
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

