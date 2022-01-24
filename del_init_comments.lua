-- hooks.add("install_plugins", function(use)
--   use {
--     "phaazon/hop.nvim",
--     branch='v1',
--     disable = not plugin_status.hop,
--     event = "BufRead",
--     config = function()
--       require "custom.plugins.hop"
--     end,
--   }
--   use {
--     'ms-jpq/coq_nvim',
--     branch = 'coq',
--     disable = not plugin_status.coq_nvim,
--     config = function()
--       require "custom.plugins.overrides.coq_configs.coq"
--     end,
--     requires = {
--       {'ms-jpq/coq.artifacts', branch = 'artifacts'},
--       {'ms-jpq/coq.thirdparty', branch = '3p'},
--     },
--   }
--   use {
--     "folke/trouble.nvim",
--     requires = "kyazdani42/nvim-web-devicons",
--     --after = "nvim-lspconfig",
--     disable = not plugin_status.trouble,
--     config = function()
--       require("custom.plugins.trouble")
--     end
--   }
--   use {
--     'mfussenegger/nvim-dap',
--     after = "coq_nvim",
--     disable = not plugin_status.dap,
--     config = function()
--       require "custom.plugins.dap.dap_setup"
--     end,
--     requires = {
--       "Pocco81/DAPInstall.nvim",
--       "mfussenegger/nvim-dap-python",
--     },
--   }
--   use {
--     "rcarriga/nvim-dap-ui",
--     disable = not plugin_status.dap,
--     after = "nvim-dap",
--     config = function()
--       require("dapui").setup()
--     end,
--   }
--   --vscode style popup for ex mode
--   use {
--     'VonHeikemen/fine-cmdline.nvim',
--     disable = not plugin_status.cmdline,
--     config=function()
--       require "custom.plugins.cmdline"
--     end,
--     requires = {
--       {'MunifTanjim/nui.nvim'}
--     }
--   }
--   use {
--     "rcarriga/nvim-notify",
--     disable=not plugin_status.cmdheight,
--     config=function()
--       require "custom.unofficial_cmdheight_msgfunc.msgfunc"
--     end
--   }
-- 	use {
-- 		"folke/lua-dev.nvim",
-- 		ft='lua',
-- 		after="nvim-lspconfig"
-- 	}
-- end)
--
--
--
--
-- use {
--   "SmiteshP/nvim-gps",
--   after="nvim-lspconfig",
--   opt=true,
--   event = "VimEnter",
--   setup = function()
--     require("core.utils").packer_lazy_load "nvim-gps"
--   end,
--   disable = not plugin_status.gps
-- }
