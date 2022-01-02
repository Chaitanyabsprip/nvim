local nvim_lsp = require 'lspconfig'

local servers = { 'vimls', 'bashls', 'emmet_ls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    root_dir = require('lspconfig').util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
  }
end

vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
