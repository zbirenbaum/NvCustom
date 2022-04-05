local dim = require("custom.plugins.lsp_plugins.dim_unused.dim")
dim.setup()

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    format = function(diagnostic)
      return dim.ignore_vtext(diagnostic)
    end,
  },
  signs = true,
  underline = false,
  update_in_insert = false, -- update diagnostics insert mode
})
