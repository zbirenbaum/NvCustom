local cmd = vim.cmd
local colors = require("custom.new_colors")
local set_hl, fg, bg, fg_bg = require("custom.hl_func")(true)

-- fg("TSKeyWord", colors.purples[5])
-- fg("TSVariable", colors.pinks[2])

-- fg("TSFuncBuiltin", colors.blues[1])
-- fg("TSFunction", colors.blues[1])
-- fg("TSKeywordFunction", colors.blues[1])

local bg = function (group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end

bg("TabLineFill", "NONE")
bg("TabLine", "#000000")
vim.cmd [[highlight! Pmenu guibg=#10171f]]
vim.cmd [[highlight! PmenuSel guibg=NONE guifg=NONE gui=underline guisp=#569CD6]]






fg("TSFunction", "#C586C0")
fg("TSFuncBuiltin", "#C586C0")
fg("TSClass", "Orange")

--#f90c71
fg("TSKeyword", "#FF5677")
fg("TSFunctionKeyword", "#FF5677")

fg("TSConstructor", "#ae43f0")
fg("TSMethod", "#C586C0")
-- fg_bg("TSVariable", "#9CDCFE", "NONE")
fg_bg("TSVariable", colors.blue_greys[4], "NONE")
fg_bg("TSInterface", "#FF5677", "NONE")
fg("TSField", colors.reds[2])
fg("TSParameter", colors.blue_greys[4])
