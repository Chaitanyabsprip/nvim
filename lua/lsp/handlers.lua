local handlers = {}

handlers.diagnostic = function()
    local severity = vim.diagnostic.severity
    local signs = {
        [severity.ERROR] = '',
        [severity.WARN] = '',
        [severity.HINT] = '',
        [severity.INFO] = '',
    }

    return {
        name = 'textDocument/publishDiagnostics',
        enabled = true,
        callback = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            underline = true,
            signs = { text = signs },
            update_in_insert = false,
            source = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = true,
                header = 'Diagnostics',
                prefix = function(diagnostic, i, _)
                    return ' ' .. i .. '. ' .. diagnostic.source .. ': '
                end,
            },
        }),
    }
end

handlers.diagnostic_refresh = function()
    return {
        name = 'workspace/diagnostic/refresh',
        callback = function(_, _, ctx)
            local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
            pcall(vim.diagnostic.reset, ns)
            return true
        end,
    }
end

handlers.hover = function()
    return {
        name = 'textDocument/hover',
        enabled = false,
        callback = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', focusable = true }),
    }
end

handlers.signature_help = function()
    return {
        name = 'textDocument/signatureHelp',
        enabled = false,
        callback = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded', focusable = false }
        ),
    }
end

-- applies each handler from a handlers module
-- object name: any
-- object structure:
--     name - string, a handler name in `vim.lsp.handlers` object
--     callback - function, a handler callback
handlers.resolve = function()
    for _, factory in pairs(handlers) do
        if _ ~= 'resolve' then
            local handler = factory()
            if handler.enabled then vim.lsp.handlers[handler.name] = handler.callback end
        end
    end
end

return handlers
