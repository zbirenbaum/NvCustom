-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

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
		disable=not plugin_status.lspkind,
		event = "BufRead",
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
		"SmiteshP/nvim-gps",
		after="nvim-lspconfig",
		opt=true,
		event = "VimEnter",
		setup = function()
			require("core.utils").packer_lazy_load "nvim-gps"
		end,
		disable = not plugin_status.gps
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
