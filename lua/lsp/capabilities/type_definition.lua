local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap('<leader>gnd', '<cmd>lua vim.lsp.buf.type_definition()<cr>', true)
end
