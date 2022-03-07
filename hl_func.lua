local set_hl = function (group, hl_tbl)
   vim.api.nvim_set_hl(0, group, hl_tbl)
end

local fg = function(group, fg_hl)
   local hl_tbl = {fg=fg_hl}
   set_hl(group, hl_tbl)
end

local bg = function(group, bg_hl)
   local hl_tbl={bg=bg_hl}
   set_hl(group, hl_tbl)
end

local fg_bg = function(group, fg_hl, bg_hl)
   local hl_tbl = {fg=fg_hl, bg=bg_hl}
   set_hl(group, hl_tbl)
end

local get = function(individuals)
   if individuals ~= nil then
      return set_hl, fg, bg, fg_bg
   end
   local M = {
      set_hl = set_hl,
      fg = fg,
      bg = bg,
      fg_bg = fg_bg,
   }
   return M
end

return get

