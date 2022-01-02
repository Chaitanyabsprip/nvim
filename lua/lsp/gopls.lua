local nvim_lsp = require('lspconfig')

nvim_lsp.gopls.setup({
  cmd = { '/home/chaitanya/.config/nvim/lang-servers/gopls/gopls' },
  filetypes = { 'go' },
  settings = {
    gopls = { analyses = { unusedparams = true }, staticcheck = true },
  },
  root_dir = nvim_lsp.util.root_pattern('.git', '.gitignore', 'go.mod', '.'),
  init_options = { usePlaceholders = true, completeUnimported = true },
  on_attach = LSP.common_on_attach,
})
