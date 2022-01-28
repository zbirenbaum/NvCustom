local function print_tbl_io(tbl, file, callnumber)
   io.output(file)
   if not callnumber then callnumber = 0 end
   local spacer = ""
   for i=0,callnumber,1 do
      spacer=spacer .. " "
   end
   for k,v in pairs(tbl) do
      io.write(spacer .. k .. " = {\n")
      if type(v) == "table" then
         print_tbl_io(v, file, callnumber+1)
      else
         if type(v) == "boolean" then io.write(v and spacer .. ' true\n' or spacer .. ' false\n')
         else io.write(spacer .. " " .. v .. "\n")
         end
      end
      io.write(spacer .. "}\n")
   end
end

local function print_tbl(tbl, filename)
   local file = io.open(filename, "a+")
   print_tbl_io(tbl,file)
   io.close(file)
end

return print_tbl
