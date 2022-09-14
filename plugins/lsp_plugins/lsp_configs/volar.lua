local util = require('lspconfig.util')
local package_installed = require('custom.utils.functions').package_installed
local M = {}

M.config_table = function (attach, capabilities)
  return {
    attach = attach,
    capabilities = capabilities,
    filetypes = package_installed 'vue' and { 'vue', 'typescript', 'javascript' } or { 'vue' },
    root_dir = function(fname)
      return util.root_pattern({'vue.config.js', 'vite.config.ts'})(fname)
    end,
  }
end
return M
