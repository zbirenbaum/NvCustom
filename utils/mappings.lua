local opts = { noremap = true, silent = true }
local maps = vim.keymap.set
local M = {}

M.tab = function ()
  maps({"i", "n", "t", "v"}, '<C-i>', '<tab>', {silent=true, remap=true})
  -- this probably doesn't belong here but neither does a function with one mapping...
  maps({"n"}, "<ESC>", function() vim.cmd("noh") end, opts)
end

local choose_debug_session = function ()
  if vim.lo.filetype == "lua" and not require("dap").session() then require("osv").run_this()
  else require("dap").continue() end
end

M.debug_bindings = {
  mappings = {
    { 'n', "<C-b>" },
    { 'n', "<C-o>" },
    { 'n', "<C-O>" },
    { 'n', "<C-n>" },
    { 'n', "<Leader>r" },
    { 'n', "<Leader>c" },
  },
  callbacks = {
    function () require("dap").toggle_breakpoint() end,
    function () require("dap").step_over() end,
    function () require("dap").step_out() end,
    function () require("dap").step_into() end,
    function () require("dap").repl.toggle() end,
    function () choose_debug_session() end
  }
}

M.debug = function()
  for index, mapping in pairs(M.debug_bindings.mappings) do
    maps(mapping[1], mapping[2], M.debug_bindings.callbacks[index], opts)
  end
  maps("n", "<leader>t", function()
    vim.cmd([[TroubleToggle]])
  end, opts)
end

M.terminal_mappings = function ()
  local ft_cmds = {
    python = "python3 " .. vim.fn.expand('%'),
  }
  local toggle_modes = {'n', 't'}
  local mappings = {
    { 'n', '<C-l>', function () require("nvterm.terminal").send(ft_cmds[vim.bo.filetype]) end },
    { toggle_modes, '<A-h>', function () require("nvterm.terminal").toggle('horizontal') end },
    { toggle_modes, '<A-v>', function () require("nvterm.terminal").toggle('vertical') end },
    { toggle_modes, '<A-i>', function () require("nvterm.terminal").toggle('float') end },
  }
  return mappings
end

M.lsp = function ()
  local lsp = vim.lsp.buf
  local diag = vim.diagnostic
  maps({"n"}, "gD", function() lsp.declaration() end, opts)
  maps({"n"}, "gd", function() lsp.definition() end, opts)
  maps({"n"}, "K", function() lsp.hover() end, opts)
  maps({"n"}, "gi", function() lsp.implementation() end, opts)
  maps({"n"}, "<C-k>", function() lsp.signature_help() end, opts)
  maps({"n"}, "<leader>D", function() lsp.type_definition() end, opts)
  maps({"n"}, "<leader>ra", function() lsp.rename() end, opts)
  maps({"n"}, "<leader>ca", function() lsp.code_action() end, opts)
  maps({"n"}, "gr", function() lsp.references({}) end, opts)
  maps({"n"}, "<leader>f", function() diag.open_float() end, opts)
  maps({"n"}, "[d", function() diag.goto_prev() end, opts)
  maps({"n"}, "d]", function() diag.goto_next() end, opts)
  maps({"n"}, "<leader>q", function() vim.diagnostic.setloclist() end, opts)
  maps({"n"}, "<leader>fm", function() lsp.formatting() end, opts)
  maps({"n"}, "<leader>wa", function() lsp.add_workspace_folder() end, opts)
  maps({"n"}, "<leader>wr", function() lsp.remove_workspace_folder() end, opts)
  maps({"n"}, "<leader>wl", function() print(vim.inspect(lsp.list_workspace_folders())) end, opts)
end

M.comment = function ()
  maps({"n"}, "<leader>/", function() require("Comment.api").toggle_current_linewise() end, opts)
  maps({"v"}, "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)
end

M.terminal = function()
  maps("t", "<esc>", [[<C-\><C-n>]], opts)
  maps("t", "jk", "<esc>", opts)
  maps("t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  maps("t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  maps("t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  maps("t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
  vim.tbl_map(function(mapping)
    vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
  end, M.terminal_mappings())
end

return M
