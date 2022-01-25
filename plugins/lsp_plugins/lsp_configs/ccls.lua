local util = require("lspconfig/util")
local M = {}

M.config_table = {
   root_dir = util.root_pattern(".ccls", ".ccls-cache", "compile-command.json", ".git/", ".hg/", ".clang_complete"),
   init_options = {
      compilationDatabaseDirectory = "build",
      index = {
         threads = 0
      },
      clang = {
         excludeArgs = {"-frounding-math"}
      }
   }
}
return M
