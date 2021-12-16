local async = require("plenary.async")

async.run(function ()
  vim.cmd([[
    function! Notify(method, kind, chunks, overwrite) abort
    try
      for l:item in a:chunks
        if l:item[1] != "\n" && l:item[1] != "\r" && len(l:item[1]) > 0 && l:item[1] != "<"
          call luaeval('require"custom.msgfunc.notify"(_A[1], "info")', [l:item[1] ])
        else
          set laststatus=2
        endif
      endfor
    endtry
    endfunction
    set msgfunc=Notify
  ]])
end)

vim.cmd [[ set cmdheight=0 ]]
vim.cmd [[ set laststatus=2 ]]
--setting autocmd for CmdlineEnter causes no ':' to appear so we remap :
vim.api.nvim_set_keymap('n', ':', '<CMD>:lua require "custom.msgfunc.cmdhider".on_cmd_enter()<CR>:', {noremap = true})
--Return to initial state on leaving Cmdline
vim.cmd [[ autocmd CmdlineLeave * lua require "custom.msgfunc.cmdhider".on_cmd_exit() ]]
vim.cmd [[ autocmd BufEnter * set laststatus=2 ]]
