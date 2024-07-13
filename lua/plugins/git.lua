local function is_git_repo()
    local f = io.popen 'git rev-parse --is-inside-work-tree 2>/dev/null'
    local gitOutput = 'false'
    if f ~= nil then
        gitOutput = f:read '*all'
        f:close()
    end
    return gitOutput:match 'true' ~= nil
end

local function setup_keymaps(buffer, gs)
    local function nav_hunk(next)
        return function()
            if vim.wo.diff then return next and ']h' or '[h' end
            vim.schedule(next and gs.next_hunk or gs.prev_hunk)
            return '<Ignore>'
        end
    end
    local function setqflist(target)
        return function()
            vim.g.qf_source = 'git-' .. target
            gs.setqflist(target)
        end
    end
    vim.keymap.set('n', ']h', nav_hunk(true), {
        expr = true,
        buffer = buffer,
        noremap = true,
        desc = 'Git: Jump to next hunk',
    })
    vim.keymap.set('n', '[h', nav_hunk(false), {
        expr = true,
        buffer = buffer,
        noremap = true,
        desc = 'Git: Jump to prev hunk',
    })
    vim.keymap.set({ 'n', 'v' }, ';s', '<cmd>Gitsigns stage_hunk<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Stage hunk',
    })
    vim.keymap.set({ 'n', 'v' }, ';r', '<cmd>Gitsigns reset_hunk<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Reset hunk',
    })
    vim.keymap.set('n', ';S', '<cmd>Gitsigns stage_buffer<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Stage buffer',
    })
    vim.keymap.set('n', ';u', '<cmd>Gitsigns undo_stage_hunk<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Undo stage hunk',
    })
    vim.keymap.set('n', ';d', '<cmd>Gitsigns diffthis<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Diff changes in file',
    })
    vim.keymap.set('n', ';D', '<cmd>Gitsigns diffthis ~<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Diff changes in file against previous commit',
    })
    vim.keymap.set('n', ';q', setqflist 'all', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: show hunks in quickfix',
    })
    vim.keymap.set('n', ';Q', setqflist(0), {
        buffer = buffer,
        noremap = true,
        desc = 'Git: show buffer hunks in quickfix',
    })
    vim.keymap.set('n', ';p', '<cmd>Gitsigns preview_hunk_inline<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Show preview hunk inline',
    })
    vim.keymap.set('n', ';P', '<cmd>Gitsigns preview_hunk<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Show preview hunk hover',
    })
    vim.keymap.set('n', ';td', '<cmd>Gitsigns toggle_deleted<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Toggle view deletion changes',
    })
    vim.keymap.set('n', ';tw', '<cmd>Gitsigns toggle_word_diff<cr>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Toggle view word diff',
    })
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
        buffer = buffer,
        noremap = true,
        desc = 'Git: Select hunk',
    })
end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore'
            )
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        version = '*',
        cond = is_git_repo,
        event = 'BufReadPre',
        cmd = 'GitConflictListQf',
        opts = {
            disable_diagnostics = true,
            highlights = { incoming = 'DiffText', current = 'DiffAdd' },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        cond = is_git_repo,
        event = 'BufReadPre',
        opts = function()
            local group = vim.api.nvim_create_augroup('cgitsigns', { clear = true })
            vim.api.nvim_create_autocmd('Filetype', {
                group = group,
                pattern = 'qf',
                ---@param event {buf: integer}
                callback = function(event)
                    local source = vim.g.qf_source
                    local target = (source == 'git-0' and 0) or (source == 'git-all' and 'all')
                    if target then
                        vim.keymap.set(
                            'n',
                            's',
                            '<cr><cmd>cclose<cr><cmd>Gitsigns stage_hunk<cr><cmd>sleep 100m<cr><cmd>Gitsigns setqflist '
                                .. target
                                .. '<cr>',
                            { buffer = event.buf, desc = 'Git: Stage hunk from qf' }
                        )
                    end
                end,
            })
            local gs = require 'gitsigns'
            return {
                signcolumn = true,
                signs = {
                    add = { text = '▍' },
                    change = { text = '▍' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '▍' },
                    untracked = { text = '▘' },
                },
                on_attach = function(buffer) setup_keymaps(buffer, gs) end,
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 700,
                    ignore_whitespace = false,
                    virt_text = true,
                    virt_text_pos = 'eol',
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
            }
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.code_actions.gitsigns } end
            )
        end,
    },
}
