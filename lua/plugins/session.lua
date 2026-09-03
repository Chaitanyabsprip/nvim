---@diagnostic disable: no-unknown
---@module "lazy"
---@type table<string, LazySpec>
local session = {}

-- Keeps a `Session.vim` file continuously up to date in the cwd whenever
-- nvim is opened on a project (`nvim .`, or bare `nvim`). tmux-resurrect's
-- built-in nvim strategy already looks for exactly that file and runs
-- `nvim -S` instead of a bare `nvim` when it finds one, so this is the only
-- piece needed to make tmux-resurrect/continuum restore nvim buffers, not
-- just a blank nvim.
session.obsession = {
    'tpope/vim-obsession',
    lazy = false,
    config = function()
        vim.api.nvim_create_autocmd('VimEnter', {
            desc = 'auto-track a Session.vim for tmux-resurrect to restore',
            callback = function()
                -- Only "open a project" invocations: bare `nvim` or
                -- `nvim .`/`nvim <dir>`. A single non-directory file arg
                -- (e.g. $EDITOR opening a commit message or crontab -e) is
                -- excluded since it isn't a directory.
                local argc = vim.fn.argc(-1)
                local single_dir_arg = argc == 1
                    and vim.fn.isdirectory(vim.fn.argv(0, -1) --[[@as string]]) == 1
                if argc == 0 or single_dir_arg then vim.cmd.Obsession() end
            end,
        })
    end,
}

session.spec = {
    session.obsession,
}

return session.spec
