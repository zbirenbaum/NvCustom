local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
      if opts then options = vim.tbl_extend('force', options, opts) end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- local opts = { noremap = true, silent=true }
-- --vim.cmd[[call nvim_set_keymap('n', ' <NL>', '', {'nowait': v:true})]]
-- vim.api.nvim_set_keymap("n", "<C-l>", "$", opts)
-- vim.api.nvim_set_keymap("n", "<C-h>", "^", opts)
-- vim.api.nvim_set_keymap("c", "<C-c>", "<C-e>", opts)
map('n', '<C-l>', '$')
map('n', '<C-h>', '^')
map('c', '<C-c>', '<C-e>')

-- vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "$", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "^", opts)
--vim.api.nvim_buf_set_keymap(0, "n", "<C-w>b", "<CMD>terminal w3m www.duckduckgo.com<CR>",opts)
