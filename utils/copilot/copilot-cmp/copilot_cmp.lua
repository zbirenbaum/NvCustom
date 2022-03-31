local source = {}
local function find_copilot()
   clients = vim.tbl_deep_extend(
      vim.lsp.buf_get_clients(vim.api.nvim_get_current_buf()),
      vim.lsp.get_active_clients()
   )
   for client in ipairs(clients) do
      if client.name == "copilot" then
         return client
      end
   end
end

source.new = function(client)
  local self = setmetatable({}, { __index = source })
  self.client = find_copilot()
  self.request_ids = {}
  return self
end

source.get_debug_name = function(self)
  return table.concat({ 'copilot_cmp', self.client.name }, ':')
end

source.is_available = function(self)
   return not self.client.is_stopped() and vim.lsp.buf_get_clients(vim.api.nvim_get_current_buf())[self.client.id]
end

source.get_trigger_characters = function(self)
  return self:_get(self.client.server_capabilities, { 'completionProvider', 'triggerCharacters' }) or {}
end

source.complete = function(self, request, callback)
  local params = vim.lsp.util.make_position_params(0, self.client.offset_encoding)
  self:_request('getCompletions', params, function(_, response)
    callback(table.concat(response), '')
  end)
end

source._get = function(_, root, paths)
  local c = root
  for _, path in ipairs(paths) do
    c = c[path]
    if not c then
      return nil
    end
  end
  return c
end

source._request = function(self, method, params, callback)
  if self.request_ids[method] ~= nil then
    self.client.cancel_request(self.request_ids[method])
    self.request_ids[method] = nil
  end
  local _, request_id
  _, request_id = self.client.request(method, params, function(arg1, arg2, arg3)
    if self.request_ids[method] ~= request_id then
      return
    end
    self.request_ids[method] = nil

    -- Text changed, retry
    if arg1 and arg1.code == -32801 then
      self:_request(method, params, callback)
      return
    end

    if method == arg2 then
      callback(arg1, arg3) -- old signature
    else
      callback(arg1, arg2) -- new signature
    end
  end)
  self.request_ids[method] = request_id
end

return source
