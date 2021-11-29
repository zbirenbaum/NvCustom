local opts = { noremap = true }
vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "$", opts)
vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "^", opts)
--vim.api.nvim_buf_set_keymap(0, "n", "<C-w>b", "<CMD>terminal w3m www.duckduckgo.com<CR>",opts)
