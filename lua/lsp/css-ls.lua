local nvim_lsp = require('lspconfig')

nvim_lsp.cssls.setup {
  cmd = {
    "node",
    "/home/chaitanya/.config/nvim/lang-servers/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
    "--stdio"
  },
  capabilities = LSP.capabilities,
  root_dir = require'lspconfig'.util.root_pattern(".git", ".gitignore",
                                                  vim.fn.getcwd()),
  on_attach = LSP.nf_on_attach
}
