local nvim_lsp = require('lspconfig')

nvim_lsp.pyright.setup {
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  root_dir = require("lspconfig/util").root_pattern(".git/", ".gitignore",
                                                    "setup.py", vim.fn.getcwd()),
  setttings = {
    python = {
      analysis = {diagnosticMode = "workspace", typeCheckingMode = "strict"}
    }
  }
}
