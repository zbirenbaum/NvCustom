vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    vim.opt.foldmethod = "marker"
    vim.bo.indentexpr = ""
    vim.bo.autoindent = false
    vim.bo.smartindent = true
  end,
})
vim.opt_local.breakindentopt = 'list:-1'
vim.opt_local.formatlistpat = [[^\s*[-~\*]\+\s\+]]
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.integrations.treesitter"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.completion"] = {config = {engine = 'nvim-cmp'}},
    ["core.integrations.nvim-cmp"] = {},
  },
})
