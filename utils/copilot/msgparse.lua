local log = require("vim.lsp.log")

local function format_message_with_content_length(encoded_message)
  return table.concat {
    'Content-Length: '; tostring(#encoded_message); '\r\n\r\n';
    encoded_message;
  }
end
local function parse_headers(header)
  if type(header) ~= 'string' then
    return nil
  end
  local headers = {}
  for line in vim.gsplit(header, '\r\n', true) do
    if line == '' then
      break
    end
    local key, value = line:match("^%s*(%S+)%s*:%s*(.+)%s*$")
    if key then
      key = key:lower():gsub('%-', '_')
      headers[key] = value
    else
      local _ = log.error() and log.error("invalid header line %q", line)
      error(string.format("invalid header line %q", line))
    end
  end
  headers.content_length = tonumber(headers.content_length)
      or error(string.format("Content-Length not found in headers. %q", header))
  return headers
end

local function request_parser_loop()
  local buffer = '' -- only for header part
  while true do
    -- A message can only be complete if it has a double CRLF and also the full
    -- payload, so first let's check for the CRLFs
    local start, finish = buffer:find('\r\n\r\n', 1, true)
    -- Start parsing the headers
    if start then
      -- This is a workaround for servers sending initial garbage before
      -- sending headers, such as if a bash script sends stdout. It assumes
      -- that we know all of the headers ahead of time. At this moment, the
      -- only valid headers start with "Content-*", so that's the thing we will
      -- be searching for.
      -- TODO(ashkan) I'd like to remove this, but it seems permanent :(
      local buffer_start = buffer:find(header_start_pattern)
      local headers = parse_headers(buffer:sub(buffer_start, start-1))
      local content_length = headers.content_length
      -- Use table instead of just string to buffer the message. It prevents
      -- a ton of strings allocating.
      -- ref. http://www.lua.org/pil/11.6.html
      local body_chunks = {buffer:sub(finish+1)}
      local body_length = #body_chunks[1]
      -- Keep waiting for data until we have enough.
      while body_length < content_length do
        local chunk = coroutine.yield()
            or error("Expected more data for the body. The server may have died.") -- TODO hmm.
        table.insert(body_chunks, chunk)
        body_length = body_length + #chunk
      end
      local last_chunk = body_chunks[#body_chunks]

      body_chunks[#body_chunks] = last_chunk:sub(1, content_length - body_length - 1)
      local rest = ''
      if body_length > content_length then
        rest = last_chunk:sub(content_length - body_length)
      end
      local body = table.concat(body_chunks)
      -- Yield our data.
      buffer = rest..(coroutine.yield(headers, body)
          or error("Expected more data for the body. The server may have died.")) -- TODO hmm.
    else
      -- Get more data since we don't have enough.
      buffer = buffer..(coroutine.yield()
          or error("Expected more data for the header. The server may have died.")) -- TODO hmm.
    end
  end
end
