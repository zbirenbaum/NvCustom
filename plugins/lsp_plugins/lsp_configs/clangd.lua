local util = require("lspconfig.util")

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader

local M = {}
local function switch_source_header(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("Corresponding file cannot be determined")
        return
      end
      vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
    end, bufnr)
  else
    print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
  end
end

local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")

local default_capabilities = vim.tbl_deep_extend(
  "force",
  util.default_config.capabilities or vim.lsp.protocol.make_client_capabilities(),
  {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  }
)

M.config_table = function(attach, capabilities)
  return {
    filetypes = { "c", "cpp", "cuda" },
    cmd = { "clangd" },
    root_dir = function(fname)
      local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
      return root_pattern(filename)
    end,
    single_file_support = true,
    capabilities = vim.tbl_deep_extend("force", default_capabilities, capabilities),
    attach = attach,
    commands = {
      ClangdSwitchSourceHeader = {
        function()
          switch_source_header(0)
        end,
        description = "Switch between source/header",
      },
    },
  }
end

return M
