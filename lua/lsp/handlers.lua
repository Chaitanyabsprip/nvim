---@type table<string, fun(): {name: string, enabled: boolean, callback: function}?>
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
        callback = function(...)
            vim.lsp.diagnostic.on_publish_diagnostics(...)
            vim.diagnostic.config {
                underline = true,
                virtual_lines = false,
                virtual_text = false,
                signs = { text = signs },
                float = {
                    border = 'single',
                    source = true,
                    header = 'Diagnostics',
                    severity_sort = true,
                },
                update_in_insert = false,
                severity_sort = true,
            }
        end,
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
        callback = function() vim.lsp.buf.hover { border = 'rounded', focusable = true } end,
    }
end

handlers.signature_help = function()
    return {
        name = 'textDocument/signatureHelp',
        enabled = false,
        callback = function() vim.lsp.buf.signature_help { border = 'rounded', focusable = false } end,
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
            if handler == nil then return end
            if handler.enabled then vim.lsp.handlers[handler.name] = handler.callback end
        end
    end
end

return handlers
