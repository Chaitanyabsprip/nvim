local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  -- nnoremap( 'gR', '<cmd>Trouble lsp_references<cr>', true)
  nnoremap(
    'gR',
    "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({layout_strategy='cursor', layout_config={width=100, height=10}, previewer = false}))<cr>",
    true
  )
end
