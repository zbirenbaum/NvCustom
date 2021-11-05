local present, cmp = pcall(require, "cmp")
local colors = require("colors").get()

if not present then
   return
end
vim.opt.completeopt = "menuone,noselect"
-- nvim-cmp setup
vim.cmd[[ highlight CmpItemKind guifg=#ae43f0 ]]
vim.cmd[[ highlight CmpItemMenu guifg=#ae43f0 ]]
--vim.cmd[[ highlight CmpItemMenu guifg=#f90c71 ]]
vim.cmd[[ highlight CmpItemAbbr guifg=#565c64 ]]

cmp.setup {
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   formatting = {
      format = function(entry, vim_item)
         -- load lspkind icons
         vim_item.kind = string.format(
            "[%s]",
            require("custom.plugins.cmp_configs.lspkind_icons").icons[vim_item.kind]
         )

         vim_item.menu = ({
            -- nvim_lsp = "「LSP」 ",
            -- nvim_lua = "「Lua」 ",
            -- buffer = "「BUF」 ",
            nvim_lsp = "{LSP} ",
            nvim_lua = "{Lua}",
            buffer = "{BUF}",
         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
     
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
   },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
   },
}
