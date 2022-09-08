local M = {}

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "VimEnter" }, {
  callback = function()
    require("custom.utils.filetypes")
    require("custom.utils.mappings").tab()
    require("custom.utils.hot_reload")
    -- require("custom.testserver").start()
  end,
  once = true,
})

M.options = { require("custom.utils.set_globals") }

M.ui = {
  hl_override = "custom.plugins.overrides.hl_override",
  italic_comments = true,
  transparency = true,
  theme = "onedark",
}

M.plugins = {
  options = {
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
  remove = require("custom.default_plugins"),
  override = {["wbthomason/packer.nvim"] = require("custom.plugins.packer_init" )},
}

M.plugins.user = require(M.plugins.install)

M.mappings = {
  plugins = {},
  terminal = {
    esc_termmode = {nil},
    spawn_horizontal = {nil},
    spawn_vertical= {nil},
    new_horizontal = {nil},
    new_vertical = {nil},
  }
}

return M
