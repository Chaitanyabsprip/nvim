local autocommands = {}

autocommands.setup = function()
  local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
  local autocmd = function(event, opts)
    if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
  end

  autocmd('FileType', {
    group = augroup 'quit_mapping',
    pattern = { 'help', 'lspinfo', 'man', 'notify', 'qf', 'startuptime' },
    command = 'nnoremap <buffer> <silent> q <cmd>close<CR>',
  })

  autocmd('TextYankPost', {
    group = augroup 'higlight_yank',
    callback = function()
      require('vim.highlight').on_yank { higroup = 'Substitute', timeout = 500, on_macro = true }
    end,
  })

  local restore_fold = augroup 'restore fold state'
  autocmd('BufWinLeave', { group = restore_fold, pattern = '*.*', command = 'mkview 1' })
  autocmd('BufWinEnter', { group = restore_fold, pattern = '*.*', command = 'silent! loadview 1' })

  local diagnostics = augroup 'diagnostics'
  autocmd('InsertEnter', { group = diagnostics, callback = function() vim.diagnostic.hide() end })
  autocmd('InsertLeave', { group = diagnostics, callback = function() vim.diagnostic.show() end })
end

return autocommands
