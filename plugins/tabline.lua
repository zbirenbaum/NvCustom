require('tabline').setup{
    no_name = '[No Name]',    -- Name for buffers with no name
    modified_icon = '',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "",          -- Separator icon on the left side
    padding = 1,              -- Prefix and suffix space
    color_all_icons = false,  -- Color devicons in active and inactive tabs
    always_show_tabs = false, -- Always show tabline
    right_separator = false,  -- Show right separator on the last tab
    show_index = false,       -- Shows the index of tab before filename
    show_icon = true,         -- Shows the devicon
}

--doesn't work but also not sure I need to fix it
-- local opts = { noremap = true }
-- vim.api.nvim_buf_set_keymap(0, "n", "gn", "gt", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "gN", "gT", opts)
