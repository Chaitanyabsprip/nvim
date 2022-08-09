local telescope = require 'plugins.telescope'
return {
  on_attach = function(_)
    local nnoremap = require('mappings').nnoremap
    telescope.lsp_keymaps()
    nnoremap 'gl' '<cmd>lua vim.diagnostic.open_float()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Show current line diagnostics in a floating window'
    nnoremap ']d' '<cmd>lua vim.diagnostic.goto_next()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Go to the next diagnostic'
    nnoremap '[d' '<cmd>lua vim.diagnostic.goto_prev()<cr>' {
      silent = true,
      bufnr = 0,
    } 'Go to the previous diagnostic'
  end,
}
