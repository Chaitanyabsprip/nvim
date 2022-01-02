local nvim_lsp = require 'lspconfig'

local M = {}

M.setup = function()
  nvim_lsp.clangd.setup {
    cmd = {
      'clangd',
      -- "--background-index"
    },
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
  }
end

return M
