M = {}
local widgets = require("dap.ui.widgets")

M.load_scope_in_sidebar = function()
  local my_sidebar = widgets.sidebar(widgets.scopes)
  my_sidebar.toggle()
end

return M
