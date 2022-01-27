local M = {}

M.setup_capabilities = function()
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   local completionItem = capabilities.textDocument.completion.completionItem
   completionItem.documentationFormat = { "markdown", "plaintext" }
   completionItem.snippetSupport = true
   completionItem.preselectSupport = true
   completionItem.insertReplaceSupport = true
   completionItem.labelDetailsSupport = true
   completionItem.deprecatedSupport = true completionItem.commitCharactersSupport = true
   completionItem.tagSupport = { valueSet = { 1 } }
   completionItem.resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   }
   require("tbl_print")(capabilities, "lazyload.txt")
end

M.config_handlers = function()

   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single",})
   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single",})
   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = { prefix = "",},
      signs = true,
      underline = true,
      update_in_insert = false, -- update diagnostics insert mode
   })

end

M.config_diagnostics = function ()
   vim.diagnostic.config {
      virtual_text = {
         prefix = "",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
   }
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
--local capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
