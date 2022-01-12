return {
  on_attach = function(_)
    local nnoremap = require('mappings').nnoremap
    nnoremap '<leader>dd' '<cmd>Trouble document_diagnostics<cr>' {
      silent = true,
      bufnr = 0,
    } 'Show diagnostics from the focused buffer'
    nnoremap '<leader>dw' '<cmd>Trouble workspace_diagnostics<cr>' {
      silent = true,
      bufnr = 0,
    } 'Show diagnostics from the workspace'
    nnoremap 'gl' '<cmd>lua vim.diagnostic.open_float()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Show current line diagnostics in a floating window'
    nnoremap ']d' '<cmd>lua vim.diagnostic.goto_next()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Go to the next diagnostic'
    nnoremap '[d' '<cmd>lua vim.diagnostic.goto_prev()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Go to the previous diagnostic'
  end,
}
