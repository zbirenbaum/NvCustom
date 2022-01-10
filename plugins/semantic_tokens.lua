require'nvim-semantic-tokens'.setup({
  preset = "default"
})

vim.cmd [[
	autocmd BufEnter,CursorHold,InsertLeave <buffer> echo &filetype
]]
--feature check not rel here
-- if pcall(require, "vim.lsp.nvim-semantic-tokens") then
--   require("nvim-semantic-tokens").setup {
--     preset = "default"
--   }
-- end
vim.cmd [[ if &filetype == "cpp" || &filetype == "cuda" || &filetype == "c" || &filetype == "python"
  autocmd BufEnter,CursorHold,InsertLeave <buffer> lua require 'vim.lsp.buf'.semantic_tokens_full()
endif ]]
