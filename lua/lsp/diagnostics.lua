local diagnostics = {}

function diagnostics.on_attach(_)
  local telescope = require('plugins.explorer').telescope
  local nnoremap = require('mappings.hashish').nnoremap
  telescope.diagnostic_keymaps()
  nnoremap 'sd' '<cmd>lua vim.diagnostic.open_float()<cr>' {
    silent = true,
    bufnr = 0,
  } 'Show current line diagnostics in a floating window'
  nnoremap ',n' '<cmd>lua vim.diagnostic.goto_next()<cr>' {
    silent = true,
    bufnr = 0,
  } 'Go to the next diagnostic'
  nnoremap ',p' '<cmd>lua vim.diagnostic.goto_prev()<cr>' {
    silent = true,
    bufnr = 0,
  } 'Go to the previous diagnostic'
end

return diagnostics
