local lsp_maps = {}

function lsp_maps.lsp_keymaps()
  local nnoremap = require('utils').nnoremap
  local vnoremap = require('utils').vnoremap

  nnoremap('gh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', true)
  nnoremap(
    '<leader>a',
    '<cmd>lua require("lsp-fastaction").code_action()<cr>',
    true
  )
  vnoremap(
    '<leader>a',
    '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>'
  )
  nnoremap('<leader>gnd', '<cmd>lua vim.lsp.buf.type_definition()<cr>', true)
  nnoremap(
    '<leader>dp',
    "<cmd>lua require('lsp.lsp-ext').peek_definition()<cr>"
  )
  nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<cr>', true)
  nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', true)
  -- nnoremap( 'gR', '<cmd>Trouble lsp_references<cr>', true)
  nnoremap(
    'gR',
    "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({layout_strategy='cursor', layout_config={width=100, height=10}, previewer = false}))<cr>",
    true
  )
  nnoremap('gd', '<cmd>Trouble lsp_definitions<cr>', true)
  nnoremap('gI', '<cmd>Trouble lsp_implementations<cr>zz', true)
  nnoremap('gr', "<cmd>lua require('renamer').rename()<cr>", true)
  nnoremap('<leader>dd', '<cmd>Trouble document_diagnostics<cr>', true)
  nnoremap('<leader>dw', '<cmd>Trouble workspace_diagnostics<cr>', true)
  nnoremap(
    'gl',
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',
    true
  )
  nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', true)
  nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', true)
end

return lsp_maps
