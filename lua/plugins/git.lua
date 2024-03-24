local git = {}

local hash = require 'hashish'
local nnoremap = hash.nnoremap
local noremap = hash.noremap

local function is_git_repo()
    local f = io.popen 'git rev-parse --is-inside-work-tree 2>/dev/null'
    local gitOutput = 'false'
    if f ~= nil then
        gitOutput = f:read '*all'
        f:close()
    end
    return gitOutput:match 'true' ~= nil
end

local function setup_keymaps(bufnr, gs)
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
    nnoremap ']h'(nav_hunk(true)) { expr = true, bufnr = bufnr } 'Git: Jump to next hunk'
    nnoremap '[h'(nav_hunk(false)) { expr = true, bufnr = bufnr } 'Git: Jump to prev hunk'
    noremap { 'n', 'v' } ';s' '<cmd>Gitsigns stage_hunk<cr>' { bufnr = bufnr } 'Git: Stage hunk'
    noremap { 'n', 'v' } ';r' '<cmd>Gitsigns reset_hunk<cr>' { bufnr = bufnr } 'Git: Reset hunk'
    nnoremap ';S' '<cmd>Gitsigns stage_buffer<cr>' { bufnr = bufnr } 'Git: Stage buffer'
    nnoremap ';u' '<cmd>Gitsigns undo_stage_hunk<cr>' { bufnr = bufnr } 'Git: Undo stage hunk'
    nnoremap ';d' '<cmd>Gitsigns diffthis<cr>' { bufnr = bufnr } 'Git: Diff changes in file'
    nnoremap ';D' '<cmd>Gitsigns diffthis ~<cr>' { bufnr = bufnr } 'Git: Diff changes in file against previous commit'
    nnoremap ';p' '<cmd>Gitsigns preview_hunk_inline<cr>' { bufnr = bufnr } 'Git: Preview hunk inline'
    nnoremap ';P' '<cmd>Gitsigns preview_hunk<cr>' { bufnr = bufnr } 'Git: Preview hunk hover'
    nnoremap ';td' '<cmd>Gitsigns toggle_deleted<cr>' { bufnr = bufnr } 'Git: Toggle view deletion changes'
    nnoremap ';tw' '<cmd>Gitsigns toggle_word_diff<cr>' { bufnr = bufnr } 'Git: Toggle view word diff'
    nnoremap ';Q'(setqflist 'all') { bufnr = bufnr } 'Git: show hunks in quickfix'
    nnoremap ';q'(setqflist(0)) { bufnr = bufnr } 'Git: show buffer hunks in quickfix'
    noremap { 'o', 'x' } 'ih' ':<C-U>Gitsigns select_hunk<CR>' { bufnr = bufnr } 'Git: Select hunk'
end

git.gitsigns = {
    'lewis6991/gitsigns.nvim',
    cond = is_git_repo,
    event = 'BufReadPre',
    opts = function()
        local signs = { add = 'Add', change = 'Change', delete = 'Delete' }
        ---@param sign string
        ---@param text string|nil
        ---@return table<string, string>
        local sign = function(sign, text)
            text = text or '▍'
            local hl = 'GitSigns' .. sign
            return { text = text, hl = hl, numhl = hl .. 'Nr', linehl = hl .. 'Ln' }
        end
        local group = vim.api.nvim_create_augroup('cgitsigns', { clear = true })
        vim.api.nvim_create_autocmd('Filetype', {
            group = group,
            pattern = 'qf',
            ---@param event {buf: integer}
            callback = function(event)
                local source = vim.g.qf_source
                local target = (source == 'git-0' and 0) or (source == 'git-all' and 'all')
                if target then
                    nnoremap 's'(
                        '<cr><cmd>cclose<cr><cmd>Gitsigns stage_hunk<cr><cmd>sleep 100m<cr><cmd>Gitsigns setqflist '
                            .. target
                            .. '<cr>'
                    ) {
                        bufnr = event.buf,
                    } 'Git: Stage hunk from qf'
                end
            end,
        })
        local gs = require 'gitsigns'
        return {
            signcolumn = true,
            signs = {
                add = sign(signs.add),
                change = sign(signs.change),
                delete = sign(signs.delete, '_'),
                topdelete = sign(signs.delete, '‾'),
                changedelete = sign(signs.change),
                untracked = sign(signs.add, '▘'),
            },
            on_attach = function(bufnr) setup_keymaps(bufnr, gs) end,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 700,
                ignore_whitespace = false,
                virt_text = true,
                virt_text_pos = 'eol',
            },
            current_line_blame_formatter_opts = { relative_time = true },
        }
    end,
}

git.git_conflict = {
    'akinsho/git-conflict.nvim',
    version = '*',
    cond = is_git_repo,
    event = 'BufReadPre',
    cmd = 'GitConflictListQf',
    opts = {
        disable_diagnostics = true,
        highlights = { incoming = 'DiffText', current = 'DiffAdd' },
    },
}

git.spec = {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
            })
        end,
    },
    git.git_conflict,
    git.gitsigns,
}

return git.spec
