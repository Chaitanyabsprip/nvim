---@class Capability
---@field name string
---@field callback fun(client: vim.lsp.Client,bufnr: integer)

---@type table<string,Capability|function>
local capabilities = {}
local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
local autocmd = function(event, opts)
    if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
end
local lsp = vim.lsp.buf

capabilities.code_action = {
    name = 'textDocument/codeAction',
    callback = function(_, bufnr)
        vim.keymap.set('n', '<leader>a', require('fastaction').code_action, {
            buffer = bufnr,
            desc = 'Show code actions for the current cursor position',
            noremap = true,
            silent = true,
        })
        vim.keymap.set('v', '<leader>a', require('fastaction').range_code_action, {
            buffer = bufnr,
            desc = 'Show code actions for the current range selection',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.code_lens = {
    name = 'textDocument/codeLens',
    callback = function(_, bufnr)
        vim.keymap.set('n', '<leader>l', vim.lsp.codelens.run, {
            buffer = bufnr,
            desc = 'Run codelens on current line',
            noremap = true,
            silent = true,
        })
        autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
            group = augroup 'lsp_codelens_refresh',
            buffer = bufnr,
            callback = function() vim.lsp.codelens.refresh { bufnr = bufnr } end,
        })
    end,
}

capabilities.declaration = {
    name = 'textDocument/declaration',
    callback = function(_, bufnr)
        vim.keymap.set('n', 'gD', lsp.declaration, {
            buffer = bufnr,
            desc = 'Go to declaration of symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.definition = {
    name = 'textDocument/definition',
    callback = function(_, bufnr)
        vim.keymap.set('n', 'gd', lsp.definition, {
            buffer = bufnr,
            desc = 'Go to definition of symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.document_highlight = {
    name = 'textDocument/documentHighlight',
    callback = function(_, bufnr)
        local hl = vim.api.nvim_set_hl
        local folded = { link = 'Folded' }
        hl(0, 'LspReferenceRead', folded)
        hl(0, 'LspReferenceText', folded)
        hl(0, 'LspReferenceWrite', folded)
        local bold = { bold = true, bg = 'none' }
        hl(0, 'LspReferenceRead', bold)
        hl(0, 'LspReferenceText', bold)
        hl(0, 'LspReferenceWrite', bold)
        autocmd('CursorHold', {
            group = augroup 'lsp_document_highlight',
            buffer = bufnr,
            callback = function() vim.lsp.buf.document_highlight() end,
        })
        autocmd('CursorMoved', {
            group = augroup 'lsp_document_highlight',
            buffer = bufnr,
            callback = function() vim.lsp.buf.clear_references() end,
        })
    end,
}

capabilities.document_symbols = {
    name = 'textDocument/documentSymbol',
    callback = function(_, bufnr)
        vim.keymap.set('n', 'gs', lsp.document_symbol, {
            buffer = bufnr,
            desc = 'View document symbols',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.formatting = {
    name = 'textDocument/formatting',
    callback = function(client, bufnr)
        autocmd('BufWritePre', {
            group = augroup 'auto_format',
            buffer = bufnr,
            callback = function()
                lsp.format {
                    async = false,
                    formatting_options = { tabSize = vim.bo[bufnr].tabstop },
                    id = client.id,
                }
            end,
        })
    end,
}

capabilities.hover = {
    name = 'textDocument/hover',
    callback = function(_, _) end,
}

capabilities.implementation = {
    name = 'textDocument/implementation',
    callback = function(_, bufnr)
        vim.keymap.set('n', 'gi', lsp.implementation, {
            buffer = bufnr,
            desc = 'Show implementations of symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.inlay_hints = {
    name = 'textDocument/inlayHint',
    callback = function(_, bufnr)
        local function toggle_inlay_hints()
            local ihint = vim.lsp.inlay_hint
            ihint.enable(not ihint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
        end
        vim.keymap.set('n', 'gi', toggle_inlay_hints, {
            buffer = bufnr,
            desc = 'Toggle inlay hints',
            noremap = true,
            silent = true,
        })
    end,
}

---@param bufnr integer
---@param mode "v"|"V"
---@return table {start={row,col}, end={row,col}} using (1, 0) indexing
local function range_from_selection(bufnr, mode)
    -- [bufnum, lnum, col, off]; both row and column 1-indexed
    local start = vim.fn.getpos 'v'
    local end_ = vim.fn.getpos '.'
    local start_row = start[2]
    local start_col = start[3]
    local end_row = end_[2]
    local end_col = end_[3]

    -- A user can start visual selection at the end and move backwards
    -- Normalize the range to start < end
    if start_row == end_row and end_col < start_col then
        end_col, start_col = start_col, end_col
    elseif end_row < start_row then
        start_row, end_row = end_row, start_row
    end
    if mode == 'V' then
        start_col = 1
        local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
        end_col = #lines[1]
    end
    return {
        ['start'] = { start_row, start_col - 1 },
        ['end'] = { end_row, end_col - 1 },
    }
end

capabilities.range_formatting = {
    name = 'textDocument/rangeFormatting',
    callback = function(_, bufnr)
        vim.keymap.set('v', 'gf', function()
            lsp.format {
                range = range_from_selection(bufnr, vim.api.nvim_get_mode().mode),
                filter = function(client)
                    return client.supports_method 'textDocument/rangeFormatting'
                end,
                bufnr = bufnr,
            }
        end, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = 'Range code formatting',
        })
    end,
}

capabilities.references = {
    name = 'textDocument/references',
    callback = function(_, bufnr)
        vim.keymap.set('n', 'gr', lsp.references, {
            buffer = bufnr,
            desc = 'Find references of symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.rename = {
    name = 'textDocument/rename',
    callback = function(client, bufnr)
        if client.name == 'dartls' then
            vim.keymap.set('n', 'gR', '<cmd>FlutterRename<cr>', {
                buffer = bufnr,
                desc = 'Flutter: Rename variable and related imports',
                noremap = true,
                silent = true,
            })
        end
        vim.keymap.set('n', 'gR', lsp.rename, {
            buffer = bufnr,
            desc = 'Rename symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

capabilities.signature_help = {
    name = 'textDocument/signatureHelp',
    callback = function(_, bufnr)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, {
            buffer = bufnr,
            noremap = true,
            silent = true,
            desc = 'Show signature help',
        })
    end,
}

capabilities.symbol = {
    name = 'workspace/symbol',
    callback = function(_, bufnr)
        vim.keymap.set(
            'n',
            'gS',
            function() lsp.workspace_symbol(vim.fn.input { prompt = '> Search: ' }) end,
            {
                buffer = bufnr,
                desc = 'View Workspace symbols',
                noremap = true,
                silent = true,
            }
        )
    end,
}

capabilities.type_definition = {
    name = 'textDocument/typeDefinition',
    callback = function(_, bufnr)
        vim.keymap.set('n', '<leader>gnd', lsp.type_definition, {
            buffer = bufnr,
            desc = 'Show type definition of symbol under cursor',
            noremap = true,
            silent = true,
        })
    end,
}

-- calls function for each capability from a capabilities module if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
capabilities.resolve = function(client, bufnr)
    for name, capability in pairs(capabilities) do
        if name ~= 'resolve' and client.supports_method(capability.name) then
            capability.callback(client, bufnr)
        end
    end
end

return capabilities
