--require("core.utils").packer_lazy_load
require("nvim-treesitter")


vim.defer_fn(function()
  require("nvim-treesitter.configs").setup {
    indent = { enable = false },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  }
  --vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
end, 0)

--local present, ts_config = pcall(require, "nvim-treesitter.configs")

-- if not present then
--    return
-- end
--
