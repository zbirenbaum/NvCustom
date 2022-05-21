local ct = require("custom.plugins.overrides.statusline_builder.components")
local colors = require("custom.colors").get()

local components = {
  active = {},
  inactive = {},
}

components.active[1] = {  --left
  ct.mode.mode_string,
  ct.dir,
  ct.file,
  ct.lsp,
  ct.diagnostics.errors,
  ct.diagnostics.warnings,
  ct.diagnostics.hints,
  ct.diagnostics.info,
  ct.diagnostics.spacer,
}

components.active[2] = {  -- right
  ct.git.branch,
  ct.git.added,
  ct.git.changed,
  ct.git.removed,
  ct.tabs.left,
  ct.tabs.inactive_left,
  ct.tabs.active,
  ct.tabs.inactive_right,
  ct.tabs.right,
  ct.location.loc_icon,
  ct.location.loc_string,
}

components.inactive[1] = {
  provider = " ",
  hl = {
    fg = colors.one_bg2,
    bg = "NONE",
    style = "underline",
  }
}

require("feline").setup({
  colors = {
    bg = colors.statusline_bg,
    fg = colors.fg,
  },
  components = components,
})
