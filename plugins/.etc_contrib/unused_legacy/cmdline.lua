require('fine-cmdline').setup({
  popup = {
    buf_options = {
      filetype = 'FineCmdlinePrompt'
    }
  },
})

vim.api.nvim_set_keymap(
  'n',
  ':',
  '<cmd>lua require("fine-cmdline").open()<CR>',
  {noremap = true}
)
