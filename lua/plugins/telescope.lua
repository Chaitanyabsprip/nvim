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

u.kmap('n', '<leader>fd', '<cmd>Telescope fd<CR>', opts)
u.kmap('n', '<leader>fe', '<cmd>Telescope file_browser<CR><ESC>', opts)
-- u.kmap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
u.kmap('n', '<A-p>', '<cmd>Telescope projects<CR>', opts)

-- Lsp integration with telescope
u.kmap('n', '<leader>nr', '<cmd>Telescope lsp_references<CR><ESC>', opts)
u.kmap('n', '<leader>nd', '<cmd>Telescope lsp_definitions<CR><ESC>', opts)
u.kmap('n', '<leader>ni', '<cmd>Telescope lsp_implementations<CR><ESC>', opts)
u.kmap('n', '<leader>tdd', '<cmd>Telescope lsp_document_diagnostics<CR><ESC>',
       opts)
u.kmap('n', '<leader>tdw', '<cmd>Telescope lsp_workspace_diagnostics<CR><ESC>',
       opts)

-- Git integration with telescope
-- u.kmap('n', '<leader>gs', '<cmd>Telescope git_status<CR><ESC>', opts)
-- u.kmap('n', '<leader>gc', '<cmd>Telescope git_commits<CR><ESC>', opts)
-- u.kmap('n', '<leader>gb', '<cmd>Telescope git_branches<CR><ESC>', opts)

-- Misc Telescope
u.kmap('n', '<leader>tht', '<cmd>Telescope help_tags<CR>', opts)
u.kmap('n', '<leader>thk', '<cmd>Telescope keymaps<CR>', opts)
u.kmap('n', '<leader>thi', '<cmd>Telescope highlights<CR><ESC>', opts)
