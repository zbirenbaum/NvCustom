local M = {}
M.navigation = function ()
  vim.keymap.set('n', '<C-l>', '$', {silent=true, noremap=true})
  vim.keymap.set('n', '<C-h>', '^', {silent=true, noremap=true})
  vim.keymap.set('c', '<C-c>', '<C-e>', {silent=true, noremap=true})
end

M.dap = function ()
  vim.keymap.set('n', '<C-b>', function () require("dap").toggle_breakpoint() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<Leader>r', function () require("dap").repl.toggle() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<Leader>d', function () require("dapui").toggle() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-o>', function () require("dap").step_out() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-n>', function () require("dap").step_into() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-c>',
    function()
      if vim.bo.filetype == "lua" and not require("dap").session() then
        require("osv").run_this()
      else
        require("dap").continue()
      end
    end,
    {silent=true, noremap=true})
end
M.redir = function ()
   vim.keymap.set('n', '<leader>n', ':Nredir luafile %<CR><C-w>h')
   --vim.cmd[[au InsertEnter * lua require('custom.redir')]]
   --vim.cmd[[command! -nargs=1 -complete=command Nredir lua require'custom.redir'.nredir(<q-args>)]]
end

return M

-- vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "$", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "^", opts)
--vim.api.nvim_buf_set_keymap(0, "n", "<C-w>b", "<CMD>terminal w3m www.duckduckgo.com<CR>",opts)
