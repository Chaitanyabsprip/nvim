local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap('gd', '<cmd>Trouble lsp_definitions<cr>', true)
end
