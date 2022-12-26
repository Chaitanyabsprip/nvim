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

  autocmd('BufWinLeave', {
    group = augroup 'restore fold state',
    pattern = '*.*',
    command = 'mkview 1',
  })

  autocmd('BufWinEnter', {
    group = augroup 'restore fold state',
    pattern = '*.*',
    command = 'silent! loadview 1',
  })
end

return autocommands
