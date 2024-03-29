local plugin = {}

function plugin.bootstrap_packer()
    ---@type string
    local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            lazypath,
        }
        vim.fn.system { 'git', '-C', lazypath, 'checkout', 'tags/stable' } -- last stable release
    end
    vim.opt.runtimepath:prepend(lazypath)
end

plugin.setup = function()
    plugin.bootstrap_packer()
    local disabled_builtins = {
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'editorconfig',
        'gzip',
        'logiPat',
        'man',
        'matchit',
        'matchparen',
        'netrw',
        'netrwFileHandlers',
        'netrwPlugin',
        'netrwSettings',
        'rrhelper',
        'shada_plugin',
        'tar',
        'tarPlugin',
        'tohtml',
        'tutor',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
    }
    local config = require 'config.theme'
    require('lazy').setup({
        { import = 'plugins' },
        { import = 'plugins.ui.themes.' .. config.theme },
        { import = 'plugins.explorer' },
    }, {
        defaults = { lazy = true },
        performance = { rtp = { disabled_plugins = disabled_builtins } },
        install = { colorscheme = { 'habamax' } },
        checker = { enabled = true, notify = false },
        readme = { files = { 'README.md', 'readme.md', 'README.rst', 'readme.rst' } },
    })
end

return plugin
