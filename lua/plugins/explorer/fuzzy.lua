---@diagnostic disable: no-unknown
---@type LazySpec
local telescope = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = { 'Telescope' },
    config = function(_, opts) require('telescope').setup(opts) end,
    opts = function()
        local actions = require 'telescope.actions'
        local mappings = {
            i = {
                ['<c-j>'] = actions.move_selection_next,
                ['<c-k>'] = actions.move_selection_previous,
                ['<c-d>'] = actions.delete_buffer,
                ['<esc>'] = actions.close,
            },
            n = { ['q'] = actions.close, ['<c-c>'] = actions.close, ['dd'] = actions.delete_buffer },
        }
        return {
            defaults = {
                border = {
                    prompt = { 1, 1, 1, 1 },
                    results = { 1, 1, 1, 1 },
                    preview = { 1, 1, 1, 1 },
                },
                borderchars = {
                    prompt = { ' ', ' ', '─', '│', '│', ' ', '─', '╰' },
                    results = { '─', ' ', ' ', '│', '╭', '─', ' ', '│' },
                    preview = { '─', '│', '─', '│', '┬', '╮', '╯', '┴' },
                },
                color_devicons = true,
                file_ignore_patterns = { '^.git' },
                -- file_sorter = require('telescope.sorters').get_fuzzy_file,
                -- generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    },
                },
                initial_mode = 'insert',
                layout_config = {
                    horizontal = { mirror = false },
                    vertical = { mirror = false },
                    prompt_position = 'bottom',
                    height = 0.8,
                    width = 0.9,
                },
                layout_strategy = 'horizontal',
                mappings = mappings,
                path_display = { shorten = { len = 1, exclude = { -1 } } },
                prompt_prefix = '▍ ',
                selection_caret = '▍ ',
                selection_strategy = 'reset',
                set_env = { ['COLORTERM'] = 'truecolor' },
                winblend = 0,
            },
        }
    end,
}

return telescope
