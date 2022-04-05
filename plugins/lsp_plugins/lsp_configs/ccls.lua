local util = require("lspconfig/util")
local M = {}

M.config_table = function(attach, capabilities)
  return {
    filetypes = { "c", "cpp", "cuda" },
    root_dir = util.root_pattern(".ccls", ".ccls-cache", "compile-command.json", ".git/", ".hg/", ".clang_complete"),
    capabilities = capabilities,
    attach = attach,
    init_options = {
      compilationDatabaseDirectory = "build",
      index = {
        threads = 0,
      },
      clang = {
        excludeArgs = { "-frounding-math" },
      },
    },
  }
end
return M
