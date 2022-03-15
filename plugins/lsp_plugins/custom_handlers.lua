local dim = require("custom.plugins.lsp_plugins.dim_unused.dim_hl")
local results = {}
setmetatable(results, {__mode = "v"})  -- make values weak

local darkened = function (color)
   if not results[color] then results[color] = dim.darken(color, 0.75) end
   return results[color]
end

local highlight_word = function(bufnr, ns, line, from, to)
   local ts_hi = dim.get_treesitter_hl(line, from)
   local final = #ts_hi >= 1 and ts_hi[#ts_hi]
   if type(final) ~= "string" then
      final = "Normal"
   end
   local hl = vim.api.nvim_get_hl_by_name(final, true)
   local color = string.format("#%x", hl["foreground"] or 0)
   if #color ~= 7 then
      color = "#ffffff"
   end
   vim.api.nvim_set_hl(ns, string.format("%sDimmed", final), {
      fg = darkened(color),
      undercurl = false,
      underline = false,
   })
   vim.api.nvim_buf_add_highlight(bufnr, ns, string.format("%sDimmed", final), line, from, to)
end

local function check_unused (diagnostic)
   if diagnostic.severity ~= vim.diagnostic.severity.HINT then return end
   local d_msg = string.lower(diagnostic.message)
   local match_msgs = {"unused", "never read", "not accessed"}
   for _, msg in ipairs(match_msgs) do
      if string.match(d_msg, msg) then
         return true
      end
   end
   return false
end

local function ignore_vtext(diagnostic)
   if check_unused(diagnostic) then return nil end
   return diagnostic.message
end

vim.diagnostic.handlers["dim/unused"] = {
   show = function(_, bufnr, diagnostics, _)
      local ns = vim.api.nvim_create_namespace("dim")
      vim.api.nvim__set_hl_ns(ns)
      for _, diagnostic in ipairs(diagnostics) do
         if check_unused(diagnostic) then
            highlight_word(bufnr, ns, diagnostic.lnum, diagnostic.col, diagnostic.end_col)
         end
      end
   end,
   hide = function (_, bufnr, _, _)
      local ns = vim.api.nvim_create_namespace("dim")
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
   end
}

vim.diagnostic.config({
   ["dim/unused"] = {},
   virtual_text = {
      prefix = "",
      format = function(diagnostic)
         return ignore_vtext(diagnostic)
      end,
   },
   signs = true,
   underline = false,
   update_in_insert = false, -- update diagnostics insert mode
})
