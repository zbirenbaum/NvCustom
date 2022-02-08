vim.schedule(function()
   require "nvim-treesitter"
   require("nvim-treesitter.configs").setup {
    indent = { enable = false },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
   }
   vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
end)

--local present, ts_config = pcall(require, "nvim-treesitter.configs")

-- if not present then
--    return
-- end
--

-- if vim.bo.filetype == "norg" then
--    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
--
--    -- These two are optional and provide syntax highlighting
--    -- for Neorg tables and the @document.meta tag
--    parser_configs.norg_meta = {
--        install_info = {
--            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
--            files = { "src/parser.c" },
--            branch = "main"
--        },
--    }
--
--    parser_configs.norg_table = {
--        install_info = {
--            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
--            files = { "src/parser.c" },
--            branch = "main"
--        },
--    }
-- end
-- if vim.bo.filetype == "norg" then
--    require('neorg').setup {
--       ["core.defaults"] = {}
--    }
