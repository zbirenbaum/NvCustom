local lspconfig = require'lspconfig'
local util = require("lspconfig/util")
lspconfig.ccls.setup {
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

--
-- local root_dir = util.root_pattern(".git", ".ccls");
--
-- lspconfig.ccls.setup {
   --   command="ccls --index=" .. root_dir .. " -log-file=/tmp/ccls.log -v=1",
   --   init_options = {
      --     compilationDatabaseDirectory = "build";
      --     cache = {
         --       directory = ".ccls-cache";
         --     };
         --     index = {
            --       threads = 2;
            --     };
            --     clang = {
               --       excludeArgs = { "-frounding-math"} ;
               --     };
               --   }
               --


