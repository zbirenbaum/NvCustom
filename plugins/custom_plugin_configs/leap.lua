require('leap').set_default_keymaps()
local hl = {
  LeapMatch = {fg = "#7123f9", bg = "#7123f9"},
  LeapLabelSecondary = {fg = "#7123f9", bg = "#7123f9"},
  LeapLabelPrimary = {fg = "#7123f9", bg = "#7123f9"},
}
for k,v in pairs(hl) do vim.api.nvim_set_hl(0, k, v) end
require('leap').init_highlight(true)
