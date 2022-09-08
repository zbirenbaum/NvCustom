local overrides = {
  ["DiffAdd"] = { fg = '#61afef', bg = 'NONE' },
  ["DiffChange"] = { fg = '#565c64', bg = 'NONE' },
  ["DiffChangeDelete"] = { fg = '#d47d85', bg = 'NONE' },
  ["DiffModified"] = { fg = '#d47d85', bg = 'NONE' },
  ["DiffDelete"] = { fg = '#d47d85', bg = 'NONE' },
  ["SignColumn"] = { fg = 'NONE', bg = 'NONE' },
}

require('tokyonight').setup({
  style = 'carbonfox',
  transparent = true,
  on_highlights = function (hl, c)
    for group, highlight in pairs(overrides) do
      hl[group] = highlight
    end
  end
})

vim.cmd[[colorscheme tokyonight-storm]]
