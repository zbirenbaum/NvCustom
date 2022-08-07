local g = vim.g
local o = vim.o
local opt = vim.opt

-- lang specific settings
g.python_recommended_style = 0
g.rust_recommended_style= 0
g.solidity_recommended_style= 0
-- clipboard support over ssh
g.clipboard = {
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
o.showcmd = false
o.showmode = false
o.lazyredraw = 1
o.shadafile = "/home/zach/.local/share/nvim/shada/main.shada"
o.pumheight = 6
o.pumwidth = 12
o.laststatus = 3
o.shiftwidth = 2
o.showtabline = 0 -- shown in statusline

opt.clipboard = "unnamedplus"
opt.hidden = true
opt.ignorecase = true
opt.expandtab = true
opt.mouse = ""
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.timeoutlen = 400
opt.updatetime = 250
opt.termguicolors = true
opt.cmdheight = 1
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.list = true
opt.listchars:append("eol:↴")
opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false
opt.undofile = true
opt.cul = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.shortmess:append "sI"

-- globals
g.mapleader = " "
g.loaded_matchparen = 1
g.python_host_skip_check = 1
g.python3_host_prog = "/home/zach/.virtualenvs/py3nvim/bin/python"
g.python_host_prog = "/home/zach/.virtualenvs/py2nvim/bin/python"

-- use lua filedetect
g.transparency = true

-- builtin plugin stuff
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
