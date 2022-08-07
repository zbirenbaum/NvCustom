vim.api.nvim_create_autocmd({'BufEnter', 'BufRead'}, {
  pattern = {'*.g4'},
  callback = function ()
    vim.o.filetype = 'antlr4'
  end
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufRead'}, {
  pattern = {'*.sol'},
  callback = function ()
    vim.o.cindent = true;
  end
})
