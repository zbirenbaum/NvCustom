local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = { "pyright", "lua", "ccls" }

  for _, lsp in ipairs(servers) do
      if lsp == "pyright" then
        require("custom.plugins.lsp_configs." .. lsp .. "_cmp").setup(attach,capabilities)
      elseif lsp == "lua" then
        require("custom.plugins.lsp_configs.sumneko_cmp")
      elseif lsp == "ccls" then
        require("custom.plugins.lsp_configs.ccls_cmp")
      else
        lspconfig[lsp].setup{
          on_attach = attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          }
        }
      end
  end
end

return M
