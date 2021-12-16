 vim.g.clipboard = {
  name= 'unnamedplus',
  copy = {
    ["+"] ='xclip -i -selection clipboard',
    ["*"]= 'xclip -i -selection primary', },
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
vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
--vim.o.nosc = true
--vim.o.cmdheight = 0

vim.cmd[[ set noshowmode ]]
vim.cmd[[ set nosc ]]
-- if vim.env.TMUX then
--   vim.g.t_SI = "\\<Esc>Ptmux;\\<Esc>\\e[5 q\\<Esc>\\\\"
--   vim.g.t_EI = "\\<Esc>Ptmux;\\<Esc>\\e[1 q\\<Esc>\\\\"
-- else
--     vim.g.t_EI = "\\e[5 q"
--     vim.g.t_SI = "\\e[1 q"
-- end

-- vim.cmd[[
-- if exists('$TMUX')
--     let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
--     let &t_EI = "\<Esc>Ptmux;\<Esc>\e[1 q\<Esc>\\"
-- else
--     let &t_SI = "\e[5 q"
--     let &t_EI = "\e[1 q"
-- endif
-- ]]
--set initial state on bufenter

-- vim.api.nvim_set_keymap('n', ':', '<CMD>set laststatus=0<CR>:', {noremap = true})
-- vim.api.nvim_set_keymap('n', ':', '<CMD>set cmdheight=1<CR>:', {noremap = true})
-- vim.cmd [[ autocmd CmdlineEnter * set laststatus=0 ]]
-- vim.cmd [[ autocmd CmdlineLeave * set laststatus=2 ]]
-- vim.api.nvim_set_keymap('n', ':', '<CMD>:lua require "custom.cmdhider".on_cmd_enter()<CR>:', {noremap = true})
-- vim.cmd [[ autocmd CmdlineLeave * lua require "custom.cmdhider".on_cmd_exit() ]]
-- if has_key(environ(), 'TMUX')
--   augroup tmux_something
--     autocmd VimResume  * call system('tmux set status off')
--     autocmd VimEnter   * call system('tmux set status off')
--     autocmd VimLeave   * call system('tmux set status on')
--     autocmd VimSuspend * call system('tmux set status on')
--   augroup END
-- endif
