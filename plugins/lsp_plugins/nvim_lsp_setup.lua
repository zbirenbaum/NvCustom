local M = {}

M.setup_capabilities = function()
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   capabilities.textDocument.completion.completionItem.preselectSupport = true
   capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
   capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
   capabilities.textDocument.completion.completionItem.deprecatedSupport = true
   capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
   capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
   capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   }
   return capabilities
end

M.config_handlers = function()
   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single",})
   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single",})
   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
end

M.config_diagnostics = function ()
   require("custom.plugins.lsp_plugins.custom_handlers") --config_diagnostics
   local function lspSymbol(name, icon)
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
   end
   lspSymbol("Error", "")
   lspSymbol("Info", "")
   lspSymbol("Hint", "")
   lspSymbol("Warn", "")
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

M.attach = function ()
   local function attach(_, bufnr)
      local function buf_set_option(...)
         vim.api.nvim_buf_set_option(bufnr, ...)
      end
      -- Enable completion triggered by <c-x><c-o>
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

      require("core.mappings").lspconfig()
   end
   return attach
end

return M
