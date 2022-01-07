local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', true)
end
