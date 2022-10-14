local lsputil = require('lspconfig.util')
local bin_name = 'vscode-solidity'
if vim.fn.has 'win32' == 1 then bin_name = bin_name .. '.cmd' end

require("lspconfig.configs").vscode_solidity = {
  default_config = {
    name = "vscode_solidity",
    autostart = true,
    single_file_support = true,
    cmd = { bin_name, '--stdio' },
    filetypes = { "python" },
    root_dir = function(fname)
      local markers = {
        '.git',
        '.gitignore'
      }
      return lsputil.root_pattern(unpack(markers))(fname)
      or lsputil.find_git_ancestor(fname)
      or lsputil.path.dirname(fname)
    end,
  }
}
local util = require 'lspconfig.util'
local M = {}


M.config_table = function (attach, capabilities)
  return {
    on_attach = attach,
    capabilities = capabilities,
    cmd = { bin_name, '--stdio' },
    filetypes = { 'solidity' },
    root_dir = util.root_pattern('.git', 'package.json'),
  }
end

return M
