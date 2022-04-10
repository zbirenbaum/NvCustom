local M = {}

M.init = function ()
  local print_buf = M.new()
  print = print_buf.print
  vim.keymap.set({"i", "n"}, "<C-n>", function() vim.cmd("luafile %") end, {silent = true})
  vim.api.nvim_create_autocmd({"WinClosed"}, {
    callback = function ()
      print_buf.close()
      vim.cmd("quit")
    end
  })
  return print_buf
end

M.print = function (text)
  if type(text) == "table" then text = table.concat(text, " ") end
  vim.api.nvim_buf_set_lines(M.buf, 0, 0, false, {text})
  vim.cmd("ColorizerReloadAllBuffers")
end

M.close = function ()
  vim.api.nvim_win_close(M.win, true)
end

M.new = function ()
  M.oldwin = vim.api.nvim_get_current_win() --record current window
  vim.cmd("vsplit")
  M.win = vim.api.nvim_get_current_win()
  M.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(M.win, M.buf)
  vim.cmd("ColorizerAttachToBuffer")
  vim.api.nvim_set_current_win(M.oldwin)
  return M
end

return M
