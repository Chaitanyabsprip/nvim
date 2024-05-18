---@diagnostic disable: no-unknown
local highlight_overrides = function() end

local search_visual_selection = function()
    local search_term = require('utils').get_visual_selection()
    require('telescope.builtin').grep_string { search = search_term }
end

local setup_keymaps = function()
    local hashish = require 'hashish'
    local nnoremap = hashish.nnoremap
    local vnoremap = hashish.vnoremap
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local ivy = themes.get_ivy { layout_config = { height = 12 } }
    local find_notes = function() builtin.fd { cwd = os.getenv 'HOME' .. '/Projects/Notes' } end
    nnoremap '<leader>tht'(function() builtin.help_tags(ivy) end) 'Telescope: Help tags'
    nnoremap '<leader>thk'(function() builtin.keymaps(ivy) end) 'Telescope: Keymaps'
    nnoremap '<leader>thi'(builtin.highlights) 'Telescope: Higlights'
    nnoremap ';b'(builtin.git_branches) 'Telescope: Git Branches'
    nnoremap ';c'(builtin.git_status) 'Telescope: git changes'
    nnoremap '<leader><space>'(function() builtin.fd { hidden = true } end) 'Telescope: File Finder'
    nnoremap '<leader>n'(find_notes) 'Telescope: Find notes'
    nnoremap 'go'(builtin.oldfiles) 'Telescope: oldfiles'
    nnoremap 'gW'(builtin.grep_string) 'Telescope: grep word under cursor'
    vnoremap 'gw'(search_visual_selection) 'Telescope: grep visual selection'
    nnoremap 'gw'(
        function() builtin.grep_string { search = vim.fn.input { prompt = 'Grep > ' } } end
    ) 'Telescope: grep and filter'
end

---@type LazyPluginSpec
local telescope = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = { 'Telescope' },
    keys = { '<leader><leader>', 'gw', 'gW' },
    config = function(_, opts)
        require('telescope').setup(opts)
        setup_keymaps()
        highlight_overrides()
    end,
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
                -- border = 'rounded',
                -- borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
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
