local cmd = vim.cmd
local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end
-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
   cmd("hi " .. group .. " guifg=" .. color)
end

vim.cmd[[au BufEnter * hi TabLineFill "#000000"]]
--require('luatab').setup{}
--require('luatab').setup{}
