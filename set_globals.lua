 vim.g.clipboard = {
  name= 'unnamedplus',
  copy = {
    ["+"] ='xclip -i -selection clipboard',
    ["*"]= 'xclip -i -selection primary',
  },
  paste= {
    ["+"] = 'xclip -o -selection clipboard',
    ["*"] = 'xclip -o -selection primary',
  },
  cache_enabled = 0
}

-- vim.g.clipboard = {
--   name= 'unnamedplus',
--   copy = {
--     ["+"] ='xsel -i -b',
--     ["*"]= 'xsel -i -p',
--   },
--   paste= {
--     ["+"] ='xsel -b',
--     ["*"]= 'xsel -p',
--   },
--   cache_enabled='0',
-- }
vim.g.matchup_matchparen_offscreen = {method = 'popup'}
vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
--vim.o.nosc = true
vim.o.cmdheight = 1

vim.cmd[[ set noshowmode "off" ]]
vim.cmd[[ set nosc ]]
-- if has_key(environ(), 'TMUX')
--   augroup tmux_something
--     autocmd VimResume  * call system('tmux set status off')
--     autocmd VimEnter   * call system('tmux set status off')
--     autocmd VimLeave   * call system('tmux set status on')
--     autocmd VimSuspend * call system('tmux set status on')
--   augroup END
-- endif
