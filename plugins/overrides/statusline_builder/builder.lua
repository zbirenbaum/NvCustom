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

local ct = require("custom.plugins.overrides.statusline_builder.components")
local left = {}
local right = {}
local middle = {}
--table.insert(left, ct.main_icon)
--

--table.insert(left, ct.mode.left_sep)
--table.insert(left, ct.mode.mode_icon)
table.insert(left, ct.mode.mode_string)
--table.insert(left, ct.mode.right_sep)
table.insert(left, ct.dir)
table.insert(left, ct.file)


table.insert(left, ct.lsp)
table.insert(left, ct.diagnostics.errors)
table.insert(left, ct.diagnostics.warnings)
table.insert(left, ct.diagnostics.hints)
table.insert(left, ct.diagnostics.info)
table.insert(left, ct.diagnostics.spacer)
table.insert(middle, ct.progress)

--disabled for slow startup

--table.insert(middle, ct.signature(80))
--vim.defer_fn(insert_gps, 150)

table.insert(right, ct.git.branch)
--table.insert(right, ct.git.git_sep)

table.insert(right, ct.git.added)
table.insert(right, ct.git.changed)
table.insert(right, ct.git.removed)

--table.insert(right, ct.location.left_sep)
table.insert(right, ct.location.loc_icon)
table.insert(right, ct.location.loc_string)
components.active[1] = left
components.active[2] = middle
components.active[3] = right


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
