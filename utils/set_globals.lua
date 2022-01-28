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

vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
--vim.cmd[[ set shada = '200,f1,<200,:50,/50 ]]
--vim.o.nosc = true
--vim.o.cmdheight = 0

vim.cmd[[ set noshowmode ]]
vim.cmd[[ set nosc ]]

--disable builtins
----already done by nvchad
-- vim.g.loaded_gzip = 1
-- vim.g.loaded_tar = 1
-- vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_zip = 1
-- vim.g.loaded_zipPlugin = 1
-- vim.g.loaded_getscript = 1
-- vim.g.loaded_getscriptPlugin = 1
-- vim.g.loaded_vimball = 1
-- vim.g.loaded_vimballPlugin = 1
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
-- vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_logiPat = 1
-- vim.g.loaded_rrhelper = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_ftplugin = 1
--
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
