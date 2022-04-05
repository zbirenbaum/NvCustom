local M = {}

local util = require("lspconfig.util") --local messages = {}
local bin_name = "clangd"
local cmd = { bin_name, "--cuda-gpu-arch=sm_75" }

if vim.fn.has("win32") == 1 then
  cmd = { "cmd.exe", "/C", bin_name, "--stdio" }
end

--
local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

local function organize_imports()
  local params = {
    command = "pylance.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local function get_python_path(workspace)
  local path = util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local add_default = function()
  local configs = require("lspconfig.configs")
  configs["pylance"] = {
    default_config = {
      cmd = cmd,
      filetypes = { "python" },
      root_dir = util.root_pattern(unpack(root_files)),
      single_file_support = true,
      settings = {
        python = {
          venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python" or nil,
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            reportMissingTypeStubs = true,
          },
        },
      },
    },
  }
end

M.config_table = function(attach, capabilities)
  local config = {
    on_attach = attach,
    capabilities = capabilities,
    cmd = cmd,
    filetypes = { "python" },
    root_dir = util.root_pattern(unpack(root_files)),
    single_file_support = true,
    settings = {
      python = {
        venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or nil,
        --            pythonPath = pypath,
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
          --               reportMissingTypeStubs = true,
        },
      },
    },
    commands = {
      PyrightOrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
    },
    docs = {
      package_json = "/home/zach/progfiles/pylance/extension/package.json",
      description = [[
         https://github.com/microsoft/pyright
         `pyright`, a static type checker and language server for python
         ]],
    },
  }
  return config
end

add_default()

return M
