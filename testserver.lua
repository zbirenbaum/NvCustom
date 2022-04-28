local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.getCompletions = true


local format_pos = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  return { character = pos[2], line = pos[1] - 1 }
end

local get_relfile = function()
  local file, _ = string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. "/", "")
  return file
end

local start = function()
  vim.lsp.start_client({
    cmd = { 'node', "/home/zach/development/codexls/vscode-extension-samples/lsp-sample/server/out/server.js", "--stdio" },
    name = "testserver",
    trace = "messages",
    root_dir = vim.loop.cwd(),
    autostart = true,
    on_init = function(client, _)
      vim.lsp.buf_attach_client(0, client.id)
      if vim.fn.has("nvim-0.7") > 0 then
        vim.api.nvim_create_autocmd({ "BufEnter" }, {
          callback = function()
            vim.lsp.buf_attach_client(0, client.id)
          end,
          once = false,
        })
      end
    end,
    on_attach = function()
      print("attached")
    end,
  })
end

start()
