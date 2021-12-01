local colors = require("colors").get()
local lsp = require "feline.providers.lsp"
-- local lsp = require "feline.providers.lsp"

local components = {
  active = {},
  inactive = {},
}
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

local ct = require("custom.plugins.statusline_builder.components")
local left = {}
table.insert(left, ct.main_icon)
table.insert(left, ct.file)
table.insert(left, ct.dir)

table.insert(left, ct.git.added)
table.insert(left, ct.git.changed)
table.insert(left, ct.git.removed)

components.active[1] = left


local InactiveStatusHL = {
  fg = colors.one_bg2,
  bg = "NONE",
  style = "underline",
}

components.inactive = {
  {
    {
      provider = " ",
      hl = InactiveStatusHL,
    },
  },
}

require("feline").setup {
  colors = {
    bg = colors.statusline_bg,
    fg = colors.fg,
  },
  components = components,
}
