local M = {}
local coq = require("coq")

M.setup_luaLsp = function(attach, capabilities)
   --local sumneko_root_path = vim.fn.getenv "HOME" .. "/sumneko_lua"
   local sumneko_root_path = "/usr/share/lua-language-server"
   --local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
   local sumneko_binary = "/bin/lua-language-server"

   -- Make runtime files discoverable to the server
   local runtime_path = vim.split(package.path, ";")
   table.insert(runtime_path, "lua/?.lua")
   table.insert(runtime_path, "lua/?/init.lua")

   require("lspconfig").sumneko_lua.setup(coq.lsp_ensure_capabilities({
      cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
      on_attach = attach,
      capabilities = capabilities,
      flags = {
         debounce_text_changes = 500,
      },
      settings = {
         Lua = {
            diagnostics = {
               globals = { "vim" },
            },
            runtime = {
               version = "LuaJIT",
               path = runtime_path,
            },
            workspace = {
               library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
               },
               maxPreload = 100000,
               preloadFileSize = 10000,
            },
            telemetry = {
               enable = false,
            },
         },
      },
   }))
end

return M.setup_luaLsp()
