local M = {}

M.config = function()
  local adapters = { "python", "lua", "ccpp" } --list your adapters here
  for _, adapter in ipairs(adapters) do
    require("custom.plugins.dap.dap_configs." .. adapter)
  end
end

return M

--if you do not want to use dapui, specific widget windows can be loaded via lua instead like so
-- vim.api.nvim_set_keymap("n", "<Leader>s", '<Cmd>lua require"custom.plugins.dap_configs.widget_config".load_scope_in_sidebar()<CR>', {
--    silent = true,
--    noremap = true,
-- })
-- where custom.plugins.dap_configs.widget_config contains:
-- M = {}
-- local widgets = require('dap.ui.widgets')
--
-- M.load_scope_in_sidebar = function ()
--   local my_sidebar = widgets.sidebar(widgets.scopes)
--   my_sidebar.toggle()
-- end
--
-- return M
