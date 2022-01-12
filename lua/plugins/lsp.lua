local M = {}

M.aerial = function()
  require('aerial').setup {
    backends = { 'lsp', 'treesitter', 'markdown' },
    close_behavior = 'auto',
    default_bindings = true,
    default_direction = 'right',
    filter_kind = {
      'Class',
      'Constructor',
      'Enum',
      'Function',
      'Interface',
      'Method',
      'Struct',
      'Variable',
      'Constant',
    },
    highlight_mode = 'split_width',
    highlight_on_jump = 500,
    link_tree_to_folds = false,
    link_folds_to_tree = false,
    manage_folds = false,
    max_width = 60,
    min_width = 30,
    nerd_font = true,
    open_automatic = false,
    placement_editor_edge = true,
    post_jump_cmd = 'normal! zz',
    close_on_select = false,
    float = {
      border = 'rounded',
      row = 1,
      col = 0,
      max_height = 100,
      min_height = 4,
    },
    lsp = {
      diagnostics_trigger_update = true,
      update_when_errors = true,
    },
    treesitter = {
      update_delay = 300,
    },
    markdown = {
      update_delay = 300,
    },
  }
end

M.fastaction = function()
  local fastaction = require 'lsp-fastaction'

  local opts = {
    hide_cursor = true,
    action_data = {
      dart = {
        { order = 1, pattern = 'import library', key = 'i' },
        { order = 1, pattern = 'organize imports', key = 'o' },
        { order = 1, pattern = 'relative imports everywhere', key = 'l' },
        { order = 2, pattern = 'sort member', key = 's' },
        { order = 2, pattern = 'wrap with widget', key = 'w' },
        { order = 3, pattern = 'extract widget', key = 'x' },
        { order = 4, pattern = 'column', key = 'c' },
        { order = 4, pattern = 'extract method', key = 'e' },
        { order = 4, pattern = 'padding', key = 'p' },
        { order = 4, pattern = 'remove', key = 'r' },
        { order = 4, pattern = 'wrap with padding', key = 'p' },
        { order = 5, pattern = 'add', key = 'a' },
        { order = 5, pattern = 'extract local', key = 'v' },
      },
    },
  }

  fastaction.setup(opts)
end

M.trouble = function()
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

  nnoremap('<leader>gt', '<cmd>TodoTelescope<cr>', true)
end

M.renamer = function()
  local mappings_utils = require 'renamer.mappings.utils'
  require('renamer').setup {
    title = 'Rename',
    padding = {
      top = 0,
      left = 0,
      bottom = 0,
      right = 0,
    },
    border = true,
    border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    show_refs = true,
    with_qf_list = false,
    with_popup = true,
    mappings = {
      ['<c-i>'] = mappings_utils.set_cursor_to_start,
      ['<c-a>'] = mappings_utils.set_cursor_to_end,
      ['<c-e>'] = mappings_utils.set_cursor_to_word_end,
      ['<c-b>'] = mappings_utils.set_cursor_to_word_start,
      ['<c-c>'] = mappings_utils.clear_line,
      ['<c-u>'] = mappings_utils.undo,
      ['<c-r>'] = mappings_utils.redo,
    },
    handler = nil,
  }
end

return M
