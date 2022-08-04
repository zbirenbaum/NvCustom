local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
  theme = theme or "onedark"
  require("custom.colors.setup_colors")
  local primary = require("custom.colors.primary")(theme)
  for k, v in pairs(primary) do
    vim.api.nvim_set_hl(0, k, v)
  end
  -- if not theme then
  --   theme = require("core.utils").load_config().ui.theme
  -- end
  --
  -- vim.g.nvchad_theme = theme
  -- local present, base16 = pcall(require, "base16")
  -- if present then
  --   -- first load the base16 theme
  --   base16(base16.themes(theme), true)
  --   -- unload to force reload
  --   package.loaded["custom.colors.highlights" or false] = nil
  --   -- then load the highlights
  --   require("custom.colors.highlights").apply_colors_highlight()
  --   -- require("custom.colors.highlights").override_ts_hl()
  -- end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
  if not theme then
    theme = vim.g.nvchad_theme or "onedark"
  end

  return require("hl_themes." .. theme)
end

M.get_base_16 = function(theme)
  if not theme then
    theme = vim.g.nvchad_theme
  end

  return require("themes." .. theme .. '-base16')
end

return M
