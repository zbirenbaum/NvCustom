local global_diagnostic_options = {
  signs = true,
  underline = true,
  virtual_text = true,
  float = true,
  update_in_insert = false,
  severity_sort = false,
}


local diagnostic_cache = setmetatable({}, {
  __index = function(t, bufnr)
    assert(bufnr > 0, "Invalid buffer number")
    vim.api.nvim_buf_attach(bufnr, false, {
      on_detach = function()
        rawset(t, bufnr, nil) -- clear cache
      end
    })
    t[bufnr] = {}
    return t[bufnr]
  end,
})

local function get_diagnostics(bufnr, opts, clamp)
  opts = opts or {}

  local namespace = opts.namespace
  local diagnostics = {}

  -- Memoized results of buf_line_count per bufnr
  local buf_line_count = setmetatable({}, {
    __index = function(t, k)
      t[k] = vim.api.nvim_buf_line_count(k)
      return rawget(t, k)
    end,
  })

  ---@private
  local function add(b, d)
    if not opts.lnum or d.lnum == opts.lnum then
      if clamp and vim.api.nvim_buf_is_loaded(b) then
        local line_count = buf_line_count[b] - 1
        if (d.lnum > line_count or d.end_lnum > line_count or d.lnum < 0 or d.end_lnum < 0) then
          d = vim.deepcopy(d)
          d.lnum = math.max(math.min(d.lnum, line_count), 0)
          d.end_lnum = math.max(math.min(d.end_lnum, line_count), 0)
        end
      end
      table.insert(diagnostics, d)
    end
  end

  if namespace == nil and bufnr == nil then
    for b, t in pairs(diagnostic_cache) do
      for _, v in pairs(t) do
        for _, diagnostic in pairs(v) do
          add(b, diagnostic)
        end
      end
    end
  elseif namespace == nil then
    bufnr = get_bufnr(bufnr)
    for iter_namespace in pairs(diagnostic_cache[bufnr]) do
      for _, diagnostic in pairs(diagnostic_cache[bufnr][iter_namespace]) do
        add(bufnr, diagnostic)
      end
    end
  elseif bufnr == nil then
    for b, t in pairs(diagnostic_cache) do
      for _, diagnostic in pairs(t[namespace] or {}) do
        add(b, diagnostic)
      end
    end
  else
    bufnr = get_bufnr(bufnr)
    for _, diagnostic in pairs(diagnostic_cache[bufnr][namespace] or {}) do
      add(bufnr, diagnostic)
    end
  end

  if opts.severity then
    diagnostics = filter_by_severity(opts.severity, diagnostics)
  end

  return diagnostics
end
local function enabled_value(option, namespace)
  local ns = namespace and M.get_namespace(namespace) or {}
  if ns.opts and type(ns.opts[option]) == "table" then
    return ns.opts[option]
  end

  if type(global_diagnostic_options[option]) == "table" then
    return global_diagnostic_options[option]
  end

  return {}
end
---@private
local function resolve_optional_value(option, value, namespace, bufnr)
  if not value then
    return false
  elseif value == true then
    return enabled_value(option, namespace)
  elseif type(value) == 'function' then
    local val = value(namespace, bufnr)
    if val == true then
      return enabled_value(option, namespace)
    else
      return val
    end
  elseif type(value) == 'table' then
    return value
  else
    error("Unexpected option type: " .. vim.inspect(value))
  end
end
local function get_resolved_options(opts, namespace, bufnr)
  local ns = namespace and M.get_namespace(namespace) or {}
  -- Do not use tbl_deep_extend so that an empty table can be used to reset to default values
  local resolved = vim.tbl_extend('keep', opts or {}, ns.opts or {}, global_diagnostic_options)
  for k in pairs(global_diagnostic_options) do
    if resolved[k] ~= nil then
      resolved[k] = resolve_optional_value(k, resolved[k], namespace, bufnr)
    end
  end
  return resolved
end

local function diagnostic_move_pos(opts, pos)
  opts = opts or {}

  local float = vim.F.if_nil(opts.float, true)
  local win_id = opts.win_id or vim.api.nvim_get_current_win()

  if not pos then
    vim.api.nvim_echo({{"No more valid diagnostics to move to", "WarningMsg"}}, true, {})
    return
  end

  vim.api.nvim_win_call(win_id, function()
    -- Save position in the window's jumplist
    vim.cmd("normal! m'")
    vim.api.nvim_win_set_cursor(win_id, {pos[1] + 1, pos[2]})
    -- Open folds under the cursor
    vim.cmd("normal! zv")
  end)

  if float then
    local float_opts = type(float) == "table" and float or {}
    vim.schedule(function()
      M.open_float(
        vim.tbl_extend("keep", float_opts, {
          bufnr = vim.api.nvim_win_get_buf(win_id),
          scope = "cursor",
          focus = false,
        })
      )
    end)
  end
end

