local M = {}

M.exists = function ()
  local print_buf = vim.tbl_filter(function(buf)
    local has_var, _ = pcall(function()
      vim.api.nvim_buf_get_var(buf, "printbuf")
    end)
    return has_var and true
  end, vim.api.nvim_list_bufs())
  return not vim.tbl_isempty(print_buf) and print_buf[1] or false
end

M.clear = function ()
  local old_buf = M.buf
  M.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_var(M.buf, "printbuf", true)
  vim.api.nvim_win_set_buf(M.win, M.buf)
  vim.cmd('bdelete! ' .. old_buf)
end

M.init = function ()
  local linked_win = vim.api.nvim_get_current_win()
  M.print_buf =  M.exists() or M.new()
  vim.api.nvim_create_autocmd({"WinClosed"},{
    callback = vim.schedule_wrap(function ()
      if not vim.api.nvim_win_is_valid(linked_win) then
        local valid, _ = pcall(function() vim.api.nvim_win_close(M.win, true) end)
        if not valid then vim.cmd('quit') end
      end
    end),
    once = false
  })
  return M
end

local splitter = function(tbl, pattern)
  local result = {}
  for i, _ in ipairs(tbl) do
    result[#result+1] = vim.fn.split(tbl[i], pattern)
  end
  return vim.tbl_flatten(result)
end

local function format_table(text)
  text = vim.fn.split(vim.inspect(text), "\n") -- remove all newlines, have list
  text = splitter(text, "{\zs")
  text = splitter(text, "}\zs")
  return text
end

M.print = function (text)
  if not text then return end
  local setlines = vim.api.nvim_buf_set_lines
  if type(text) ~= "table" then
    text = {text}
    setlines(M.buf, 0, 0, false, text)
    return
  end
  if vim.tbl_islist(text) and type(text[1]) == "table" then
    for _, tbl in ipairs(text) do
      M.print(tbl)
    end
  else
    setlines(M.buf, 0, 0, false, format_table(text))
  end
end

M.close = function ()
  vim.api.nvim_win_close(M.win, true)
end

M.new = function ()
  M.oldwin = vim.api.nvim_get_current_win() --record current window
  vim.cmd("vsplit")
  M.win = vim.api.nvim_get_current_win()
  vim.wo.number = false 
  vim.wo.relativenumber = false
  vim.wo.numberwidth = 1
  vim.wo.signcolumn = "no"
  M.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_var(M.buf, "printbuf", true)
  vim.api.nvim_win_set_buf(M.win, M.buf)
  vim.api.nvim_set_current_win(M.oldwin)
  return M
end

return M
