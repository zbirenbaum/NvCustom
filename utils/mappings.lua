local opts = { noremap = true, silent = true }
local maps = vim.keymap.set
local M = {}

local choose_debug_session = function ()
  if vim.bo.filetype == "lua" and not require("dap").session() then require("osv").run_this()
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

M.terminal = function()
  local terminal = require("nvterm.terminal")
  local ft_cmds = {
    python = "python3 " .. vim.fn.expand('%'),
  }
  local mappings = {
    { 'n', '<C-l>', function () terminal.send(ft_cmds[vim.bo.filetype]) end },
    { 'n', '<Leader>s', function () terminal.new_or_toggle('horizontal') end },
    { 'n', '<Leader>v', function () terminal.new_or_toggle('vertical') end },
  }
  local create_mappings = function ()
    for _, mapping in ipairs(mappings) do
      vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
  end
  create_mappings()
  maps("t", "<esc>", [[<C-\><C-n>]], opts)
  maps("t", "jk", "<esc>", opts)
  maps("t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  maps("t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  maps("t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  maps("t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
  -- maps("n", "<C-l>", function()
    -- require("custom.plugin_dev_debug.print_to_buf").runfile()
  -- end, opts)
end

return M
