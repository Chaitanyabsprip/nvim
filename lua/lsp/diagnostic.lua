local M = {}

M.symbols = {
  icons = {
    error = '  ',
    warn = '  ',
    info = '  ',
    hint = '  ',
  },
  no_icons = { error = ' E:', warn = ' W:', info = ' I:', hint = ' H:' },
}

-- M.diagnostics_color = {
--   error = {
--     fg = M.extract_color_from_hllist(
--       'fg',
--       { 'DiagnosticError', 'LspDiagnosticsDefaultError', 'DiffDelete' },
--       '#e32636'
--     ),
--   },
--   warn = {
--     fg = M.extract_color_from_hllist(
--       'fg',
--       { 'DiagnosticWarn', 'LspDiagnosticsDefaultWarning', 'DiffText' },
--       '#ffa500'
--     ),
--   },
--   info = {
--     fg = M.extract_color_from_hllist(
--       'fg',
--       { 'DiagnosticInfo', 'LspDiagnosticsDefaultInformation', 'Normal' },
--       '#ffffff'
--     ),
--   },
--   hint = {
--     fg = M.extract_color_from_hllist(
--       'fg',
--       { 'DiagnosticHint', 'LspDiagnosticsDefaultHint', 'DiffChange' },
--       '#273faf'
--     ),
--   },
-- }

function M.get_diagnostic_count()
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
  return {
    error = error_count,
    warning = warning_count,
    hint = hint_count,
    info = info_count,
    aggregate = aggregate_count,
  }
end

function M.setup_diagnostic_icons(icons)
  local icons = icons or M.symbols.icons
end

function M.get_diagnostic()
  local diagnostic_count = M.get_diagnostic_count()
end

return M
