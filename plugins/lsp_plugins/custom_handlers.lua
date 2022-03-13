-- It's good practice to namespace custom handlers to avoid collisions
local function check_unused (diagnostic)
   if diagnostic.severity == vim.diagnostic.severity.HINT and
      string.match(string.lower(diagnostic.message), "never read") or
      string.match(string.lower(diagnostic.message), "unused") then
      return true
   end
   return false
end
local function ignore_vtext(diagnostic)
   if check_unused(diagnostic) then return nil end
   return diagnostic.message
end

vim.diagnostic.handlers["dim/unused"] = {
   show = function(namespace, bufnr, diagnostics, _)
      local highlight_word=require("custom.plugins.lsp_plugins.dim_unused.dim_hl")
      local ns = vim.api.nvim_create_namespace("dim")
      vim.api.nvim__set_hl_ns(ns)
      for _, diagnostic in ipairs(diagnostics) do
         if check_unused(diagnostic) then
            highlight_word(ns, diagnostic.lnum, diagnostic.col, diagnostic.end_col)
         end
      end
   end,
   hide = function (namespace, bufnr, diagnostics, _)
      local ns = vim.api.nvim_create_namespace("dim")
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
   end
}
-- Users can configure the handler
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
