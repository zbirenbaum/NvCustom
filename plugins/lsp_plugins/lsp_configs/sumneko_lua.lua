local M = {}

M.config_table = function(attach, capabilities)
  --local sumneko_root_path = vim.fn.getenv "HOME" .. "/sumneko_lua"
  local sumneko_root_path = "/usr/share/lua-language-server" --/usr/share/lua-language-server"
  local sumneko_binary = "/usr/bin/lua-language-server"
  -- local sumneko_binary = "/bin/lua-language-server"
  -- Make runtime files discoverable to the server
  local runtime_path = vim.split(package.path, ";", {})
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  return {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = attach,
    capabilities = capabilities,
    completion = { callSnippet = "Both" },
    flags = {
      debounce_text_changes = 300,
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
          --          library=vim.api.nvim_get_runtime_file("", true),
          library = {
            [vim.fn.expand("~/.config/nvim")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.expand("$HOME/.config/nvim/lua")] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
