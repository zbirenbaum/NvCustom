local M = {}

vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

ChadTerms = {horizontal = {}, vertical = {}}


local splits = {
  horizontal = {
    existing = "rightbelow vsplit",
    new = "botright split",
    resize = "resize",
  },
  vertical = {
    existing = "rightbelow split",
    new = "botright vsplit",
    resize = "vertical resize",
  },
}

function M.new_term(direction, exists)
   if not exists then
      vim.cmd(splits[direction]["new"])
   else
      vim.cmd(splits[direction]["existing"])
   end
   local wins = vim.api.nvim_list_wins()
   local term_id = wins[#wins]
   ChadTerms[direction][1] = term_id
   vim.api.nvim_set_current_win(term_id)
   vim.cmd("term")
   vim.api.nvim_input('i')
end

function M.hide_term(direction)
   local term_id = ChadTerms[direction][1]
   if term_id then
      vim.api.nvim_set_current_win(term_id)
      vim.cmd('hide')
   end
end

function M.show_term(direction)
   local term_id = nil
   local prev_wins = vim.api.nvim_list_wins()
   vim.cmd('unhide')
   local new_wins = vim.api.nvim_list_wins()
   for _,v in ipairs(new_wins) do
      if not vim.tbl_contains(prev_wins, v) then
         term_id = v
         ChadTerms[direction][1] = term_id
      end
   end
   if term_id ~= nil then
      vim.api.nvim_set_current_win(term_id)
      vim.api.nvim_input('i')
   else
      require("custom.terminal").new_term(direction)
   end
end

function M.new_or_toggle (direction)
   if (vim.tbl_isempty(ChadTerms[direction]) or not ChadTerms[direction][1]) then
      require("custom.terminal").new_term(direction)
   elseif not vim.tbl_contains(vim.api.nvim_list_wins(), ChadTerms[direction][1]) then
      require("custom.terminal").show_term(direction)
   else
      require("custom.terminal").hide_term(direction)
   end
end


return M

