local present, cmp = pcall(require, "cmp")
--local colors = require("colors").get()
local lspkind = require("custom.plugins.completion_plugins.cmp_configs.lspkind")
--local custom_comp = require("custom.plugins.overrides.cmp_configs.custom_type_comparator")
if not present then
   return
end


vim.opt.completeopt = "menuone,noselect"

--suppress error messages from lang servers
vim.notify = function(msg, log_level)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

cmp.setup {
   snippet = {expand = function(args) require("luasnip").lsp_expand(args.body) end},
   formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
   },
   completion = {
      autocomplete = {
         require('cmp.types').cmp.TriggerEvent.InsertEnter,
         require('cmp.types').cmp.TriggerEvent.TextChanged
      },
      keyword_length = 1,
      throttle_time = 20,
   },
   mapping = {
      ["<PageUp>"] = function()
         for _ = 1, 10 do
            cmp.mapping.select_prev_item()(nil)
         end
      end,
      ["<PageDown>"] = function()
         for _ = 1, 10 do
            cmp.mapping.select_next_item()(nil)
         end
      end,
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = false,
      },
      ['<Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
         else
            fallback()
         end
      end,
      ['<S-Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
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
      { name = "nvim_lsp", group_index = 1},
      { name = "path", group_index = 1},
      { name = "luasnip", group_index = 2 },
      { name = "buffer", group_index = 3 },
      { name = "nvim_lua", group_index = 2 },
   },
   sorting = {
      comparators = {
         cmp.config.compare.recently_used,
         cmp.config.compare.offset,
         cmp.config.compare.score,
         cmp.config.compare.sort_text,
         cmp.config.compare.length,
         cmp.config.compare.order,
      },
   },
   preselect = cmp.PreselectMode.Item,
}
--set max height of items
vim.cmd [[ set pumheight=8 ]]
--set highlights
vim.cmd [[highlight! CmpItemKindText guifg=LightGrey]]
vim.cmd [[highlight! CmpItemKindFunction guifg=#C586C0]]
vim.cmd [[highlight! CmpItemKindClass guifg=Orange]]
vim.cmd [[highlight! CmpItemKindKeyword guifg=#f90c71]]
vim.cmd [[highlight! CmpItemKindSnippet guifg=#565c64]]
vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemKindConstructor guifg=#ae43f0]]
vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#f90c71]]
vim.cmd [[highlight! CmpItemKindFolder guifg=#2986cc]]
vim.cmd [[highlight! CmpItemKindMethod guifg=#C586C0]]
