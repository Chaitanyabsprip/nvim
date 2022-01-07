local lsp_keymaps = require('lsp/lsp-mappings').lsp_keymaps
local lsp_utils = require 'lsp.utils'

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(
    sign.name,
    { texthl = sign.name, text = sign.text, numhl = '' }
  )
end

local config = {
  signs = { active = signs },
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = 'Diagnostics',
    prefix = function(_, i, _)
      return ' ' .. i .. '. '
    end,
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {
  'markdown',
  'plaintext',
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.workspaceWord = true
capabilities.textDocument.completion.completionItem.word = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
  true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

LSP = {}
LSP.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
LSP.common_on_attach = function(client, bufnr)
  lsp_utils.resolve_capabilities(client.resolved_capabilities)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
  require('aerial').on_attach(client, bufnr)
  vim.diagnostic.config(config)
  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = { border = 'single' },
    floating_window = true,
    transparency = 60,
  }, bufnr)
  lsp_keymaps()
end

LSP.nf_on_attach = function(client, bufnr)
  LSP.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

return LSP
