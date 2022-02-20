local function highlight(tbl)
   for group, hl in pairs(tbl) do
      vim.api.nvim_set_hl(0, group, hl)
   end
end
local core = {
   Normal={bg=nil},
   Folded={fg=nil, bg=nil},
}
local treesitter = require("custom.highlights.treesitter")
local others = require("custom.highlights.others")
highlight(core)
highlight(treesitter)
highlight(others)
-- highlight("TSAttribute", theme.base0A, nil, "none", nil)
-- highlight("TSCharacter", theme.base08, nil, "none", nil)
-- highlight("TSConstBuiltin", theme.base09, nil, "none", nil)
-- highlight("TSConstMacro", theme.base08, nil, "none", nil)
-- highlight("TSError", theme.base08, nil, "none", nil)
-- highlight("TSException", theme.base08, nil, "none", nil)
-- highlight("TSFloat", theme.base09, nil, "none", nil)
-- highlight("TSFuncBuiltin", theme.base0D, nil, "none", nil)
-- highlight("TSFuncMacro", theme.base08, nil, "none", nil)
-- highlight("TSKeywordFunction", theme.base0E, nil, "none", nil)
-- highlight("TSKeywordOperator", theme.base0E, nil, "none", nil)
-- highlight("TSMethod", theme.base0D, nil, "none", nil)
-- highlight("TSNamespace", theme.base08, nil, "none", nil)
-- highlight("TSNone", theme.base05, nil, "none", nil)
-- highlight("TSParameter", theme.base08, nil, "none", nil)
-- highlight("TSParameterReference", theme.base05, nil, "none", nil)
-- highlight("TSPunctDelimiter", theme.base0F, nil, "none", nil)
-- highlight("TSPunctSpecial", theme.base05, nil, "none", nil)
-- highlight("TSStringRegex", theme.base0C, nil, "none", nil)
-- highlight("TSStringEscape", theme.base0C, nil, "none", nil)
-- highlight("TSSymbol", theme.base0B, nil, "none", nil)
-- highlight("TSTagDelimiter", theme.base0F, nil, "none", nil)
-- highlight("TSText", theme.base05, nil, "none", nil)
-- highlight("TSStrong", nil, nil, "bold", nil)
-- highlight("TSEmphasis", theme.base09, nil, "none", nil)
-- highlight("TSStrike", theme.base00, nil, "strikethrough", nil)
-- highlight("TSLiteral", theme.base09, nil, "none", nil)
-- highlight("TSURI", theme.base09, nil, "underline", nil)
-- highlight("TSTypeBuiltin", theme.base0A, nil, "none", nil) highlight("TSVariableBuiltin", theme.base09, nil, "none", nil)
-- highlight("TSDefinition", nil, nil, "underline", theme.base04)
-- highlight("TSDefinitionUsage", nil, nil, "underline", theme.base04)
-- highlight("TSCurrentScope", nil, nil, "bold", nil)