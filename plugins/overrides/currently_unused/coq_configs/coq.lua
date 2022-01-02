vim.g.coq_settings = {
  auto_start = 'shut-up',
  display = {
    icons = {
      mode = "short",
    },
    pum = {
      y_max_len=5,
--      y_ratio=,
      x_max_len = 60,
    },
    preview = {
      positions = {
        ["south"]=1,
        ["east"]=2,
        ["north"]=3,
        ["west"]=4,
      },
    },
  },
}
