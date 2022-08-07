local util = require 'lspconfig.util'
local M = {}

local bin_name = 'solidity-language-server'
if vim.fn.has 'win32' == 1 then bin_name = bin_name .. '.cmd' end

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
