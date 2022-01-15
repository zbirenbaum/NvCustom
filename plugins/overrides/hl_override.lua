local nightfox = require('nightfox')
local theme = nightfox

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "nightfox", -- change the colorscheme to use nordfox
	transparent = true,
  styles = {
    comments = "italic", -- change style of comments to be italic
    keywords = "bold", -- change style of keywords to be bold
    functions = "italic,bold" -- styles can be a comma separated list
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
nightfox.load('duskfox')
vim.cmd[[ colorscheme nightfox ]]

local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg

bg("TabLineFill", "NONE")
bg("TabLine", "#000000")
require("custom.plugins.overrides.theme")


-- vim.g.neon_style = "dark"
-- vim.g.neon_italic_keyword = false
-- vim.g.neon_italic_function = true
-- vim.g.neon_transparent = true
-- vim.g.neon_bold = true
--
-- vim.cmd[[colorscheme neon]]
