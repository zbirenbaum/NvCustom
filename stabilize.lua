-- local pos = vim.api.nvim_win_get_cursor(0)
local function check_type(buf)
  return vim.api.nvim_buf_call(buf, function ()
    return vim.bo.buftype == ''
  end)
end

local cpos = {}
vim.api.nvim_create_autocmd({"WinNew"}, {
  callback = function ()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      cpos[win] = {
        pos = vim.api.nvim_win_get_cursor(win),
        first = vim.fn.line('w0'),
        last = vim.fn.line('w$'),
        buf = vim.api.nvim_win_get_buf(win)
      }
      vim.schedule(function()
        if check_type(cpos[win].buf) then
        --execute pre open
          vim.api.nvim_win_set_cursor(win, {cpos[win].first, 0})
          vim.api.nvim_win_call(win, function () vim.cmd('normal zt') end)
        end
      end)
    end
    vim.schedule(function ()
      for win, win_info in pairs(cpos) do
        if vim.api.nvim_win_is_valid(win) and check_type(win_info.buf) then
          vim.api.nvim_win_set_cursor(win, win_info.pos)
        end
        cpos[win] = nil
      end
    end)
  end
})















































