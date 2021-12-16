-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad
local hooks = require "core.hooks"
local plugin_status = require("core.utils").load_config().plugins.status

-- local function afterchoice()
--   if plugin_status.coq_nvim then
--     return "coq_nvim"
--   elseif plugin_status.cmp then
--     return "nvim-cmp"
--   end
-- end
--
-- local aft = afterchoice()


hooks.add("install_plugins", function(use)
  use {
    "akinsho/toggleterm.nvim",
    disable = not plugin_status.toggleterm,
    event = "BufEnter",
    config = function()
      require "custom.plugins.toggleterm"
    end,
  }
  use {
    "phaazon/hop.nvim",
    branch='v1',
    disable = not plugin_status.hop,
    event = "BufRead",
    config = function()
      require "custom.plugins.hop"
    end,
  }
  use {
    "ggandor/lightspeed.nvim",
    disable = not plugin_status.lightspeed,
    event = "BufRead",
    config = function()
      require "custom.plugins.lightspeed"
    end,
  }
  use {
    "gennaro-tedesco/nvim-jqx",
    disable = not plugin_status.jqx,
    event = "BufRead",
  }
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    disable = not plugin_status.coq_nvim,
    config = function()
      require "custom.plugins.coq_configs.coq"
    end,
    requires = {
      {'ms-jpq/coq.artifacts', branch = 'artifacts'},
      {'ms-jpq/coq.thirdparty', branch = '3p'},
    },
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    --after = "nvim-lspconfig",
    disable = not plugin_status.trouble,
    config = function()
      require("custom.plugins.trouble")
    end
  }
  use {
    'mfussenegger/nvim-dap',
    after = "coq_nvim",
    disable = not plugin_status.dap,
    config = function()
      require "custom.plugins.dap"
    end,
    requires = {
      "Pocco81/DAPInstall.nvim",
      "mfussenegger/nvim-dap-python",
    },
  }
  use {
    "rcarriga/nvim-dap-ui",
    disable = not plugin_status.dap,
    after = "nvim-dap",
    config = function()
      require("dapui").setup()
    end,
  }
  use {
    'seblj/nvim-tabline',
    requires='kyazdani42/nvim-web-devicons',
    disable = not plugin_status.tabline,
    config=function()
      require "custom.plugins.tabline"
    end,
  }
  --vscode style popup for ex mode
  use {
    'VonHeikemen/fine-cmdline.nvim',
    disable = not plugin_status.cmdline,
    config=function()
      require "custom.plugins.cmdline"
    end,
    requires = {
      {'MunifTanjim/nui.nvim'}
    }
  }
  use {
    "onsails/lspkind-nvim",
    disable=not plugin_status.lspkind,
  }
  use {
    "rcarriga/nvim-notify",
    disable=not plugin_status.cmdheight,
    config=function()
      require "custom.unofficial_cmdheight_msgfunc.msgfunc"
    end
  }
  use {
    'monkoose/matchparen.nvim',
    disable = not plugin_status.matchparen,
    config = function()
      require("custom.plugins.matchparen")
    end,
  }
  --   --opt = true,
  --   end,
  -- }
  --slow startup, not using
  use {
    "SmiteshP/nvim-gps",
    after="feline.nvim",
    disable=true
--    requires={"nvim-treesitter/nvim-treesitter"},
  }
  -- use {
  --   "gelguy/wilder.nvim",
  --   disabled = true,
  --   --not plugin_status.wilder,
  --   config = function ()
  --     require("custom.plugins.wilder")
  --   end
  -- }
  -- use {
  --   "windwp/nvim-autopairs",
  --   after = aft,
  --   disable = not plugin_status.autopairs,
  --   config = function()
  --     --require "custom.plugins.coq_configs.autopairs_coq"
  --     require "custom.plugins.autopairs_selection"
  --   end,
  -- }

  -- use {
  --   "oberblastmeister/termwrapper.nvim",
  --   disable = not plugin_status.termwrapper,
  --   event = "BufRead",
  --   config = function()
  --     require "custom.plugins.termwrapper"
  --   end,
  -- }
  -- use {
  --   'folke/tokyonight.nvim',
  -- }
end)
