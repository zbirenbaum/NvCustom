require("nightfox").setup({
  options = { transparent = true, },
  groups = {
    all = {
      ["DiffAdd"] = { fg = '#61afef', bg = 'NONE' },
      ["DiffChange"] = { fg = '#565c64', bg = 'NONE' },
      ["DiffChangeDelete"] = { fg = '#d47d85', bg = 'NONE' },
      ["DiffModified"] = { fg = '#d47d85', bg = 'NONE' },
      ["DiffDelete"] = { fg = '#d47d85', bg = 'NONE' },
      ["SignColumn"] = { fg = 'NONE', bg = 'NONE' },
    }
  }
})

-- vim.cmd[[colorscheme nightfox]]
-- vim.cmd("colorscheme duskfox")
vim.cmd("colorscheme carbonfox")