function M.open_float(opts, ...)
  -- Support old (bufnr, opts) signature
  local bufnr
  if opts == nil or type(opts) == "number" then
    bufnr = opts
    opts = ...
  else
    vim.validate {
      opts = { opts, 't', true },
    }
  end

  opts = opts or {}
  bufnr = vim.api.get_bufnr(bufnr or opts.bufnr)
  local scope = ({l = "line", c = "cursor", b = "buffer"})[opts.scope] or opts.scope or "line"
  local lnum, col
  if scope == "line" or scope == "cursor" then
    if not opts.pos then
      local pos = vim.api.nvim_win_get_cursor(0)
      lnum = pos[1] - 1
      col = pos[2]
    elseif type(opts.pos) == "number" then
      lnum = opts.pos
    elseif type(opts.pos) == "table" then
      lnum, col = unpack(opts.pos)
    else
      error("Invalid value for option 'pos'")
    end
  elseif scope ~= "buffer" then
    error("Invalid value for option 'scope'")
  end

  do
    -- Resolve options with user settings from vim.diagnostic.config
    -- Unlike the other decoration functions (e.g. set_virtual_text, set_signs, etc.) `open_float`
    -- does not have a dedicated table for configuration options; instead, the options are mixed in
    -- with its `opts` table which also includes "keyword" parameters. So we create a dedicated
    -- options table that inherits missing keys from the global configuration before resolving.
    local t = global_diagnostic_options.float
    local float_opts = vim.tbl_extend("keep", opts, type(t) == "table" and t or {})
    opts = get_resolved_options({ float = float_opts }, nil, bufnr).float
  end

  local diagnostics = get_diagnostics(bufnr, opts, true)

  if scope == "line" then
    diagnostics = vim.tbl_filter(function(d)
      return d.lnum == lnum
    end, diagnostics)
  elseif scope == "cursor" then
    -- LSP servers can send diagnostics with `end_col` past the length of the line
    local line_length = #vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, true)[1]
    diagnostics = vim.tbl_filter(function(d)
      return d.lnum == lnum
        and math.min(d.col, line_length - 1) <= col
        and (d.end_col >= col or d.end_lnum > lnum)
    end, diagnostics)
  end

  if vim.tbl_isempty(diagnostics) then
    return
  end

  local severity_sort = vim.F.if_nil(opts.severity_sort, global_diagnostic_options.severity_sort)
  if severity_sort then
    if type(severity_sort) == "table" and severity_sort.reverse then
      table.sort(diagnostics, function(a, b) return a.severity > b.severity end)
    else
      table.sort(diagnostics, function(a, b) return a.severity < b.severity end)
    end
  end

  local lines = {}
  local highlights = {}
  local header = if_nil(opts.header, "Diagnostics:")
  if header then
    vim.validate { header = { header, function(v)
      return type(v) == "string" or type(v) == "table"
    end, "'string' or 'table'" } }
    if type(header) == "table" then
      -- Don't insert any lines for an empty string
      if string.len(if_nil(header[1], "")) > 0 then
        table.insert(lines, header[1])
        table.insert(highlights, {0, header[2] or "Bold"})
      end
    elseif #header > 0 then
      table.insert(lines, header)
      table.insert(highlights, {0, "Bold"})
    end
  end

  if opts.format then
    diagnostics = reformat_diagnostics(opts.format, diagnostics)
  end

  if opts.source and (opts.source ~= "if_many" or count_sources(bufnr) > 1) then
    diagnostics = prefix_source(diagnostics)
  end

  local prefix_opt = if_nil(opts.prefix, (scope == "cursor" and #diagnostics <= 1) and "" or function(_, i)
      return string.format("%d. ", i)
  end)

  local prefix, prefix_hl_group
  if prefix_opt then
    vim.validate { prefix = { prefix_opt, function(v)
      return type(v) == "string" or type(v) == "table" or type(v) == "function"
    end, "'string' or 'table' or 'function'" } }
    if type(prefix_opt) == "string" then
      prefix, prefix_hl_group = prefix_opt, "NormalFloat"
    elseif type(prefix_opt) == "table" then
      prefix, prefix_hl_group = prefix_opt[1] or "", prefix_opt[2] or "NormalFloat"
    end
  end

  for i, diagnostic in ipairs(diagnostics) do
    if prefix_opt and type(prefix_opt) == "function" then
      prefix, prefix_hl_group = prefix_opt(diagnostic, i, #diagnostics)
      prefix, prefix_hl_group = prefix or "", prefix_hl_group or "NormalFloat"
    end
    local hiname = floating_highlight_map[diagnostic.severity]
    local message_lines = vim.split(diagnostic.message, '\n')
    table.insert(lines, prefix..message_lines[1])
    table.insert(highlights, {#prefix, hiname, prefix_hl_group})
    for j = 2, #message_lines do
      table.insert(lines, string.rep(' ', #prefix) .. message_lines[j])
      table.insert(highlights, {0, hiname})
    end
  end

  -- Used by open_floating_preview to allow the float to be focused
  if not opts.focus_id then
    opts.focus_id = scope
  end
  local float_bufnr, winnr = require('vim.lsp.util').open_floating_preview(lines, 'plaintext', opts)
  for i, hi in ipairs(highlights) do
    local prefixlen, hiname, prefix_hiname = unpack(hi)
    if prefix_hiname then
      vim.api.nvim_buf_add_highlight(float_bufnr, -1, prefix_hiname, i-1, 0, prefixlen)
    end
    vim.api.nvim_buf_add_highlight(float_bufnr, -1, hiname, i-1, prefixlen, -1)
  end

  return float_bufnr, winnr
end
