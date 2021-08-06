local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {"documentation", "detail", "additionalTextEdits"}
}

local function documentHighlight(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
        "hi LspReferenceRead cterm=underline ctermbg=red gui=underline
        "hi LspReferenceText cterm=underline ctermbg=red gui=underline
        "hi LspReferenceWrite cterm=underline ctermbg=red gui=underline
        hi link LspReferenceRead Folded
        hi link LspReferenceText Folded
        hi link LspReferenceWrite Folded
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
    floating_window = false
  })
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

u.keymap("n", "<C-H>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ntst)
u.keymap("n", "<leader>a",
         '<cmd>lua require("lsp-fastaction").code_action()<CR>', ntst)
u.keymap("v", "<leader>a",
         '<esc><cmd>lua require("lsp-fastaction").range_code_action()<CR>', ntst)
u.keymap("n", "<leader>nd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ntst)
u.keymap("n", "<leader>pd", "<cmd>lua PeekDefinition()<CR>", ntst)
u.keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", ntst)
u.keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", ntst)
u.keymap("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", ntst)
u.keymap("n", "gd", "<Cmd>TroubleToggle lsp_definitions<CR>", ntst)
u.keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", ntst)
u.keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", ntst)
u.keymap("n", "<leader>dd", "<cmd>TroubleToggle lsp_document_diagnostics<CR>",
         ntst)
u.keymap("n", "<leader>dw", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>",
         ntst)
u.keymap("n", "<c-l>",
         "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", ntst)
u.keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", ntst)
u.keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", ntst)
vim.cmd(
    'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.lsp.set_log_level("debug")
