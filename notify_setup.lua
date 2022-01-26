Windows = {}

require("notify").setup({
   -- Animation style (see below for details)
   stages = "static",
   -- Function called when a new window is opened, use for changing win settings/config
   on_open = function(window)
--      if Windows ~= {} then
         -- for _, win in ipairs(Windows) do
         --    vim.api.nvim_win_close(win, true)
         -- end
      table.insert(Windows, 1, window)
   end,
   on_close = nil,
   -- Function called when a window is closed
   -- on_close = function ()
   --    for pos, winid in pairs(Windows) do vim.api.nvim_win_close(winid, true)
   --       table.remove(Windows, pos) end
   --    end,
   -- Render function for notifications. See notify-render()
   render = "minimal",
   -- Default timeout for notifications
   timeout = 9999,
   -- For stages that change opacity this is treated as the highlight behind the window
   -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
   background_colour = "#000000",
   -- Minimum width for notification windows
   minimum_width = 50,
   -- Icons for the different levels
   icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
   },
})

vim.cmd[[ highlight NotifyERRORBorder guifg=#8A1F1F ]]
vim.cmd[[ highlight NotifyWARNBorder guifg=#79491D]]
vim.cmd[[ highlight NotifyINFOBorder guifg=#4F6752]]
vim.cmd[[ highlight NotifyDEBUGBorder guifg=#8B8B8B]]
vim.cmd[[ highlight NotifyTRACEBorder guifg=#4F3552]]
vim.cmd[[ highlight NotifyERRORIcon guifg=#F70067]]
vim.cmd[[ highlight NotifyWARNIcon guifg=#F79000]]
vim.cmd[[ highlight NotifyINFOIcon guifg=#A9FF68]]
vim.cmd[[ highlight NotifyDEBUGIcon guifg=#8B8B8B]]
vim.cmd[[ highlight NotifyTRACEIcon guifg=#D484FF]]
vim.cmd[[ highlight NotifyERRORTitle  guifg=#F70067]]
vim.cmd[[ highlight NotifyWARNTitle guifg=#F79000]]
vim.cmd[[ highlight NotifyINFOTitle guifg=#A9FF68]]
vim.cmd[[ highlight NotifyDEBUGTitle  guifg=#8B8B8B]]
vim.cmd[[ highlight NotifyTRACETitle  guifg=#D484FF]]
vim.cmd[[ highlight link NotifyERRORBody Normal]]
vim.cmd[[ highlight link NotifyWARNBody Normal]]
vim.cmd[[ highlight link NotifyINFOBody Normal]]
vim.cmd[[ highlight link NotifyDEBUGBody Normal]]
vim.cmd[[ highlight link NotifyTRACEBody Normal]]
