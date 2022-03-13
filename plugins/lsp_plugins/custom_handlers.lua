-- It's good practice to namespace custom handlers to avoid collisions
local function ignore_vtext(diagnostic)
   if diagnostic.severity == vim.diagnostic.severity.HINT and string.match(string.lower(diagnostic.message), "never read") or string.match(string.lower(diagnostic.message), "unused") then
      return nil
   else
      return diagnostic.message
   end
end

vim.diagnostic.handlers["dim/unused"] = {
   show = function(namespace, bufnr, diagnostics, opts)
      local highlight_word=require("custom.plugins.lsp_plugins.dim_unused.dim_hl")
      local ns = vim.api.nvim_create_namespace(vim.diagnostic.get_namespace(namespace).name)
      vim.api.nvim__set_hl_ns(ns)
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      for _, diagnostic in ipairs(diagnostics) do
         if diagnostic.severity == vim.diagnostic.severity.HINT and
            string.match(string.lower(diagnostic.message), "never read") or
            string.match(string.lower(diagnostic.message), "unused") then
            highlight_word(ns, diagnostic.lnum, diagnostic.col, diagnostic.end_col)
         end
      end
   end,
}

-- Users can configure the handler
vim.diagnostic.config({
   ["dim/unused"] = {
      log_level = vim.log.levels.HINT,
   },
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
