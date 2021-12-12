-- local M = {}
-- local function hide_status ()
--   vim.cmd [[ set laststatus=0 ]]
-- end
--
-- local function show_status ()
--   vim.cmd [[ set laststatus=2 ]]
-- end
--
-- local function hide_cmd ()
--   vim.cmd [[ set cmdheight=0 ]]
-- end
--
-- local function show_cmd ()
--   vim.cmd [[ set cmdheight=1 ]]
-- end
-- M.on_cmd_enter = function ()
--   hide_status()
--   show_cmd()
-- end
--
-- M.on_cmd_exit = function ()
--   hide_cmd()
--   show_status()
-- end

local M = {}
M.on_cmd_enter = function ()
  vim.cmd [[ set laststatus=0 ]]
  vim.cmd [[ set cmdheight=1 ]]
end

M.on_cmd_exit = function ()
  vim.cmd [[ set cmdheight=0 ]]
  vim.cmd [[ set laststatus=2 ]]
end

return M
