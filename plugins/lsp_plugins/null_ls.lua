local null_ls = require("null-ls")
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    code_actions.eslint_d,
    diagnostics.eslint_d,
  }
})
