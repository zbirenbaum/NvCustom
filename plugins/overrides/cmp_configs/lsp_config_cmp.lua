local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  -- "ccls", 
--  local servers = { "pyright", "lua", "clangd" }
  local servers = { "pylance", "lua", "clangd" }

  for _, lsp in ipairs(servers) do
		
      if lsp == "pyright" then
        require("custom.plugins.lsp_configs." .. lsp .. "_cmp").setup(attach,capabilities)
			elseif lsp == "pylance" then
        require("custom.plugins.lsp_configs." .. lsp)
      elseif lsp == "lua" then
        require("custom.plugins.lsp_configs.sumneko_cmp")
--        require("custom.plugins.lsp_configs.alternate_luastart")
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
