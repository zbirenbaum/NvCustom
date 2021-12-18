local M = {}

M.is_visual = function()
  if vim.api.nvim_get_mode() == 'v' then
    return vim.fn.visualmode()
  end
end

return M

