--require('dap-python').setup("/home/zach/.virtualenvs/py3nvim/bin/python")
local adapters = {'python'}  --list your adapters here

for _, adapter in ipairs(adapters) do
  require("custom.plugins.dap_configs." .. adapter)
end

local function dap_mappings()
   vim.api.nvim_set_keymap("n", "<Leader>r", '<Cmd>lua require"dap".repl.toggle()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<Leader>d", '<Cmd>lua require"dapui".toggle()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-b>", '<Cmd>lua require"dap".toggle_breakpoint()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-c>", '<Cmd>:lua require"dap".continue()<CR>',{
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-s>", '<Cmd>lua require"dap".step_over()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-S>", '<Cmd>lua require"dap".step_into()<CR>', {
      silent = true,
      noremap = true,
   })
end

dap_mappings()

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

