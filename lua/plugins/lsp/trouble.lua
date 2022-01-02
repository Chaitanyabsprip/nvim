local nnoremap = require('utils').nnoremap

require('trouble').setup {
  position = 'bottom',
  height = 10,
  width = 50,
  icons = true,
  mode = 'document_diagnostics', -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = '',
  fold_closed = '',
  action_keys = { -- key mappings for actions in the trouble list
    close = 'q', -- close the list
    cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
    refresh = 'r', -- manually refresh
    jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
    open_split = { '<c-x>' }, -- open buffer in new split
    open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
    open_tab = { '<c-t>' }, -- open buffer in new tab
    jump_close = { 'o' }, -- jump to the diagnostic and close the list
    toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = 'P', -- toggle auto_preview
    hover = 'K', -- opens a small popup with the full multiline message
    preview = 'p', -- preview the diagnostic location
    close_folds = { 'zM', 'zm', 'h' },
    open_folds = { 'zR', 'zr', 'l' },
    toggle_fold = { 'zA', 'za', 'a' },
    previous = 'k',
    next = 'j',
  },
  indent_lines = true,
  auto_open = false,
  auto_close = true,
  auto_jump = { 'lsp_definitions', 'lsp_implementations' },
  auto_preview = false,
  auto_fold = true,
  signs = {
    error = '',
    warning = '',
    hint = '',
    information = '',
    other = '﫠',
  },
  use_diagnostic_signs = false,
}

nnoremap('<leader>gt', 'TodoTelescope', true)
