local handlers = {}

handlers.diagnostic = function()
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

  return {
    handler_name = 'textDocument/publishDiagnostics',
    handler = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      underline = true,
      signs = { active = signs },
      update_in_insert = false,
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
    }),
  }
end

handlers.hover = function()
  return {
    handler_name = 'textDocument/hover',
    handler = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded', focusable = true }
    ),
  }
end

handlers.signature_help = function()
  return {
    handler_name = 'textDocument/signatureHelp',
    handler = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded', focusable = false }
    ),
  }
end

return handlers
