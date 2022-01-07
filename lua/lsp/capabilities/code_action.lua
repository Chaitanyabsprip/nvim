local nnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'n', key, cmd, { noremap = true, silent = silent })
end
local vnoremap = function(key, cmd, silent)
  require('utils').bmap(0, 'v', key, cmd, { noremap = true, silent = silent })
end

return function(_)
  nnoremap(
    '<leader>a',
    '<cmd>lua require("lsp-fastaction").code_action()<cr>',
    true
  )
  vnoremap(
    '<leader>a',
    '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>'
  )
end
