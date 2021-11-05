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
