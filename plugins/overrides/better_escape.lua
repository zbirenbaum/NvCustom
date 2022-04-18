require("better_escape").setup({
  mapping = { "jk" }, -- a table with mappings to use
  timeout = 300,
  clear_empty_lines = true, -- clear line after escaping if there is only whitespace
  keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
})
