local lsp_maps = {}

function lsp_maps.lsp_keymaps()
  local nnoremap = require('utils').nnoremap

  nnoremap(
    '<leader>dp',
    "<cmd>lua require('lsp.lsp-ext').peek_definition()<cr>"
  )
  nnoremap('<leader>dd', '<cmd>Trouble document_diagnostics<cr>', true)
  nnoremap('<leader>dw', '<cmd>Trouble workspace_diagnostics<cr>', true)
  nnoremap(
    'gl',
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',
    true
  )
  nnoremap(']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', true)
  nnoremap('[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', true)
end

return lsp_maps
