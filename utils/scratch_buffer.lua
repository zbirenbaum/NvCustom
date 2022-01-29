local M = {}
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
