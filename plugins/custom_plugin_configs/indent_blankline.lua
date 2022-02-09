vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
   filetype_exclude = {
      "help",
      "terminal",
      "dashboard",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "nvchad_cheatsheet",
      "lsp-installer",
      "",
   },
   show_end_of_line = true,
   show_trailing_blankline_indent = false,
   show_first_indent_level = false,
}
