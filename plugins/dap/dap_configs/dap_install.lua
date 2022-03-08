local dap_install = require("dap-install")
local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "jsnode/"
local fn = vim.fn
local dap = require('dap');
dap.set_log_level('TRACE');

dap_install.config(
  "jsnode",{
    adapters = {
      type = "executable",
      command = "node",
      args = { dbg_path .. "vscode-node-debug2/out/src/nodeDebug.js", "--stdio" },
    },
    configurations = {
      {
        type = "node2",
        request = "launch",
        program = '${file}',
        cwd = fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
    }
  }
)


