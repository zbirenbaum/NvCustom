local M = {}
local coq = require('coq')
M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  
  -- lspservers with default config

  local servers = { "lua", "pyright" }
    vim.cmd('COQnow --shut-up')
    for _, lsp in ipairs(servers) do
      if lsp ~= "lua" then
        -- lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
        --    on_attach = attach,
        -- }))
        require("custom.plugins.lsp_configs." .. lsp)
        --require("custom.plugins.lsp_configs." .. lsp)
      elseif lsp == "lua" then
        require("custom.plugins.lsp_configs.sumneko")
           --on_attach = attach,
      end
  end
end
-- end)
--    for _, lsp in ipairs(servers) do
--     if lsp ~= "lua" then
--       require("custom.plugins.lsp_configs." .. lsp)
--     elseif lsp == "lua" then
--       require("custom.plugins.lsp_configs.sumneko").setup_luaLsp()
--     end
--   end
-- end
return M
