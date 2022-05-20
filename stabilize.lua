local S = {}

local set_pos = function (win, pos)
  print(vim.inspect(pos))
  if not pos then return end
  vim.api.nvim_win_set_cursor(win, pos)
end

local foreach = function (t, fn)
  local it = vim.tbl_islist(t) and ipairs or pairs
  for k, v in it(t) do fn(k, v) end
end

local pre_split = function ()
  local win_pos = {}
  foreach(vim.api.nvim_tabpage_list_wins(0), function (_, w)
    win_pos[w] = {
      new = {vim.api.nvim_win_call(w, function () return vim.fn.line('w0') end), 0},
      old = vim.api.nvim_win_get_cursor(w),
    }
    set_pos(w, win_pos[w].new)
  end)
  return win_pos
end

local get_new_win = function (win_pos)
  local new_win = vim.tbl_filter(function (v)
    return win_pos[v] == nil
  end, vim.api.nvim_tabpage_list_wins(0))
  return new_win[1]
end

local post_split = function (win_pos)
  vim.schedule(function()
    local cur = win_pos['cur']
    local new_win = get_new_win(win_pos)
    if vim.api.nvim_win_get_buf(new_win) == vim.api.nvim_win_get_buf(cur.win) then
      win_pos[new_win] = win_pos[cur.win]
    end
    foreach(win_pos, function (k, v)
      vim.schedule(function() set_pos(k, v.old) end)
    end)
  end)
end

S.split = function ()
  local win_pos = pre_split()
  win_pos['cur'] = {
    buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win()),
    win = vim.api.nvim_get_current_win(),
  }
  vim.cmd("split")
  post_split(win_pos)
end

return S

-- -- local pos = vim.api.nvim_win_get_cursor(0)
-- local function check_type(buf)
--   return vim.api.nvim_buf_call(buf, function ()
--     return vim.bo.buftype == ''
--   end)
-- end
--
-- local cpos = {}
-- vim.api.nvim_create_autocmd({"WinNew"}, {
--   callback = function ()
--     for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
--       cpos[win] = {
--         pos = vim.api.nvim_win_get_cursor(win),
--         first = vim.fn.line('w0'),
--         last = vim.fn.line('w$'),
--         buf = vim.api.nvim_win_get_buf(win)
--       }
--       vim.schedule(function()
--         if check_type(cpos[win].buf) then
--         --execute pre open
--           vim.api.nvim_win_set_cursor(win, {cpos[win].first, 0})
--           vim.api.nvim_win_call(win, function () vim.cmd('normal zt') end)
--         end
--       end)
--     end
--     vim.schedule(function ()
--       for win, win_info in pairs(cpos) do
--         if vim.api.nvim_win_is_valid(win) and check_type(win_info.buf) then
--           vim.api.nvim_win_set_cursor(win, win_info.pos)
--         end
--         cpos[win] = nil
--       end
--     end)
--   end
-- })

