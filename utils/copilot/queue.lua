local list = {}
list.__index = list

function list:get_first()
   return #self.list > 0 and 1 or 0
end

function list:get_last()
   return #self.list
end

function list:new ()
   setmetatable(list, self.list)
   self.list = {}
   self.first = self:get_first()
   self.last = self:get_last()
   return self
end

function list:pushright (value)
   table.insert(self.list, value)
   self.first = self:get_first()
   self.last = self:get_last()
end

function list:popleft ()
   local value = table.remove(self.list, self.first)
   self.first = self:get_first()
   self.last = self:get_last()
   return value
end

return list
