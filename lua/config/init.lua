---@diagnostic disable: no-unknown
local config = {}

function config.autocommands()
    local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
    local autocmd = function(event, opts)
        if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
    end

    autocmd('FileType', {
        group = augroup 'quit_mapping',
        pattern = { 'help', 'lspinfo', 'man', 'notify', 'qf', 'startuptime' },
        command = 'nnoremap <buffer> <silent> q <cmd>close<CR>',
    })

    autocmd('TextYankPost', {
        group = augroup 'highlight_yank',
        callback = function()
            require('vim.highlight').on_yank {
                higroup = 'Substitute',
                timeout = 1000,
                on_macro = true,
            }
        end,
    })

    autocmd('BufReadPre', {
        callback = function()
            if vim.bo.filetype == 'oil' then return end
            vim.api.nvim_exec_autocmds('User', { pattern = 'BufReadPreNotOil', modeline = false })
        end,
    })

    local restore_fold = augroup 'restore fold state'
    autocmd('BufWinLeave', { group = restore_fold, pattern = '?*', command = 'mkview 1' })
    autocmd('BufWinEnter', { group = restore_fold, pattern = '?*', command = 'silent! loadview 1' })

    autocmd({ 'FileType' }, {
        group = augroup 'fix_conceal',
        pattern = { 'json', 'jsonc' },
        callback = function()
            vim.wo.spell = false
            vim.wo.conceallevel = 0
        end,
    })

    autocmd('BufWritePre', {
        group = augroup 'eliminate_trailing_spaces',
        pattern = { 'markdown', 'md', 'rmd', 'rst' },
        command = [[%s/\s\+$//]],
    })

    autocmd('BufReadPre', {
        group = augroup 'syntax-and-filetype',
        once = true,
        command = [[
          syntax on
          filetype plugin indent on
        ]],
    })

    autocmd('CmdlineEnter', {
        group = augroup 'auto-disable-search-highlight',
        once = true,
        callback = function() require('search_highlight').setup() end,
    })

    autocmd('LspAttach', {
        group = augroup 'list-lsp-capabilities',
        callback = function()
            vim.api.nvim_create_user_command(
                'LspCapabilities',
                require('lsp').listLspCapabilities,
                {}
            )
        end,
    })

    local function update_lead()
        local lcs = vim.opt_local.listchars:get()
        local tab = vim.fn.str2list(lcs.tab)
        local space = vim.fn.str2list(lcs.multispace or lcs.space)
        local lead = { tab[1] }
        for i = 1, vim.bo.tabstop - 1 do
            lead[#lead + 1] = space[i % #space + 1]
        end
        vim.opt_local.listchars:append { leadmultispace = vim.fn.list2str(lead) }
    end
    autocmd(
        'OptionSet',
        { pattern = { 'listchars', 'tabstop', 'filetype' }, callback = update_lead }
    )
    autocmd('VimEnter', { callback = update_lead, once = true })
end

config.options = {}

function config.disable_builtins()
    vim.cmd [[
    syntax off
    filetype off
  ]]

    vim.g.editorconfig = false

    -- Skip some remote provider loading
    -- vim.g.loaded_python3_provider = 0
    -- vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

config.options.setup = function()
    vim.go.grepprg = 'rg --vimgrep --no-heading --smart-case'
    vim.go.grepformat = '%f:%l:%c:%m'

    vim.o.modeline = false
    vim.opt.termguicolors = true
    vim.o.clipboard = 'unnamedplus'
    vim.o.number = true
    vim.o.numberwidth = 3
    vim.o.relativenumber = true
    vim.o.cursorline = true
    vim.wo.signcolumn = 'yes'

    -- indent
    vim.o.autoindent = true
    vim.o.cindent = true
    vim.o.smarttab = true
    vim.o.expandtab = true
    vim.o.shiftwidth = 4
    vim.o.smartindent = true
    vim.o.softtabstop = 4
    vim.o.tabstop = 4

    -- use undofile over swapfile
    vim.o.undodir = vim.fn.expand '~/.tmp/undodir'
    vim.o.undofile = true
    vim.o.swapfile = false
    vim.o.backup = false
    vim.o.writebackup = false

    -- disable wrap
    vim.wo.wrap = false

    vim.o.cmdheight = 0
    vim.o.scrolloff = 8
    vim.o.colorcolumn = '81'
    vim.o.textwidth = 80
    vim.o.conceallevel = 2
    vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages,globals'
    vim.o.shell = '/usr/bin/env zsh'
    vim.o.updatetime = 1000
    vim.opt.smoothscroll = true
    vim.opt.showmatch = true

    -- split options
    vim.o.splitbelow = true
    vim.o.splitright = true
    vim.o.laststatus = 3

    -- folding
    vim.g.foldcolumn = false
    vim.wo.foldmethod = 'expr'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    -- vim.o.statuscolumn = [[%!v:lua.require'config.statuscolumn'.status_column()]]

    -- search
    vim.o.hlsearch = false
    vim.o.incsearch = true
    vim.o.smartcase = true
    vim.o.ignorecase = true

    -- autocomplete popup
    vim.opt.pumblend = 10
    vim.opt.pumheight = 10

    vim.o.shortmess = 'filnxtToOFIcCs'
    vim.o.whichwrap = ''
    vim.opt.list = true
    vim.opt.listchars =
        { tab = '| ', nbsp = '␣', trail = '•', extends = '⟩', precedes = '⟨', eol = '↲' }
    vim.opt.fillchars =
        { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' }
    vim.opt.showcmdloc = 'statusline'
    config.filetype()
end

function config.filetype()
    vim.filetype.add {
        extension = {
            conf = 'conf',
            env = 'dotenv',
            rasi = 'rasi',
        },
        filename = {
            ['.env'] = 'dotenv',
            ['tsconfig.json'] = 'jsonc',
            ['.yamlfmt'] = 'yaml',
            ['launch.json'] = 'jsonc',
            Appfile = 'ruby',
            Brewfile = 'ruby',
            Fastfile = 'ruby',
            Gemfile = 'ruby',
            Pluginfile = 'ruby',
            Podfile = 'ruby',
        },
        pattern = {
            ['%.env%.[%w_.-]+'] = 'dotenv',
            ['.*/waybar/config'] = 'jsonc',
            ['.*/mako/config'] = 'dosini',
            ['.*/git/config'] = 'git_config',
            ['.*/kitty/*.conf'] = 'bash',
            ['.*/hypr/.*%.conf'] = 'hyprlang',
            ['.*/dockerfiles/.*'] = 'dockerfile',
            ['.*%.conf'] = 'conf',
            ['.*%.theme'] = 'conf',
            ['.*%.gradle'] = 'groovy',
            ['^.env%..*'] = 'bash',
        },
    }
end

function config.lazy()
    require('greeter').setup()
    -- require('utils').open_explorer_on_startup()
end

return config
