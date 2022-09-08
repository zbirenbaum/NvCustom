local M = {}

M.apply_colors_highlight = function()
  local cmd = vim.cmd

  local override = require("core.utils").load_config().ui.hl_override -- local colors = require("custom.colors").get()
  local colors = require("custom.colors.scheme")

  local black = colors.black
  local black2 = colors.black2
  local blue = colors.blue
  local darker_black = colors.darker_black
  local folder_bg = colors.folder_bg
  local green = colors.green
  local grey = colors.grey
  local grey_fg = colors.grey_fg
  local light_grey = colors.light_grey
  local line = colors.line
  local nord_blue = colors.nord_blue
  local one_bg = colors.one_bg
  local one_bg2 = colors.one_bg2
  local pmenu_bg = colors.pmenu_bg
  local purple = colors.purple
  local red = colors.red
  local white = colors.white
  local yellow = colors.yellow
  local orange = colors.orange
  local sun = colors.sun
  local dark_purple = colors.dark_purple
  local one_bg3 = colors.one_bg3

  -- functions for setting highlights
  local fg = function(group, color, sp)
    local hl = { fg = color }
    if sp ~= nil then
      if type(sp) == "string" then hl[sp] = true
      else for _, v in ipairs(sp) do hl[v] = true end
      end
    end
    vim.api.nvim_set_hl(0, group, hl)
  end

  local bg = function(group, color, sp)
    local hl = { bg = color }
    if sp ~= nil then
      hl[sp] = true
    end
    vim.api.nvim_set_hl(0, group, hl)
  end

  local fg_bg = function(group, fg_color, bg_color, sp)
    local hl = { fg = fg_color, bg = bg_color }
    if sp ~= nil then
      hl[sp] = true
    end
    vim.api.nvim_set_hl(0, group, hl)
  end

  vim.api.nvim_set_hl(0, "TSVariable", { fg = colors.white })
  fg("TSContant", orange, "bold")
  fg("TSParameter", orange, {"italic", "bold"})
  fg("TSRepeat", sun, {"bold"})
  fg("TSKeyword", dark_purple)
  -- fg("TSKeywordFunction", blue, "bold")
  -- fg("TSConditional", purple, "bold")

  -- Comments
  vim.api.nvim_set_hl(0, "TSComment", { fg = grey_fg, italic = true, bold = true })
  vim.api.nvim_set_hl(0, "Comment", { fg = grey_fg, italic = true, bold = true })

  -- Disable cursor line
  -- cmd("hi clear CursorLine")
  -- Line number
  bg("CursorLine", black )
  -- fg("cursorlinenr", white)
  vim.api.nvim_set_hl(0, "CursorLineNR", {fg=dark_purple, italic=false, bold=true})

  -- same it bg, so it doesn't appear
  fg("EndOfBuffer", black)

  -- For floating windows
  fg("FloatBorder", grey) --changed bc bright blue hurts my eyes after a while
  bg("NormalFloat", darker_black)

  -- Pmenu
  bg("Pmenu", one_bg)
  bg("PmenuSbar", one_bg2)
  bg("PmenuSel", pmenu_bg)
  bg("PmenuThumb", nord_blue)
  fg("CmpItemAbbr", white)
  fg("CmpItemAbbrMatch", white)
  fg("CmpItemKind", white)
  fg("CmpItemMenu", white)

  -- misc

  -- inactive statuslines as thin lines
  fg("StatusLineNC", one_bg3, "underline")

  fg("LineNr", grey)
  fg("NvimInternalError", red)
  fg("VertSplit", one_bg2)

  bg("Folded", "NONE")
  fg("Folded", "NONE")
  fg("Comment", grey)
  fg_bg("Normal", white, "NONE") --due to api replacing undefineds, needs to be set

  -- [[ Plugin Highlights

  -- Dashboard
  fg("AlphaHeader", grey_fg)
  fg("AlphaButtons", light_grey)

  -- Git signs
  fg_bg("DiffAdd", blue, "NONE")
  fg_bg("DiffChange", grey_fg, "NONE")
  fg_bg("DiffChangeDelete", red, "NONE")
  fg_bg("DiffModified", red, "NONE")
  fg_bg("DiffDelete", red, "NONE")
  fg_bg("SignColumn", 'NONE', 'NONE')

  -- Indent blankline plugin
  fg("IndentBlanklineChar", line)
  fg("IndentBlanklineSpaceChar", line)

  -- Lsp diagnostics

  fg("DiagnosticHint", purple)
  fg("DiagnosticError", red)
  fg("DiagnosticWarn", yellow)
  fg("DiagnosticInformation", green)

  -- Telescope
  fg_bg("TelescopeBorder", darker_black, darker_black)
  fg_bg("TelescopePromptBorder", black2, black2)

  fg_bg("TelescopePromptNormal", white, black2)
  fg_bg("TelescopePromptPrefix", red, black2)

  bg("TelescopeNormal", darker_black)

  fg_bg("TelescopePreviewTitle", black, green)
  fg_bg("TelescopePromptTitle", black, red)
  fg_bg("TelescopeResultsTitle", darker_black, darker_black)

  bg("TelescopeSelection", black2)

  -- Disable some highlight in nvim tree if transparency enabled
  bg("NormalFloat", "NONE")
  -- telescope
  bg("TelescopeBorder", "NONE")
  bg("TelescopePrompt", "NONE")
  bg("TelescopeResults", "NONE")
  bg("TelescopePromptBorder", "NONE")
  bg("TelescopePromptNormal", "NONE")
  bg("TelescopeNormal", "NONE")
  bg("TelescopePromptPrefix", "NONE")
  fg("TelescopeBorder", one_bg)
  fg_bg("TelescopeResultsTitle", black, blue)

  if #override ~= 0 then
    require(override)
  end
end
M.apply_colors_highlight()

return M

  -- -- NvimTree
  -- fg("NvimTreeEmptyFolderName", folder_bg)
  -- fg("NvimTreeEndOfBuffer", darker_black)
  -- fg("NvimTreeFolderIcon", folder_bg)
  -- fg("NvimTreeFolderName", folder_bg)
  -- fg("NvimTreeGitDirty", red)
  -- fg("NvimTreeIndentMarker", one_bg2)
  -- bg("NvimTreeNormal", darker_black)
  -- bg("NvimTreeNormalNC", darker_black)
  -- fg("NvimTreeOpenedFolderName", folder_bg)
  -- fg("NvimTreeRootFolder", red, "underline") -- enable underline for root folder in nvim tree
  -- fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
  -- fg_bg("NvimTreeVertSplit", darker_black, darker_black)
  -- fg_bg("NvimTreeWindowPicker", red, black2)

  -- transparency
  -- bg("NvimTreeNormal", "NONE")
  -- bg("NvimTreeNormalNC", "NONE")
  -- bg("NvimTreeStatusLineNC", "NONE")
  -- fg_bg("NvimTreeVertSplit", grey, "NONE")
