local get_config = function (options)
  local config = {
    launch = {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    attach = {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
  return vim.tbl_map(function (option)
    return config[option]
  end, options)
end

require("dap-vscode-js").setup({
  debugger_path = '/home/zach/progfiles/microsoft/vscode-js-debug',
  adapters = {
    'pwa-node',
    'pwa-chrome',
    'pwa-msedge',
    'node-terminal',
    'pwa-extensionHost'
  },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  local opt = get_config({ 'launch' })
  print(vim.inspect(opt))
  require("dap").configurations[language] = opt
end
