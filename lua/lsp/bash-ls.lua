local nvim_lsp = require('lspconfig')

nvim_lsp.bashls.setup {
  cmd = {"bash-language-server"},
  filetypes = {"sh", "zsh", "fish"},
  capabilities = LSP.capabilities,
  on_attach = LSP.common_on_attach
}
