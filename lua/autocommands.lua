return {
  call = function()
    local augroup = function(group)
      vim.api.nvim_create_augroup(group, { clear = true })
    end
    local autocmd = function(event, opts)
      if not opts.disable then
        vim.api.nvim_create_autocmd(event, opts)
      end
    end

    autocmd('BufWritePre', {
      group = augroup 'gofmt',
      pattern = '*.go',
      callback = "require('go.format').goimport()",
      disable = true,
    })

    autocmd('BufReadPost', {
      group = augroup 'resume_edit_position',
      callback = function()
        local line = vim.fn.line
        if
          line '\'"' >= 1
          and line '\'"' <= line '$'
          and vim.bo.filetype ~= 'commit'
        then
          vim.cmd 'normal gv`"zvzz'
        end
      end,
    })

    autocmd('Filetype', {
      pattern = 'startup',
      group = augroup 'startup',
      command = 'setlocal colorcolumn=0',
    })

    autocmd({ 'FocusGained', 'BufEnter', 'CursorHoldI' }, {
      group = augroup 'auto_read',
      callback = function()
        local mode = vim.fn.mode
        local getcmdwintype = vim.fn.getcmdwintype
        if mode() == 'n' and getcmdwintype() == 'quickfix' then
          vim.cmd 'checktime'
        end
      end,
    })

    autocmd('FileChangedShellPost', {
      group = augroup 'auto_read',
      callback = function()
        vim.cmd [[
      echohl WarningMsg
      echo "File changed on disk. Buffer reloaded!"
      echohl None
    ]]
      end,
    })

    autocmd('TextYankPost', {
      group = augroup 'higlight_yank',
      callback = function()
        require('vim.highlight').on_yank {
          higroup = 'Substitute',
          timeout = 500,
          on_macro = true,
        }
      end,
    })

    -- autocmd({
    --   'CursorMoved',
    --   'InsertChange',
    --   'BufEnter',
    --   'BufWinEnter',
    --   'TabEnter',
    --   'BufWritePost',
    -- }, {
    --   group = augroup 'rust_inlay_hints',
    --   pattern = '*.rs',
    --   callback = function()
    --     require('lsp_extensions').inlay_hints {
    --       highlight = 'InlayHints',
    --       prefix = '',
    --       aligned = false,
    --       only_current_line = false,
    --       enabled = { 'TypeHint', 'ChainingHint', 'ParameterHint' },
    --     }
    --   end,
    -- })

    autocmd('BufWritePost', {
      group = augroup 'source_plugins_and_install',
      pattern = '/Users/chaitanyasharma/.config/nvim/lua/plugins/init.lua',
      command = 'source ~/.config/nvim/lua/plugins/init.lua',
    })

    autocmd('ColorScheme', {
      group = augroup 'highlight_current_line_number',
      callback = function()
        vim.cmd [[
      hi clear CursorLine
      hi CursorLineNr guifg=#515980 gui=bold
    ]]
      end,
    })

    autocmd('FileType', {
      group = augroup 'quit_mapping',
      pattern = { 'help', 'lspinfo', 'startuptime', 'qf' },
      command = 'nnoremap <buffer> <silent> q <cmd>close<CR>',
    })

    autocmd('FileType', {
      group = augroup 'markdown_ft',
      pattern = 'markdown',
      command = 'setlocal foldlevel=1 conceallevel=2 spell textwidth=0',
    })

    autocmd('FileType', {
      group = augroup 'drift_ft',
      pattern = 'drift',
      command = 'set ft=sql',
    })

    autocmd('FileType', {
      group = augroup 'flutter_log',
      pattern = 'log',
      command = 'setlocal colorcolumn=0',
    })

    autocmd('TabNewEntered', {
      group = augroup 'tabbed_workspace',
      command = 'Telescope projects',
    })
  end,
}
