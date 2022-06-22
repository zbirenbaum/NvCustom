
  }, {
    name = "DiagnosticSignError",
    numhl = "DiagnosticSignError",
    text = " ",
    texthl = "DiagnosticSignError"
  }, {
    name = "DiagnosticSignInfo",
    numhl = "DiagnosticSignInfo",
    text = " ",
    texthl = "DiagnosticSignInfo"
  }, {
    name = "DiagnosticSignHint",
    numhl = "DiagnosticSignHint",
    text = " ",
    texthl = "DiagnosticSignHint"
  }, {
    name = "DiagnosticSignWarn",
    numhl = "DiagnosticSignWarn",
    text = " ",
    texthl = "DiagnosticSignWarn"
  } }
  show = function(namespace, bufnr, diagnostics, opts)
    vim.validate({
      namespace = { namespace, 'n' },
      bufnr = { bufnr, 'n' },
      diagnostics = {
        diagnostics,
        vim.tbl_islist,
        'a list of diagnostics',
      },
      opts = { opts, 't', true },
    })

    bufnr = get_bufnr(bufnr)
    opts = opts or {}

    if opts.signs and opts.signs.severity then
      diagnostics = filter_by_severity(opts.signs.severity, diagnostics)
    end
