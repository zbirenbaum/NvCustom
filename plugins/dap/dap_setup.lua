local M = {}

M.config = function ()
	local adapters = {'python', 'lua'}  --list your adapters here
	require("custom.plugins.dap.dap_configs.dap_install")

	for _, adapter in ipairs(adapters) do
		require("custom.plugins.dap.dap_configs." .. adapter)
	end
end

M.setup = function ()
	vim.keymap.set('n', '<C-b>', function () require("dap").toggle_breakpoint() end, {silent=true, noremap=true})
	vim.keymap.set('n', '<Leader>r', function () require("dap").repl.toggle() end, {silent=true, noremap=true})
	vim.keymap.set('n', '<Leader>d', function () require("dapui").toggle() end, {silent=true, noremap=true})
	vim.keymap.set('n', '<C-o>', function () require("dap").step_out() end, {silent=true, noremap=true})
	vim.keymap.set('n', '<C-n>', function () require("dap").step_into() end, {silent=true, noremap=true})
	vim.keymap.set('n', '<C-c>',
		function()
			if vim.bo.filetype == "lua" and not require("dap").session() then
				require("osv").run_this()
			else
				require("dap").continue()
			end
		end,
		{silent=true, noremap=true})
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

