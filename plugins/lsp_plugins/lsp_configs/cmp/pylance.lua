local M = {}

M.setup = function(attach, capabilities)
   local util = require "lspconfig.util"
   local messages = {}
   local bin_name = 'pylance-langserver'
   local cmd = { bin_name, '--stdio' }

   if vim.fn.has 'win32' == 1 then
      cmd = { 'cmd.exe', '/C', bin_name, '--stdio' }
   end

   local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
   }

   local function organize_imports()
      local params = {
         command = 'pylance.organizeimports',
         arguments = { vim.uri_from_bufnr(0) },
      }
      vim.lsp.buf.execute_command(params)
   end

   local configs = require "lspconfig.configs"
   configs["pylance"] = {
      default_config = {
         cmd = cmd,
         filetypes = { 'python' },
         root_dir = util.root_pattern(unpack(root_files)),
         single_file_support = true,
         settings = {
            python = {
               analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = 'openFilesOnly',
                  --					useLibraryCodeForTypes = true,
                  --					typeshedPath = "/home/zach/progfiles/pylance/extension/dist/bundled/stubs/",
                  reportMissingTypeStubs = true,
               }
            },
         },
      },
   }

   require("lspconfig").pylance.setup{
      on_attach = attach,
      capabilities = capabilities,
      cmd = cmd,
      filetypes = { 'python' },
      root_dir = util.root_pattern(unpack(root_files)),
      single_file_support = true,
      settings = {
         python = {
            analysis = {
               autoSearchPaths = true,
               useLibraryCodeForTypes = false,
               diagnosticMode = 'openFilesOnly',
               reportMissingTypeStubs = true,
            },
         },
      },
      commands = {
         PyrightOrganizeImports = {
            organize_imports,
            description = 'Organize Imports',
         },
      },
      docs = {
         package_json = '/home/zach/progfiles/pylance/extension/package.json',
         description = [[
         https://github.com/microsoft/pyright
         `pyright`, a static type checker and language server for python
         ]],
      },
   }
end

return M
