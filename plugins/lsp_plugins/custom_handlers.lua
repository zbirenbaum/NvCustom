vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = {
    filter = function (diagnostic)
      if not diagnostic.user_data then diagnostic.user_data = {} end
      return diagnostic
    end,
  },
  underline = false,
  update_in_insert = false, -- update diagnostics insert mode
})
  --     if diagnostic.severity ~= vim.diagnostic.severity.ERROR then
  --         diagnostic.user_data.sign_text = "D"
  --         diagnostic.user_data.sign_hl_group = 'DiagnosticSignWarn'
  --         return diagnostic
  --     end
  -- },
  -- sign_text = { [vim.diagnostic.severity.ERROR] = "B", },
-- --
-- local max_severity = function (line_diagnostics)
--   local severity = 4
--   local max_severity_diagnostic
--   for _, d in ipairs(line_diagnostics) do
--     if d.severity < severity then
--       severity = d.severity
--       max_severity_diagnostic = d
--     end
--   end
--   return max_severity_diagnostic
-- end
--
-- local old_handler = vim.tbl_extend("force", {}, vim.diagnostic.handlers["signs"])
--
-- vim.diagnostic.handlers["signs"].show = function (ns, bufnr, diagnostics, opts)
--   local dlines = {}
--   for _, d in ipairs(diagnostics) do
--     dlines[d.lnum] = dlines[d.lnum] or {}
--     table.insert(dlines[d.lnum], d)
--   end
--   dlines = vim.tbl_values(vim.tbl_map(max_severity, dlines))
--   old_handler.show(ns, bufnr, dlines, opts)
-- end
