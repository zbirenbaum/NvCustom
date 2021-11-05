
local M = {}
--coq = require("coq")
local util = require("lspconfig/util")
local coq = require("coq")

M.setup = function(attach, capabilities)
  require('lspconfig').pyright.setup(coq.lsp_ensure_capabilities( {
    capabilities = capabilities,
    on_attach = attach,
    root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      python =  {
        analysis = {
          autoSearchPaths = false,
          useLibraryCodeForTypes = false,
          diagnosticMode = 'openFilesOnly',
        }
      }
    }
  }))
end

return M.setup()
