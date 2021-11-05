local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  command="ccls --index=. -log-file=/tmp/ccls.log -v=1",
  init_options = {
    compilationDatabaseDirectory = "build";
    cache = {
      directory = ".ccls-cache";
    };
    index = {
      threads = 2;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

