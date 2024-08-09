local lsp = {}

lsp.listLspCapabilities = function()
    local curBuf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = curBuf }

    for _, client in pairs(clients) do
        local capAsList = {}
        for key, value in pairs(client.server_capabilities) do
            if value and key:find 'Provider' then
                local capability = key:gsub('Provider$', '')
                table.insert(capAsList, '- ' .. capability)
            end
        end
        table.sort(capAsList) -- sorts alphabetically
        local msg = '# ' .. client.name .. '\n' .. table.concat(capAsList, '\n')
        vim.notify(msg, vim.log.levels.INFO, {
            on_open = function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
            end,
            timeout = 14000,
        })
    end
end

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
