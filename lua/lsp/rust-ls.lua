local nvim_lsp = require('lspconfig')

nvim_lsp.rust_analyzer.setup({
  cmd = { 'rust-analyzer' },
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  settings = {
    ['rust_analyzer'] = {
      rustfmt = { enableRangeFormatting = true },
      lens = {
        debug = true,
        enable = true,
        foreCustomCommands = true,
        implementations = true,
        methodReferences = true,
        references = true,
        run = true,
      },
      inlayHints = {
        enable = true,
        chainingHints = true,
        maxLength = 50,
        parameterHints = true,
        smallerHints = true,
        typeHints = true,
      },
      -- hoverActions = {}
    },
  },
  root_dir = require('lspconfig/util').root_pattern(
    'Cargo.toml',
    'rust-project.json',
    '.git/',
    '.gitignore',
    vim.fn.getcwd()
  ),
})
