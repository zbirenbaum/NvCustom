local M = {}

require("custom.utils.set_globals")
require("custom.plugin_dev_debug.file_exec")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("custom.utils.hot_reload")
    require("custom.utils.mappings").navigation()
  end,
  once = true,
})

M.options = {
  -- NeoVim/Vim options
  clipboard = "unnamedplus",
  cmdheight = 1,
  ruler = false,
  hidden = true,
  ignorecase = true,
  mapleader = " ",
  mouse = "",
  number = true,
  nav_wrapper = true,
  -- relative numbers in normal mode tool at the bottom of options.lua
  numberwidth = 2,
  relativenumber = true,
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
  timeoutlen = 400,
  -- interval for writing swap file to disk, also used by gitsigns
  updatetime = 250,
  undofile = true, -- keep a permanent undo (across restarts)
  -- NvChad options
  nvChad = {
    copy_cut = true, -- copy cut text ( x key ), visual and normal mode
    copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
    insert_nav = true, -- navigation in insertmode
    window_nav = true,
    theme_toggler = false,
    terminal_numbers = true,
    -- used for updater
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
  terminal = {
    behavior = {
      close_on_exit = true,
    },
    window = {
      vsplit_ratio = 0.5,
      split_ratio = 0.3,
    },
    location = {
      horizontal = "belowright",
      vertical = "belowright",
    },
  },
}
-- ui configs
M.ui = {
  hl_override = "custom.plugins.overrides.hl_override",
  italic_comments = true,
  transparency = true,
  theme = "onedark",
}

M.plugins = {
  options = {
    packer = { init_file = "custom.plugins.packer_init" },
    statusline = { hide_disable = true },
  },
  install = "custom.plugins_table",
  default_plugin_config_replace = {
    better_escape = "custom.plugins.overrides.better_escape",
    feline = function()
      require("custom.plugins.overrides.statusline_builder.builder")
    end,
    --      nvim_treesitter = "custom.plugins.overrides.treesitter",
    indent_blankline = function()
      require("custom.plugins.custom_plugin_configs.indent_blankline")
    end,
  },
  status = require("custom.status"),
  default_plugin_remove = {
    -- "NvChad/extensions",
    "nvim-lua/plenary.nvim",
    "NvChad/nvim-colorizer.lua",
    "feline-nvim/feline.nvim",
    "NvChad/nvim-base16.lua",
    -- "akinsho/bufferline.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "kyazdani42/nvim-web-devicons",
    "lukas-reineke/indent-blankline.nvim",
  },
}

M.mappings = {
  plugins = {},
  terminal = {
    esc_termmode = {nil},
    spawn_horizontal = {nil},
    spawn_vertical= {nil},
    new_horizontal = "<A-s>",
    new_vertical = "<A-v>",
  }
}

return M
