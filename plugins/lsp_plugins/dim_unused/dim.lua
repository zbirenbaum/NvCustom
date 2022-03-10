local dim = {}
local highlight_word=require("custom.plugins.lsp_plugins.dim_unused.dim_hl")
dim.applied = {}

-- FUNCTIONS END
--- Highlight unused vars and functions
local function applied_get_buf()
   dim.applied[vim.api.nvim_buf_get_name(0)] = dim.applied[vim.api.nvim_buf_get_name(0)] or {}
   return dim.applied[vim.api.nvim_buf_get_name(0)]
end
dim.hig_unused = function()
   local applied = applied_get_buf()
   local lsp_data = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
   for _, datum in ipairs(applied) do
      if not vim.tbl_contains(lsp_data, datum) then
         vim.api.nvim_buf_clear_namespace(0, dim.ns, datum.lnum, datum.lnum+1)
      end
   end
   for _, lsp_datum in ipairs(lsp_data) do
      if string.match(string.lower(lsp_datum.user_data.lsp.code), "never read") or string.match(string.lower(lsp_datum.user_data.lsp.code), "unused") then
         if not vim.tbl_contains(applied, lsp_datum) then
            table.insert(applied, lsp_datum)
            highlight_word(dim, dim.ns, lsp_datum.lnum, lsp_datum.col, lsp_datum.end_col)
         end
      end
   end
end

dim.opts = { disable_lsp_decorations = false, change_in_insert = false }

--- Setup Function
--- @param tbl table config options
dim.setup = function(tbl)
   dim.opts = vim.tbl_deep_extend("force", dim.opts, tbl or {})
   dim.ns = vim.api.nvim_create_namespace("Dim")
   dim.hig_unused()
   vim.api.nvim_create_augroup("dim",{clear=true})
   vim.api.nvim_create_autocmd({"DiagnosticChanged"}, {
      callback = function()
         require("custom.plugins.lsp_plugins.dim_unused.dim").hig_unused()
      end,
   })
   vim.api.nvim__set_hl_ns(dim.ns)
end

return dim
