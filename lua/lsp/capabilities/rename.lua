local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap('gr', "<cmd>lua require('renamer').rename()<cr>", true)
end
