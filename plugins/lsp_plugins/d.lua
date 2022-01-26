local notify = require("notify")
local a = require "async"

local function on_move()
   return false
end

local do_thing = a.sync(function (val)
  local o = a.wait(async_func())
  return o + val
end)

local main = a.sync(function ()
  local thing = a.wait(do_thing()) -- composable!

  local x = a.wait(async_func())
  local y, z = a.wait_all{async_func(), async_func()}
end)

main()
NOTIFIED = true

local function match_to_buffer(bufnr, lnum)
   local cur_bufnr = vim.api.nvim_buf_get_number(0)
   local cur_lnum = vim.api.nvim_win_get_cursor(0)[1]-1
   if bufnr == cur_bufnr and lnum == cur_lnum then
      print("did it")
      return true 
   end
end

local function filter_diagnostics(diagnostics) local filtered = {}
   for diagnostic, diaginfo in pairs(diagnostics) do
      --      print(diaginfo.lnum)
      if match_to_buffer(diaginfo.bufnr, diaginfo.lnum) then
         filtered[diagnostic] = diaginfo
      end
   end
   return filtered
end
local function get_buf_diagnostics(diagnostics)
   local buf_diagnostics={}
   if diagnostics then
      buf_diagnostics=filter_diagnostics(diagnostics)
   end
   return buf_diagnostics
end


vim.diagnostic.config({
   virtual_text=false,
   -- ["my/notify"] = {}
})

-- vim.diagnostic.handlers["my/notify"] = {
--    show = function(namespace, bufnr, diagnostics, opts)
--       local line_diagnostics = get_buf_diagnostics(diagnostics)
--       for _,info in pairs(line_diagnostics) do
--          notify(info.message, "error", {
--             keep=function()
--                return vim.api.nvim_win_get_cursor(0)[1] == old_pos[1]
--             end,
--             on_open = function()
--                old_pos = vim.api.nvim_win_get_cursor(0)
--             end,
--             timeout=1,
--          })
--       end
--    end
-- }


local function notify_diagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end
  local msg = ""
  for n, v in ipairs(line_diagnostics) do
     msg = msg .. n .. ": " .. v.message .. "\n"
  end
  local async = require("plenary.async")
  local notify = require("notify").async

   async.run(function()
     notify("Let's wait for this to close").close()
     notify("It closed!")
   end)
   notify(msg, "error", {
      keep=function()
         vim.cmd [[ autocmd ]]
      end,
   })
end

local function notify_diagnostic()
end
-- function filter(func, tbl)
   --    local newtbl= {}
   --    for i,v in pairs(tbl) do
   --       if func(v) then
   --          newtbl[i]=v
   --       end
   --    end
   --    return newtbl
   -- end

   -- vim.o.updatetime = 100
   -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({scope="cursor", focus=false})]]

   -- ["my/notify"] = {
      -- 
