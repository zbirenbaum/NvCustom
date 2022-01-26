M = {}

M.setup = function()
   local function lspSymbol(name, icon)
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
   end

   lspSymbol("Error", "")
   lspSymbol("Info", "")
   lspSymbol("Hint", "")
   lspSymbol("Warn", "")
  -- vim.o.updatetime = 250
 --  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
   require("custom.plugins.lsp_plugins.diagnostic_config")
--    vim.diagnostic.config {
--       virtual_text = false,
--       -- virtual_text = {
--       --     prefix = "",
--       -- },
-- --      virtualTextCurrentLineOnly=true,
--       signs = true,
--       underline = true,
--       update_in_insert = true,
--    }
   --vim.lsp.handlers["textDocument/publishDiagnostics"]
   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      vim.diagnostic.open_float(nil, {focus=false})
   })
   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "single",
   })

   -- suppress error messages from lang servers
   vim.notify = function(msg, log_level)
      if msg:match "exit code" then
         return
      end
      if log_level == vim.log.levels.ERROR then
         vim.api.nvim_err_writeln(msg)
      else
         vim.api.nvim_echo({ { msg } }, true, {})
      end
   end
end

return M
