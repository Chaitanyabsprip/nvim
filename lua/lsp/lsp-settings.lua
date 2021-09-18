local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {"documentation", "detail", "additionalTextEdits"}
}

---@diagnostic disable-next-line: unused-local
local function documentHighlight(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.schedule(function()
      vim.cmd [[
        " hi LspReferenceRead cterm=underline ctermbg=red gui=underline
        " hi LspReferenceText cterm=underline ctermbg=red gui=underline
        " hi LspReferenceWrite cterm=underline ctermbg=red gui=underline
        " hi link LspReferenceRead Folded
        " hi link LspReferenceText Folded
        " hi link LspReferenceWrite Folded
      ]]
    end)
    vim.api.nvim_exec([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
  end
end

local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params,
                             preview_location_callback)
end

LSP = {}
LSP.capabilities = capabilities
LSP.common_on_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                   {update_in_insert = true})
  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {border = "single"},
    floating_window = true,
    transparency = 60
  }, bufnr)
  documentHighlight(client, bufnr)
end
LSP.nf_on_attach = function(client, bufnr)
  LSP.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

-- Mappings
local u = require "utils"
local ntst = {noremap = true, silent = true}

u.kmap("n", "<C-H>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ntst)
u.kmap("n", "<leader>a", '<cmd>lua require("lsp-fastaction").code_action()<CR>',
       ntst)
u.kmap("v", "<leader>a",
       '<esc><cmd>lua require("lsp-fastaction").range_code_action()<CR>', ntst)
u.kmap("n", "<leader>gnd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ntst)
u.kmap("n", "<leader>dp", "<cmd>lua PeekDefinition()<CR>", ntst)
u.kmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", ntst)
u.kmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", ntst)
u.kmap("n", "gR", "<cmd>Trouble lsp_references<CR>", ntst)
u.kmap("n", "gd", "<Cmd>Trouble lsp_definitions<CR>", ntst)
u.kmap("n", "gI", "<cmd>Trouble lsp_implementations<CR>", ntst)
u.kmap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", ntst)
u.kmap("n", "<leader>dd", "<cmd>TroubleToggle lsp_document_diagnostics<CR>",
       ntst)
u.kmap("n", "<leader>dw", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>",
       ntst)
u.kmap("n", "<c-l>", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
       ntst)
u.kmap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", ntst)
u.kmap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", ntst)
vim.cmd(
    'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.lsp.set_log_level("info")
