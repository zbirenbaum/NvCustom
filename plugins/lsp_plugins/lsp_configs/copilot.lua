local M = {}

local util = require "lspconfig.util" --local messages = {}
local cmd = vim.fn.expand('$HOME') .. "/.local/share/nvim/site/pack/packer/opt/copilot.vim/lua/start_server"

local root_files = {
   '.git',
   '.gitignore',
}

local add_default = function()
   local configs = require "lspconfig.configs"
   configs["copilot"] = {
      default_config = {
         cmd = cmd,
         filetypes = { 'lua', 'vimscript', 'vim' },
         root_dir = util.root_pattern(unpack(root_files)),
         single_file_support = true,
      },
   }
end

M.config_table = function(attach, capabilities)
   local config = {
      on_attach = attach,
      capabilities = capabilities,
      cmd = {cmd},
      filetypes = { 'lua', 'vimscript', 'vim' },
      root_dir = util.root_pattern(unpack(root_files)),
      single_file_support = true,
   }
   return config
end

add_default()

return M
