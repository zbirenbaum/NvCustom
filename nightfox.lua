local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg

local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "duskfox", -- change the colorscheme to use nordfox
  transparent = true,
  styles = {
    comments = "italic", -- change style of comments to be italic
    keywords = "bold", -- change style of keywords to be bold
    functions = "bold" -- styles can be a comma separated list
  },
  inverse = {
    match_paren = true, -- inverse the highlighting of match_parens
  },
  colors = {
    red = "#FF000", -- Override the red color for MAX POWER
    bg_alt = "#000000",
  },
  hlgroups = {
    TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
    LspCodeLens = { bg = "#000000", style = "italic" },
  }
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()

-- Git signs
fg_bg("DiffAdd", "#61afef", "NONE")
fg_bg("DiffChange", "#6f737b", "NONE")
fg_bg("DiffChangeDelete", "#ff75a0", "NONE")
fg_bg("DiffModified", "#ff75a0", "NONE")
fg_bg("DiffDelete", "#ff75a0", "NONE")

-- Indent blankgrey8 plugin
fg("IndentBlankLineChar", "#2a2e36")
