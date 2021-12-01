
local M = {}
--coq = require("coq")
local util = require("lspconfig/util")

M.setup = function(attach, capabilities)
  require('lspconfig').pyright.setup {
    capabilities = capabilities,
    on_attach = attach,
    root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      python =  {
        analysis = {
          stubPath = "./typings",
          --autoSearchPaths = false,
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        }
      }
    }
  }
end

return M
