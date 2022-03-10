local start = function()
   require "nvim-treesitter"
   require("nvim-treesitter.configs").setup {
      indent = { enable = false },
      highlight = {
         enable = true,
         use_languagetree = true,
      },
   }
  require("custom.plugins.lsp_plugins.dim_unused.dim").setup({disable_lsp_decorations=true})
end

vim.schedule(start)
