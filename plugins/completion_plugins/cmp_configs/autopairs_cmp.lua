local M = {}
vim.g.matchup_matchparen_offscreen = { method = "popup" }
M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

  if not (present1 or present2) then
    return
  end

  autopairs.setup()

  -- not needed if you disable cmp, the above var related to cmp tooo! override default config for autopairs
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
return M.autopairs()
