Lastline = nil
local a = require("plenary.async")
local notify = require("notify")

local d_level = {
   [1] = "ERROR",
   [2] = "WARN",
   [3] = "INFO",
   [4] = "DEBUG",
   [5] = "TRACE",
}
   
function Notifier(diagnostic_message, diagnostic_severity)
   notify(diagnostic_message, d_level[diagnostic_severity], {keep=function() return true end})
end

-- notifier = function (message, severity)
--    -- vim.diagnostic.severity.ERROR
--    -- vim.diagnostic.severity.WARN
--    -- vim.diagnostic.severity.INFO
--    -- vim.diagnostic.severity.HINT
--    notify(message, "info", {keep=function() return test end})
-- end
-- test = true
--
--
--TODO, when diagnostic changes update or close the notification
vim.diagnostic.config({
    virtual_text=false,
})

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  if not Lastline or Lastline ~= line_nr then
     Lastline = line_nr
  end
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  local diagnostic_severity = 5
  for i, diagnostic in ipairs(line_diagnostics) do
      Notifier(diagnostic.message, diagnostic.severity)
    -- diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    -- diagnostic_severity = diagnostic_severity<diagnostic.severity and diagnostic_severity or diagnostic.severity
    -- if i ~= #line_diagnostics then
    --    diagnostic_message = diagnostic_message .. "\n"
    -- end
  end
end
--
vim.o.updatetime = 100
-- vim.cmd [[ autocmd CursorMoved * lua test = false; print(test) ]]
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() test = true;]]
function TestLineChanged()
   line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1
   if not Lastline or Lastline ~= line_nr then
      Lastline = line_nr
      return true
   end
   return false
end

vim.cmd [[ au CursorHold * lua PrintDiagnostics() ]]

vim.cmd [[ autocmd TextChangedI * lua 
\     for _, winnm in ipairs(vim.api.nvim_list_wins()) do
\            for pos, winid in pairs(Windows) do 
\                  if winnm == winid then
\                          vim.api.nvim_win_close(winid, 0) 
\                          table.remove(Windows, pos) 
\                  end
\          end
\     
\ end]]
vim.cmd [[ autocmd TextChanged * lua 
\     for _, winnm in ipairs(vim.api.nvim_list_wins()) do
\            for pos, winid in pairs(Windows) do 
\                  if winnm == winid then
\                          vim.api.nvim_win_close(winid, 0) 
\                          table.remove(Windows, pos) 
\                  end
\          end
\     
\ end]]
vim.cmd [[ au CursorMoved * lua if TestLineChanged() then 
\     for _, winnm in ipairs(vim.api.nvim_list_wins()) do
\            for pos, winid in pairs(Windows) do 
\                  if winnm == winid then
\                          vim.api.nvim_win_close(winid, 0) 
\                          table.remove(Windows, pos) 
\                  end
\          end
\     end 
\ end]]
