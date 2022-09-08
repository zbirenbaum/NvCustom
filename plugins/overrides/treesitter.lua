local start = function()
  require("nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "rust",
      "go",
      "python",
      "javascript",
      "typescript",
      "bash",
      "gomod",
      "cuda",
      "cmake",
      "comment",
      "json",
      "solidity",
      "regex",
      "yaml",
    },
    indent = {
      enable = false,
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end
vim.schedule(start)
