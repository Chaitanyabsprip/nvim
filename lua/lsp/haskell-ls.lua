local nvim_lsp = require "lspconfig"

nvim_lsp.hls.setup({
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  root_dir = require'lspconfig'.util.root_pattern("*.cabal", "stack.yaml", "cabal.project",
                          "package.yaml", "hie.yaml", vim.fn.getcwd(),
                          ".gitignore", ".git")
})
