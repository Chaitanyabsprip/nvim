local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap('gh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', true)
end
