local M = {}
local diagnostic_count = {}
diagnostic_count.error = 0
diagnostic_count.warn = 0
diagnostic_count.info = 0
diagnostic_count.hint = 0
diagnostic_count.aggregate = 0

M.symbols = {
  icons = {
    error = '',
    warn = '',
    info = '',
    hint = '',
    aggregate = '#',
  },
  no_icons = {
    error = ' E:',
    warn = ' W:',
    info = ' I:',
    hint = ' H:',
    aggregate = '#:',
  },
}

M.decals = {
  error = {
    icon = '',
    hl = 'DiagnosticError',
  },
  warn = {
    icon = '',
    hl = 'DiagnosticWarn',
  },
  info = {
    icon = '',
    hl = 'DiagnosticInfo',
  },
  hint = {
    icon = '',
    hl = 'DiagnosticHint',
  },
  aggregate = {
    icon = '#',
    hl = 'DiagnosticWarn',
  },
}

M.get_diagnostic_component = function(severity)
  return {
    function()
      return M.get_diagnostic_count()[severity]
    end,
    cond = function()
      return diagnostic_count[severity] > 0
    end,
    icon = M.decals[severity].icon,
    color = M.decals[severity].hl,
  }
end

M.get_diagnostic_count = function()
  local diagnostics = vim.diagnostic.get()
  local count = { 0, 0, 0, 0 }
  for _, diagnostic in ipairs(diagnostics) do
    count[diagnostic.severity] = count[diagnostic.severity] + 1
  end
  local error_count = count[vim.diagnostic.severity.ERROR] or 0
  local warning_count = count[vim.diagnostic.severity.WARNING] or 0
  local hint_count = count[vim.diagnostic.severity.HINT] or 0
  local info_count = count[vim.diagnostic.severity.INFO] or 0
  local aggregate_count = error_count + warning_count + hint_count + info_count
  diagnostic_count = {
    error = error_count,
    warn = warning_count,
    hint = hint_count,
    info = info_count,
    aggregate = aggregate_count,
  }
  return diagnostic_count
end

M.should_show_diagnostic = function(diagnostic)
  return diagnostic_count[diagnostic] > 0
end

return M
