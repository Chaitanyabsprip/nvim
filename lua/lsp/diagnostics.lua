local diagnostics = {}
-- Open folds under the cursor

local function get_qf_diagnostics(bufnr, severity)
  vim.g.d_bufnr = bufnr
  vim.g.d_severity = severity
  local d = vim.diagnostic
  return d.toqflist(d.get(bufnr, { severity = severity }))
end

local function jump_to_location(qf_item)
  local api = vim.api
  local bufnr = qf_item.bufnr
  local win = api.nvim_get_current_win()
  api.nvim_buf_set_option(bufnr, 'buflisted', true)
  api.nvim_win_set_buf(win, bufnr)
  api.nvim_set_current_win(win)
  api.nvim_win_set_cursor(win, { qf_item.lnum, qf_item.col })
  api.nvim_win_call(win, function() vim.cmd 'normal! zv' end) -- Open folds under the cursor
end

local function set_list(items, scope, action)
  action = action or ' '
  if scope == 'Document' then
    vim.fn.setloclist(0, {}, action, { title = scope .. ' Diagnostics', items = items })
    vim.api.nvim_command 'botright lopen'
  else
    vim.fn.setqflist({}, action, { title = scope .. ' Diagnostics', items = items })
    vim.api.nvim_command 'botright copen'
  end
end

local function get_diagnostics(bufnr, severity)
  return function()
    local items = get_qf_diagnostics(bufnr, severity)
    local scope = bufnr and 'Document' or 'Workspace'
    if #items == 0 then
      return vim.notify('No diagnostics found in the ' .. scope, vim.log.levels.INFO)
    end
    if #items == 1 then return jump_to_location(items[1]) end
    vim.g.qf_source = 'diagnostics'
    set_list(items, scope)
    vim.api.nvim_command 'botright copen'
  end
end

function diagnostics.on_attach(_, bufnr)
  local nnoremap = require('hashish').nnoremap
  local opts = { silent = true, bufnr = bufnr }
  local workspace_errors = get_diagnostics(nil, vim.diagnostic.severity.ERROR)
  local workspace_warnings = get_diagnostics(nil, vim.diagnostic.severity.WARN)
  local workspace_infos = get_diagnostics(nil, vim.diagnostic.severity.INFO)
  local workspace_hints = get_diagnostics(nil, vim.diagnostic.severity.HINT)
  local document_errors = get_diagnostics(bufnr, vim.diagnostic.severity.ERROR)
  local document_warnings = get_diagnostics(bufnr, vim.diagnostic.severity.WARN)
  local document_infos = get_diagnostics(bufnr, vim.diagnostic.severity.INFO)
  local document_hints = get_diagnostics(bufnr, vim.diagnostic.severity.HINT)
  nnoremap ',D'(get_diagnostics())(opts) 'Enlist all workspace diagnostics in quickfix'
  nnoremap ',d'(get_diagnostics(bufnr))(opts) 'Enlist all document diagnostics in quickfix'
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

  local group = vim.api.nvim_create_augroup('update_diagnostics', { clear = true })

  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = group,
    callback = require('utils').debounce(300, function()
      if vim.g.qf_source ~= 'diagnostics' then return end
      local qf_items = get_qf_diagnostics(vim.g.d_bufnr, vim.g.d_severity)
      vim.fn.setqflist({}, 'r', { title = 'Diagnostics', items = qf_items })
    end),
  })
end

return diagnostics
