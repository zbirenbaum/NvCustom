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
vim.g.python_host_skip_check=1
vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
vim.o.showcmd = false
vim.o.showmode = false
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

local w = vim.loop.new_fs_event()
local function on_change(err, fname, status)
  -- Do work...
  vim.api.nvim_command('checktime')
  -- Debounce: stop/start.
  w:stop()
  watch_file(fname)
end
function watch_file(fname)
  local fullpath = vim.api.nvim_call_function(
    'fnamemodify', {fname, ':p'})
  w:start(fullpath, {}, vim.schedule_wrap(function(...)
    on_change(...) end))
end
vim.api.nvim_command(
  "command! -nargs=1 Watch call luaeval('watch_file(_A)', expand('<args>'))")
