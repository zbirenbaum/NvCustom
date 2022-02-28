require("toggleterm").setup {
   -- size can be a number or function which is passed the current terminal
   size = function(term)
      if term.direction == "horizontal" then
         return 15
      elseif term.direction == "vertical" then
         return vim.o.columns * 0.5
      end
   end,

   --  open_mapping = [[<c-x>]],
   hide_numbers = true, -- hide the number column in toggleterm buffers
   shade_filetypes = {},
   shade_terminals = false,
   shading_factor = "0", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
   start_in_insert = true,
   insert_mappings = false, -- whether or not the open mapping applies in insert mode
   persist_size = false,
   direction = "horizontal", --'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
   close_on_exit = true, -- close the terminal window when the process exits
   shell = vim.o.shell, -- change the default shell
   -- This field is only relevant if direction is set to 'float'
   float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "single", --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = math.floor(vim.o.columns * 0.5),
      height = 15,
      winblend = 0,
      highlights = {
         border = "Normal",
         background = "Normal",
      },
   },
}

local function float_mappings(mapping)
   vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', {
      silent = true,
      noremap = true,
   })
end

local function horizontal_mappings(mapping)
   vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', {
      silent = true,
      noremap = true,
   })
end

local function vertical_mappings(mapping)
   vim.api.nvim_set_keymap("n", mapping, '<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("t", mapping, '<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>', {
      silent = true,
      noremap = true,
   })
end

horizontal_mappings "<C-s>"
-- horizontal_mappings "<leader>h"
vertical_mappings "<C-x>"
float_mappings "<A-i>"
require("custom.utils.mappings").terminal()

-- function _G.set_terminal_keymaps()
--    local opts = { noremap = true }
--    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
--    vim.api.nvim_buf_set_keymap(0, "t", "jk", "<esc>", opts)
--    vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
--    vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
--    vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
--    vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
