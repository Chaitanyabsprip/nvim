local opts = {noremap = true}
local u = require("utils")

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
      '--column', '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}},
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

u.keymap('n', '<leader>fd', '<cmd>Telescope fd<CR>', opts)
u.keymap('n', '<leader>fe', '<cmd>Telescope file_browser<CR><ESC>', opts)
u.keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)

-- Lsp integration with telescope
u.keymap('n', '<leader>gr', '<cmd>Telescope lsp_references<CR><ESC>', opts)
u.keymap('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR><ESC>', opts)
u.keymap('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR><ESC>', opts)
u.keymap('n', '<leader>tdd', '<cmd>Telescope lsp_document_diagnostics<CR><ESC>',
         opts)
u.keymap('n', '<leader>tdw',
         '<cmd>Telescope lsp_workspace_diagnostics<CR><ESC>', opts)

-- Git integration with telescope
u.keymap('n', '<leader>gs', '<cmd>Telescope git_status<CR><ESC>', opts)
u.keymap('n', '<leader>gc', '<cmd>Telescope git_commits<CR><ESC>', opts)
u.keymap('n', '<leader>gb', '<cmd>Telescope git_branches<CR><ESC>', opts)

-- Misc Telescope
u.keymap('n', '<leader>tht', '<cmd>Telescope help_tags<CR>', opts)
u.keymap('n', '<leader>thk', '<cmd>Telescope keymaps<CR>', opts)
u.keymap('n', '<leader>thi', '<cmd>Telescope highlights<CR><ESC>', opts)
