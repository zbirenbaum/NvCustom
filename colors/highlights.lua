local cmd = vim.cmd

--local override = require("core.utils").load_config().ui.hl_override
local colors = require("custom.colors.scheme")
local ui = require("core.utils").load_config().ui

local grey13 = colors.grey13
local grey11 = colors.grey11
local grey14 = colors.grey14
local sky = colors.sky
local grey4 = colors.grey4
local grey2 = colors.grey2
local grey8 = colors.grey8
local pale_blue_grey = colors.pale_blue_grey
local grey9 = colors.grey9
local grey5 = colors.grey5
local green = colors.green
local purple = colors.purple
local pink = colors.pink
local ghostwhite = colors.ghostwhite
local yellow = colors.yellow
local orange = colors.orange
local grey6 = colors.grey6

-- functions for setting highlights
local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg

-- Comments
if ui.italic_comments then
   fg("Comment", grey2 .. " gui=italic")
else
   fg("Comment", grey2)
end

-- Disable cursor grey8
cmd "hi clear CursorLine"
-- grey8 number
fg("cursorlinenr", ghostwhite)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", grey13)

-- For floating windows
fg("FloatBorder", sky)
bg("NormalFloat", grey14)

-- Pmenu
bg("Pmenu", grey9)
bg("PmenuSbar", grey5)
bg("PmenuSel", green)
bg("PmenuThumb", pale_blue_grey)
fg("CmpItemAbbr", ghostwhite)
fg("CmpItemAbbrMatch", ghostwhite)
fg("CmpItemKind", ghostwhite)
fg("CmpItemMenu", ghostwhite)

-- misc

-- inactive statusgrey8s as thin grey8s
fg("StatusLineNC", grey6 .. " gui=underline")

fg("LineNr", grey4)
fg("NvimInternalError", pink)
fg("VertSplit", grey5)

if ui.transparency then
   bg("Normal", "NONE")
   bg("Folded", "NONE")
   fg("Folded", "NONE")
   fg("Comment", grey4)
end

-- [[ Plugin Highlights

-- Dashboard
fg("DashboardCenter", grey2)
fg("DashboardFooter", grey2)
fg("DashboardHeader", grey2)
fg("DashboardShortcut", grey2)


-- Lsp diagnostics

fg("DiagnosticHint", purple)
fg("DiagnosticError", pink)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInformation", green)

-- NvimTree
fg("NvimTreeEmptyFolderName", sky)
fg("NvimTreeEndOfBuffer", grey14)
fg("NvimTreeFolderIcon", sky)
fg("NvimTreeFolderName", sky)
fg("NvimTreeGitDirty", pink)
fg("NvimTreeIndentMarker", grey5)
bg("NvimTreeNormal", grey14)
bg("NvimTreeNormalNC", grey14)
fg("NvimTreeOpenedFolderName", sky)
fg("NvimTreeRootFolder", pink .. " gui=underline") -- enable undergrey8 for root folder in nvim tree
fg_bg("NvimTreeStatusLineNc", grey14, grey14)
fg("NvimTreeVertSplit", grey14)
bg("NvimTreeVertSplit", grey14)
fg_bg("NvimTreeWindowPicker", pink, grey11)

-- Telescope
fg_bg("TelescopeBorder", grey14, grey14)
fg_bg("TelescopePromptBorder", grey11, grey11)

fg_bg("TelescopePromptNormal", ghostwhite, grey11)
fg_bg("TelescopePromptPrefix", pink, grey11)

bg("TelescopeNormal", grey14)

fg_bg("TelescopePreviewTitle", grey13, green)
fg_bg("TelescopePromptTitle", grey13, pink)
fg_bg("TelescopeResultsTitle", grey14, grey14)

bg("TelescopeSelection", grey11)

-- keybinds cheatsheet

fg_bg("CheatsheetBorder", grey13, grey13)
bg("CheatsheetSectionContent", grey13)
fg("CheatsheetHeading", ghostwhite)

local section_title_colors = {
   ghostwhite,
   sky,
   pink,
   green,
   yellow,
   purple,
   orange,
}
for i, color in ipairs(section_title_colors) do
   vim.cmd("highlight CheatsheetTitle" .. i .. " guibg = " .. color .. " guifg=" .. grey13)
end

-- Disable some highlight in nvim tree if transparency enabled
if ui.transparency then
   bg("NormalFloat", "NONE")
   bg("NvimTreeNormal", "NONE")
   bg("NvimTreeNormalNC", "NONE")
   bg("NvimTreeStatusLineNC", "NONE")
   bg("NvimTreeVertSplit", "NONE")
   fg("NvimTreeVertSplit", grey4)

   -- telescope
   bg("TelescopeBorder", "NONE")
   bg("TelescopePrompt", "NONE")
   bg("TelescopeResults", "NONE")
   bg("TelescopePromptBorder", "NONE")
   bg("TelescopePromptNormal", "NONE")
   bg("TelescopeNormal", "NONE")
   bg("TelescopePromptPrefix", "NONE")
   fg("TelescopeBorder", grey9)
   fg_bg("TelescopeResultsTitle", grey13, sky)
end
