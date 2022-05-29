vim.g.clipboard = {
  name = "unnamedplus",
  copy = {
    ["+"] = "xclip -i -selection clipboard",
    ["*"] = "xclip -i -selection primary",
  },
  paste = {
    ["+"] = "xclip -o -selection clipboard",
    ["*"] = "xclip -o -selection primary",
  },
  cache_enabled = 0,
}

vim.o.pumheight = 6
vim.o.pumwidth = 12
vim.g.loaded_matchparen = 1
vim.g.python_host_skip_check = 1
vim.g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
vim.g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"
vim.o.showcmd = false
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.shiftwidth = 2
vim.o.showtabline = 0 -- shown in statusline
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.o.signcolumn = "yes"
vim.o.relativenumber = true

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_matchit = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
