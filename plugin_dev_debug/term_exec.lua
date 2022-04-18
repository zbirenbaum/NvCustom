local M = {}
local job = require("plenary").job
M.job = nil

local set_win_opts = function ()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.numberwidth = 1
  vim.wo.signcolumn = "no"
end

local remember_and_exec = function (func, cmd)
  M.oldwin = vim.api.nvim_get_current_win() --record current window
  local val = func(cmd)
  vim.api.nvim_set_current_win(M.oldwin)
  return val
end


local run_in_win = function (job, cmd, shell)
  vim.api.nvim_chan_send(cmd)
end

local set_win_term = function()
  M.win = M.win and vim.api.nvim_win_is_valid(M.win) and M.win or remember_and_exec(M.create)
  vim.api.nvim_set_current_win(M.win)
end

local function handler (err, data, _)
  local msg = data or err
  vim.api.nvim_buf_set_lines(M.buf, 0, 0, false, msg)
end

local create_win = function (buf)
  local oldwin = vim.api.nvim_get_current_win() --record current window
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  set_win_opts()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_set_current_win(oldwin)
  return win
end

local create_buf = function ()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_var(buf, "type", 'prompt')
  return buf
end

M.run = function (cmd)
  M.buf = create_buf()
  M.win = create_win(M.buf)
  vim.api.nvim_chan_send(M.buf, 'ls')
  -- vim.schedule(function()
  --   run_in_win(cmd)
  --   vim.schedule(function()
  --     vim.cmd('stopinsert')
  --   end)
  -- end)
  return M
end

M.exists = function ()
  local print_buf = vim.tbl_filter(function(buf)
    local has_var, _ = pcall(function()
      vim.api.nvim_buf_get_var(buf, "termrun")
    end)
    return has_var and true
  end, vim.api.nvim_list_bufs())
  return not vim.tbl_isempty(print_buf) and print_buf[1] or false
end

M.clear = function ()
  local old_buf = M.buf
  M.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_var(M.buf, "termrun", true)
  vim.api.nvim_win_set_buf(M.win, M.buf)
  if old_buf then vim.cmd('bdelete! ' .. old_buf) end
  M.job_id = vim.fn.termopen('zsh')
end

M.close = function ()
  vim.api.nvim_win_close(M.win, true)
end

return M
