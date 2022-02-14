local status = {
  autosave = false, -- to autosave files
  bufferline = false, -- buffer shown as tabs
  dashboard = false, -- a nice looking dashboard
  esc_insertmode = true, -- escape from insert mode using custom keys
  feline = true, -- statusline
  gitsigns = true, -- gitsigns in statusline
  lsp_signature = false, -- lsp enhancements
  neoscroll = true, -- smooth scroll
  telescope_media = true, -- see media files in telescope picker
  truezen = true, -- no distraction mode for nvim
  nvimtree=false,

  --My Plugins
  autopairs = true,
  marks = false,
  gps = false,
  luadev = false,

  -- Completions, choose 1
  coq = false,
  cmp = true,
  dap = true,
  tabline=false,
  --organized diagnostics
  trouble = false,
  --vscode style ex mode
  cmdline = false,
  lspkind = true,
  --cmdheight rfc
  cmdheight = false,
  --its kinda cool and no real slowdown for me, but not lua so disabled out of principle
  wilder=false,
  --choose 1
  vim_matchup = false, -- % magic, match it but improved
  --broken for now
  matchparen=true,
  --choose 1
  hop = false,
  lightspeed = true,

  jqx = true,
  toggleterm = true,
  blankline = true, -- beautified blank lines
  cheatsheet = false, -- fuzzy search your commands/keymappings
  colorizer = true,
  comment = true, -- universal commentor
}

return status