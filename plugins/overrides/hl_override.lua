local cmd = vim.cmd
local colors = require("custom.colors").get()


local violet = "#a038ba"
local teal = "#54d7cb"
local darkorange = "#c16c17"
teal = "#16b0b6"
vim.api.nvim_set_hl(0, "TSVariable", {fg=teal})
vim.api.nvim_set_hl(0, "TSField", {fg="#d29355"})
vim.api.nvim_set_hl(0, "TSKeyWord", {fg="#fba8c9"})
vim.api.nvim_set_hl(0, "TSRepeat", {fg="#fba8c9"})


local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end
bg("TabLineFill", "NONE")
bg("TabLine", "#000000")
vim.cmd [[highlight! Pmenu guibg=#10171f]]
vim.cmd [[highlight! PmenuSel guibg=NONE guifg=NONE gui=underline guisp=#569CD6]]
