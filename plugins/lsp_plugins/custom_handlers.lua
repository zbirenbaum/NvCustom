vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    format = function(diagnostic)
      return require("dim").ignore_vtext(diagnostic)
    end,
  },
  signs = true,
  underline = false,
  update_in_insert = false, -- update diagnostics insert mode
})
