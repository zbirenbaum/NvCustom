--vim.defer_fn(function() require("custom.plugins.lsp_plugins.lsp_handlers").setup() end, 0)
require("custom.plugins.lsp_plugins.lsp_handlers").setup()
local function on_attach(_, bufnr)
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end
   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

   require("core.mappings").lspconfig()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 }}
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

local setup_lsp = function(attach)
   local lspconfig = require "lspconfig"
   local default_servers = {"clangd"}
   local custom_servers = {"pylance", "sumneko_lua"}

   for _, lsp in ipairs(custom_servers) do
      require("custom.plugins.lsp_plugins.lsp_configs.cmp." .. lsp).setup(attach, capabilities)
   end

   for _, lsp in ipairs(default_servers) do
      lspconfig[lsp].setup{
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         }
      }
   end
end

setup_lsp(on_attach)