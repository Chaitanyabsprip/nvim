local nvim_lsp = require 'lspconfig'
local configs = require 'lspconfig/configs'

local M = {}
M.setup = function()
  configs.emmet_ls = {
    default_config = {
      cmd = { 'emmet-ls', '--stdio' },
      filetypes = {
        -- "javascriptreact", "javascript", "typescript", "typescriptreact",
        'html',
        'css',
        'vue',
        'scss',
      },
      root_dir = require('lspconfig').util.root_pattern(
        '.git',
        '.gitignore',
        vim.fn.getcwd()
      ),
      -- settings = {}
    },
  }

  nvim_lsp.emmet_ls.setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
  }
end
return M
