local lsp = {}
local lsp_utils = require 'lsp.utils'
local diagnostic = require 'lsp.diagnostics'

lsp.capabilities = function(_)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  -- local completionItem = capabilities.textDocument.completion.completionItem
  -- completionItem.documentationFormat = { 'markdown', 'plaintext' }
  -- completionItem.snippetSupport = true
  -- completionItem.workspaceWord = true
  -- completionItem.word = true
  -- completionItem.preselectSupport = true
  -- completionItem.insertReplaceSupport = true
  -- completionItem.labelDetailsSupport = true
  -- completionItem.deprecatedSupport = true
  -- completionItem.commitCharactersSupport = true
  -- completionItem.tagSupport = { valueSet = { 1 } }
  -- completionItem.resolveSupport = {
  --   properties = { 'documentation', 'detail', 'additionalTextEdits' },
  -- }
  return capabilities
end

lsp.common_on_attach = function(client, _)
  lsp_utils.resolve_capabilities(client)
  diagnostic.on_attach(client)
  require('lsp.utils').resolve_handlers()
end

lsp.no_formatting_on_attach = function(client, bufnr)
  lsp.common_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return lsp
