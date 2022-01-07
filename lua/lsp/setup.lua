local M = {}
local lsp_utils = require 'lsp.utils'
local diagnostic = require 'lsp.diagnostic'
local cmp = require 'cmp_nvim_lsp'

M.capabilities = function(_)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.documentationFormat = {
    'markdown',
    'plaintext',
  }

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.workspaceWord = true
  capabilities.textDocument.completion.completionItem.word = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport =
    true
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
  capabilities = cmp.update_capabilities(capabilities)
  return capabilities
end

M.common_on_attach = function(client, bufnr)
  lsp_utils.resolve_capabilities(client.resolved_capabilities)
  diagnostic.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('aerial').on_attach(client, bufnr)
  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = { border = 'single' },
    floating_window = true,
    transparency = 60,
  }, bufnr)
end

M.nf_on_attach = function(client, bufnr)
  M.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

return M
