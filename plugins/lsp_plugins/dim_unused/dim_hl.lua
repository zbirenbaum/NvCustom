local highlighter = require("vim.treesitter.highlighter")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_treesitter_hl = function(row, col)
  local buf = vim.api.nvim_get_current_buf()
  local self = highlighter.active[buf]
  if not self then
    return {}
  end
  local matches = {}
  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end
    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()
    if root_start_row > row or root_end_row < row then
      return
    end
    local query = self:get_query(tree:lang())
    if not query:query() then
      return
    end
    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)
    for capture, node, _ in iter do
      local hl = query.hl_cache[capture]
      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          local general_hl = query:_get_hl_from_capture(capture)
          table.insert(matches, general_hl)
        end
      end
    end
  end, true)
  return matches
end

local hex_to_rgb = function (hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)
  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))
  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

local blend = function(fg, bg, alpha)
  bg = hex_to_rgb(bg)
  fg = hex_to_rgb(fg)
  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local darken = function(hex, amount, bg)
  return blend(hex, bg or "#000000", math.abs(amount))
end

local highlight_word = function(ns, line, from, to)
  local ts_hi = get_treesitter_hl(line, from)
  local final = #ts_hi >= 1 and ts_hi[#ts_hi]
  if type(final) ~= "string" then
    final = "Normal"
  end
  local hl = vim.api.nvim_get_hl_by_name(final, true)
  local color = string.format("#%x", hl["foreground"] or 0)
  if #color ~= 7 then
    color = "#ffffff"
  end
  vim.api.nvim_set_hl(
    ns,
    string.format("%sDimmed", final),
    { fg = darken(color, 0.75), undercurl = false, underline = false }
  )
  vim.api.nvim_buf_add_highlight(0, ns, string.format("%sDimmed", final), line, from, to)
end


return highlight_word