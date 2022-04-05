local start = function()
  require("nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    indent = { enable = false },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end

vim.schedule(start)
