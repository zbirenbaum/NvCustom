local M = {}
local util = require("lspconfig/util")
local coq = require('coq')
M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  -- lspservers with default config
--"ccls"
  local servers = { "lua", "pyright", "clangd" }
  --  vim.cmd('COQnow --shut-up')
  for _, lsp in ipairs(servers) do
    if lsp ~= "lua" then
      if lsp == "pyright" then
        require('lspconfig').pyright.setup(coq.lsp_ensure_capabilities({
          capabilities = capabilities,
          on_attach = attach,
          root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
          settings = {
            python =  {
              analysis = {
                --              autoSearchPaths = false,
                --              useLibraryCodeForTypes = false,
                diagnosticMode = 'openFilesOnly',
              }
            }
          }
        }))
      else
        lspconfig[lsp].setup(coq.lsp_ensure_capabilities({}))
      end
      -- lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
        --    on_attach = attach,
        -- }))
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
