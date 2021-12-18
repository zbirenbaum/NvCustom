vim.cmd[[command CommentToggle lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())]]


vim.api.nvim_command("command! -range CommentToggle lua require('Comment.api').toggle_linewise_op(require('CommentToggle').is_visual())")

