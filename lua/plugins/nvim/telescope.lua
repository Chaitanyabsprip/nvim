local nnoremap = require('utils').nnoremap
local actions = require 'telescope.actions'

local mappings = {
  i = {
    ['<c-j>'] = actions.move_selection_next,
    ['<c-k>'] = actions.move_selection_previous,
    ['<esc>'] = actions.close,
  },
  n = {
    ['q'] = actions.close,
    ['<c-c>'] = actions.close,
  },
}

require('telescope').setup {
  defaults = {
    mappings = mappings,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    winblend = 15,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    extensions = {
      file_browser = require('telescope.themes').get_dropdown {
        initial_mode = 'normal',
        -- layout_strategy = 'horizontal',
        layout_config = {
          height = 0.5,
          width = 0.5,
        },
      },
    },
  },
}

local function builtin(picker, theme)
  local builtin_cmd = "require('telescope.builtin')."
  return builtin_cmd .. picker .. theme .. ')'
end

local function ivy(opts)
  local ivy_cmd = "(require('telescope.themes').get_ivy("
  return ivy_cmd .. opts .. ')'
end

local function dropdown(opts)
  local ivy_cmd = "(require('telescope.themes').get_dropdown("
  return ivy_cmd .. opts .. ')'
end

local function telescope_command(command)
  local telescope_cmd = '<cmd>lua '
  return telescope_cmd .. command .. '<CR>'
end

nnoremap('<A-p>', '<cmd>Telescope projects<CR>')
nnoremap(
  '<c-t>dd',
  telescope_command(
    builtin(
      'diagnostics',
      ivy '{layout_config={height=12},bufnr=0, initial_mode="normal"}'
    )
  )
)
nnoremap(
  '<c-t>dw',
  telescope_command(
    builtin(
      'diagnostics',
      ivy '{layout_config={height=12, preview_width = 80 }, initial_mode="normal" }'
    )
  )
)
nnoremap(
  '<leader>tht',
  telescope_command(builtin('help_tags', ivy '{layout_config={height=12}}'))
)
nnoremap(
  '<leader>thk',
  telescope_command(builtin('keymaps', ivy '{layout_config={height=12}}'))
)
nnoremap('<leader>thi', '<cmd>Telescope highlights<CR><ESC>')
