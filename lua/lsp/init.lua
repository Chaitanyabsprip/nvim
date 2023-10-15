local lsp = {}

lsp.capabilities = function(_)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- for nvim-ufo
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    return capabilities
end

lsp.on_attach = function(client, bufnr)
    require('lsp.diagnostics').on_attach(client, bufnr)
    require('lsp.capabilities').resolve(client, bufnr)
    require('lsp.handlers').resolve()
end

return lsp
