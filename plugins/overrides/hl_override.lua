local cmd = vim.cmd
local colors = require("custom.colors").get()


local violet = "#a038ba"
local magenta = "#E753B3"
local paleteal = "#D1BCEE"
local dark_magenta = "#F490AF"
local forest_green = "#099E31"
local rust = "#D47D19"
-- local teal = "#54d7cb"
-- local darkorange = "#c16c17"
-- teal = "#16b0b6"
-- vim.api.nvim_set_hl(0, "TSVariable", {fg=teal})

-- local violet = "#a038ba"
-- local teal = "#54d7cb"
vim.api.nvim_set_hl(0, "TSVariable", {fg=paleteal})
-- vim.api.nvim_set_hl(0, "TSField", {fg=orange})
-- vim.api.nvim_set_hl(0, "TSKeyWord", {fg=violet})
vim.api.nvim_set_hl(0, "TSKeyWordFunction", {fg=dark_magenta})
--vim.api.nvim_set_hl(0, "TSField", {fg=magenta})
vim.api.nvim_set_hl(0, "TSField", {fg=rust})
vim.api.nvim_set_hl(0, "TSParameter", {fg=dark_magenta})
-- vim.api.nvim_set_hl(0, "TSKeyWord", {fg="#fba8c9"})
-- vim.api.nvim_set_hl(0, "TSRepeat", {fg="#fba8c9"})

local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end
bg("TabLineFill", "NONE")
bg("TabLine", "#000000")
vim.cmd [[highlight! Pmenu guibg=#10171f]]
vim.cmd [[highlight! PmenuSel guibg=NONE guifg=NONE gui=underline guisp=#569CD6]]
