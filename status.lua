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
  nvimtree = true,
  --My Plugins
  autopairs = true,
  marks = false,
  gps = false,
  luadev = false,
  better_escape = true,
  -- Completions, choose 1
  coq = false,
  cmp = true,
  dap = true,
  dap_vtext = false,
  -- tab plugins
  trouble = true,
  --vscode style ex mode
  cmdline = false,
  lspkind = true,
  --cmdheight rfc
  cmdheight = false,
  --broken for now
  matchparen = true,
  --choose 1
  hop = false,
  leap = false,
  lightspeed = true,
  jqx = true,
  blankline = true, -- beautified blank lines
  cheatsheet = false, -- fuzzy search your commands/keymappings
  colorizer = true,
  comment = true, -- universal commentor
  firenvim = false,
  null_ls = false,

  copilot = true,
  playground = false,
}

return status
