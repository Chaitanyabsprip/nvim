local nvim_lsp = require('lspconfig')

local servers = {'vimls', 'yamlls', 'bashls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    root_dir = require'lspconfig'.util.root_pattern(".git", ".gitignore",
                                                    vim.fn.getcwd())
  }
end

vim.fn.sign_define("LspDiagnosticsSignError", {text = "✘"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
