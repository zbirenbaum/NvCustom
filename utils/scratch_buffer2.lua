local win, buf
local function create_win()
   win = vim.api.nvim_get_current_win()
   local buf = vim.api.nvim_create_buf(true, true)
   vim.api.nvim_win_set_buf(win, buf)
   local result = vim.fn.split("fuck\nyou", "\n")
   vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)
end
