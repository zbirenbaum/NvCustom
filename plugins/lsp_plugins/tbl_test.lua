local function print_tbl_io(tbl1, tbl2, prefix)
   for k,v in pairs(tbl1) do
      if v == tbl1[k] and v ~= nil then
         if not tbl2[k] and tbl1[k] then
            print(prefix .. k)
         elseif type(v) == "table" then
            print_tbl_io(v, tbl2[k], k .. ".")
         end
      else
         print(k)
      end
   end
end
return print_tbl_io
