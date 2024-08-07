---@class Capability
---@field name string
---@field callback fun(client: vim.lsp.Client,bufnr: integer)

---@type table<string,Capability|function>
local capabilities = {}
local mappings = require 'hashish'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap
local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
local autocmd = function(event, opts)
    if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
end
local opts = function(bufnr) return { bufnr = bufnr, silent = true } end
local lsp = vim.lsp.buf

capabilities.code_action = {
    name = 'textDocument/codeAction',
    callback = function(_, bufnr)
        nnoremap '<leader>a'(require('fastaction').code_action)(opts(bufnr)) 'Show code actions for the current cursor position'
        vnoremap '<leader>a' '<esc><cmd>lua require("fastaction").range_code_action()<cr>'(
            opts(bufnr)
        ) 'Show code actions for the current selection range'
    end,
}

capabilities.code_lens = {
    name = 'textDocument/codeLens',
    callback = function(_, bufnr)
        nnoremap '<leader>l'(vim.lsp.codelens.run)(opts(bufnr)) 'Run codelens on current line'
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
        nnoremap 'gD'(lsp.declaration)(opts(bufnr)) 'Go to declaration of symbol under cursor'
    end,
}

capabilities.definition = {
    name = 'textDocument/definition',
    callback = function(_, bufnr)
        nnoremap 'gd'(lsp.definition)(opts(bufnr)) 'Go to definition of symbol under cursor'
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
        nnoremap 'gs'(function() lsp.document_symbol() end)(opts(bufnr)) 'View document symbols'
    end,
}

capabilities.formatting = {
    name = 'textDocument/formatting',
    callback = function(client, bufnr)
        autocmd('BufWritePre', {
            group = augroup 'auto_format',
            buffer = bufnr,
            callback = function() lsp.format { async = false, id = client.id } end,
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
        nnoremap 'gi'(lsp.implementation)(opts(bufnr)) 'Show implementations of symbol under cursor'
    end,
}

capabilities.inlay_hints = {
    name = 'textDocument/inlayHint',
    callback = function(_, bufnr)
        local function toggle_inlay_hints()
            local ihint = vim.lsp.inlay_hint
            ihint.enable(not ihint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
        end
        nnoremap 'gti'(toggle_inlay_hints)(opts(bufnr)) 'Toggle inlay hints'
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
        start_col, end_col = end_col, start_col
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
            vim.lsp.buf.format {
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
        nnoremap 'gR'(lsp.references)(opts(bufnr)) 'Find references of symbol under cursor'
    end,
}

capabilities.rename = {
    name = 'textDocument/rename',
    callback = function(client, bufnr)
        if client.name == 'dartls' then
            return nnoremap 'gr' '<cmd>FlutterRename<cr>' { buffer = bufnr } 'Flutter: Rename variable and related imports'
        end
        nnoremap 'gr'(function() vim.ui.input({ prompt = 'Rename: ' }, lsp.rename) end)(opts(bufnr)) 'Rename symbol under cursor'
    end,
}

capabilities.signature_help = {
    name = 'textDocument/signatureHelp',
    callback = function()
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
    end,
}

capabilities.symbol = {
    name = 'workspace/symbol',
    callback = function(_, bufnr)
        nnoremap 'gS'(function() lsp.workspace_symbol(vim.fn.input { prompt = '> Search: ' }) end)(
            opts(bufnr)
        ) 'View Workspace symbols'
    end,
}

capabilities.type_definition = {
    name = 'textDocument/typeDefinition',
    callback = function(_, bufnr)
        nnoremap '<leader>gnd'(lsp.type_definition)(opts(bufnr)) 'Show type definition of symbol under cursor'
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
