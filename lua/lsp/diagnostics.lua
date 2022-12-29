local diagnostics = {}

local get_diagnostics = function(bufnr, severity)
  return function()
    local diagnostic = vim.diagnostic
    local qf_items = diagnostic.toqflist(diagnostic.get(bufnr, { severity = severity }))
    vim.fn.setqflist({}, ' ', { title = 'Diagnostics', items = qf_items })
    if #qf_items > 0 then
      vim.api.nvim_command 'botright copen'
    else
      vim.notify('No diagnostics found in the workspace.', vim.log.levels.INFO)
    end
  end
end

function diagnostics.on_attach(_)
  local nnoremap = require('mappings.hashish').nnoremap
  local opts = { silent = true, bufnr = 0 }
  local workspace_errors = get_diagnostics(nil, vim.diagnostic.severity.ERROR)
  local workspace_warnings = get_diagnostics(nil, vim.diagnostic.severity.WARN)
  local workspace_infos = get_diagnostics(nil, vim.diagnostic.severity.INFO)
  local workspace_hints = get_diagnostics(nil, vim.diagnostic.severity.HINT)
  local document_errors = get_diagnostics(0, vim.diagnostic.severity.ERROR)
  local document_warnings = get_diagnostics(0, vim.diagnostic.severity.WARN)
  local document_infos = get_diagnostics(0, vim.diagnostic.severity.INFO)
  local document_hints = get_diagnostics(0, vim.diagnostic.severity.HINT)
  nnoremap ',D'(get_diagnostics())(opts) 'Enlist all workspace diagnostics in quickfix'
  nnoremap ',d'(get_diagnostics(0))(opts) 'Enlist all workspace diagnostics in quickfix'
  nnoremap ',E'(workspace_errors)(opts) 'Enlist workspace error diagnostics in quickfix'
  nnoremap ',W'(workspace_warnings)(opts) 'Enlist workspace warning diagnostics in quickfix'
  nnoremap ',I'(workspace_infos)(opts) 'Enlist workspace info diagnostics in quickfix'
  nnoremap ',H'(workspace_hints)(opts) 'Enlist workspace hint diagnostics in quickfix'
  nnoremap ',e'(document_errors)(opts) 'Enlist document error diagnostics in quickfix'
  nnoremap ',w'(document_warnings)(opts) 'Enlist document warning diagnostics in quickfix'
  nnoremap ',i'(document_infos)(opts) 'Enlist document info diagnostics in quickfix'
  nnoremap ',h'(document_hints)(opts) 'Enlist document hint diagnostics in quickfix'
  nnoremap ',l'(vim.diagnostic.open_float)(opts) 'Show current line diagnostics in a floating window'
  nnoremap ',n' '<cmd>lua vim.diagnostic.goto_next()<cr>'(opts) 'Go to the next diagnostic'
  nnoremap ',p' '<cmd>lua vim.diagnostic.goto_prev()<cr>'(opts) 'Go to the previous diagnostic'
end

return diagnostics
