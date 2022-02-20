local cmd=vim.cmd
-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
   cmd("hi " .. group .. " guifg=" .. color)
end


bg("TabLineFill", "NONE")
bg("TabLine", "#000000")

vim.cmd [[highlight! Pmenu guibg=#10171f]]
vim.cmd [[highlight! PmenuSel guibg=NONE guifg=NONE gui=underline guisp=#569CD6]]
