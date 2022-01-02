local nvim_lsp = require 'lspconfig'

nvim_lsp.yamlls.setup {
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  root_dir = require('lspconfig').util.root_pattern(
    '.git',
    '.gitignore',
    vim.fn.getcwd()
  ),
  settings = {
    redhat = {
      telemetry = false,
    },
    yaml = {
      schemaStore = {
        enable = true,
        url = 'https://www.schemastore.org/api/json/catalog.json',
      },
      format = {
        singleQuote = true,
      },
    },
  },
}
