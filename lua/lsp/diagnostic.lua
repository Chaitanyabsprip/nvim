local M = {}

M.on_attach = function(_)
  local nnoremap = function(key, cmd, silent)
    require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
  end
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

return M
