local M = {}
local lsp_utils = require 'lsp.utils'
local diagnostic = require 'lsp.diagnostic'

M.capabilities = function(_)
  local cmp = require 'cmp_nvim_lsp'
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem.documentationFormat = { 'markdown', 'plaintext' }
  completionItem.snippetSupport = true
  completionItem.workspaceWord = true
  completionItem.word = true
  completionItem.preselectSupport = true
  completionItem.insertReplaceSupport = true
  completionItem.labelDetailsSupport = true
  completionItem.deprecatedSupport = true
  completionItem.commitCharactersSupport = true
  completionItem.tagSupport = { valueSet = { 1 } }
  completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }
  capabilities = cmp.update_capabilities(capabilities)
  return capabilities
end

M.common_on_attach = function(client, bufnr)
  vim.schedule(function()
    lsp_utils.resolve_capabilities(client)
  end)
  diagnostic.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

M.no_formatting_on_attach = function(client, bufnr)
  M.common_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return M
