local start = function()
  require("nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    indent = { enable = false },
    highlight = {
      enable = true,
      disable = {'org'},
      additional_vim_regex_highlighting = {'org'},
      use_languagetree = true,
    },
  })
end
vim.schedule(start)
