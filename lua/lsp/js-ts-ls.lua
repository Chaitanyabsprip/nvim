local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup {
  on_attach = LSP.nf_on_attach,
  capabilities = LSP.capabilities,
  settings = {documentFormatting = false, documentRangeFormatting = false},
  root_dir = require('lspconfig/util').root_pattern("package.json",
                                                    "tsconfig.json",
                                                    "jsconfig.json", ".git/",
                                                    ".gitignore",
                                                    vim.fn.getcwd())
}
