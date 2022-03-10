local function test()
end
local cmd

local hig_unused = function()
   local lsp_data = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
   for _, lsp_datum in ipairs(lsp_data) do
      if
         string.match(string.lower(lsp_datum.user_data.lsp.code), "never read")
         or string.match(string.lower(lsp_datum.user_data.lsp.code), "unused")
      then
         
         highlight_word(dim.ns, lsp_datum.lnum, lsp_datum.col, lsp_datum.end_col)
      end
   end
end

hig_unused()
