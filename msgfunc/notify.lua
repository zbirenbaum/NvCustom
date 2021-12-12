local notify = require("notify")
notify.setup({
  stages = "fade",
  on_open = nil,
  on_close = nil,
  render = "minimal",
  timeout = 50,
  background_colour = "#000000",
  minimum_width = 0,
  icons = {
    error = "",
    warn = "",
    info = "",
    debug = "",
    trace = "✎",
  },
})

return notify
