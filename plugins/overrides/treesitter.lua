vim.schedule(function()
   require "nvim-treesitter"
   require("nvim-treesitter.configs").setup {
      ensure_installed = {"query", "vim", "lua"},
      indent = { enable = false },
      highlight = {
         enable = true,
         use_languagetree = true,
      },
      playground = {
         enable = true,
         disable = {},
         updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
         persist_queries = false, -- Whether the query persists across vim sessions
         keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
         },
      }
   }
end)


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-k>', function() vim.cmd[[:TSHighlightCapturesUnderCursor]] end, opts)
-- vim.api.nvim_create_autocmd({"CursorHold"},{
--    callback = function ()
--       vim.cmd[[:TSHighlightCapturesUnderCursor]]
--    end,
--    once = false,
-- })
