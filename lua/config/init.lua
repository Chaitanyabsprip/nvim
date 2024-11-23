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

function config.disable_builtins()
    vim.cmd [[
    syntax off
    filetype off
  ]]

    -- Skip some remote provider loading
    -- vim.g.loaded_python3_provider = 0
    -- vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

config.setup = function()
    -- moving around, searching and patterns
    vim.o.startofline = false
    vim.o.incsearch = true
    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.o.whichwrap = ''

    -- displaying text
    vim.o.scroll = 12 -- number of lines to scroll for CTRL-U and CTRL-D
    vim.o.smoothscroll = false
    vim.o.scrolloff = 8
    vim.o.wrap = false
    vim.opt.fillchars =
        { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' }
    vim.o.cmdheight = 0
    vim.o.lazyredraw = false -- don't redraw while executing macros
    vim.o.redrawtime = 600 -- timeout for 'hlsearch' and :match highlighting in msec
    vim.opt.list = true -- show <Tab> as ^I and end-of-line as $
    vim.opt.listchars =
        { tab = '| ', nbsp = '␣', trail = '•', extends = '⟩', precedes = '⟨', eol = '↲' }
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.numberwidth = 3
    vim.o.conceallevel = 2

    -- syntax, highlighting and spelling
    vim.o.background = 'dark'
    vim.o.hlsearch = false
    vim.o.termguicolors = true
    vim.o.cursorline = true
    vim.opt.cursorlineopt = { 'both' }
    vim.o.colorcolumn = '81'

    local rulerformat = '%=%c|%l [%P]'
    -- multiple windows
    vim.o.laststatus = 3
    -- vim.o.statuscolumn = [[%!v:lua.require'config.statuscolumn'.status_column()]]
    vim.o.statusline = string.format(' %s%s ', '%f', rulerformat)
    vim.o.splitbelow = true
    vim.o.splitright = true

    -- multiple tab pages
    vim.go.tabline = [[%!v:lua.require'config.tabline'.tabline()]]

    -- messages and info
    vim.o.shortmess = 'filnxtToOFIcCs'
    vim.opt.showcmdloc = 'statusline'
    vim.o.ruler = true
    vim.o.rulerformat = rulerformat

    -- selecting text
    vim.o.clipboard = 'unnamedplus'

    -- editing text
    vim.o.undofile = true
    vim.o.undodir = vim.fn.expand '~/.tmp/undodir'
    vim.o.textwidth = 72
    vim.opt.pumheight = 10
    vim.opt.showmatch = true

    -- tabs and indenting
    vim.o.tabstop = 8
    vim.o.expandtab = true
    vim.o.smarttab = true
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.o.autoindent = true
    vim.o.smartindent = true

    -- folding
    vim.g.foldcolumn = false -- this is a custom option
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldmethod = 'expr'

    -- diff mode
    vim.opt.diffopt =
        { 'internal', 'filler', 'closeoff', 'algorithm:histogram', 'indent-heuristic' }

    -- reading and writing files
    vim.o.modeline = false
    vim.o.backup = false
    vim.o.writebackup = false

    -- the swap file
    vim.o.swapfile = false
    vim.o.updatetime = 1000

    -- executing external commands
    vim.o.shell = '/usr/bin/env zsh'

    -- running make and jumping to errors (quickfix)
    vim.go.grepprg = 'rg --vimgrep --no-heading --smart-case --multiline'

    -- various
    vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages,globals'
    vim.wo.signcolumn = 'yes'

    vim.opt.pumblend = 10

    -- sql plugin opts
    vim.g.ftplugin_sql_omni_key = '<c-a>'
end

config.commands = function()
    vim.api.nvim_create_user_command(
        'Vnew',
        'vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile',
        {}
    )
    vim.api.nvim_create_user_command(
        'New',
        'new | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile',
        {}
    )
end

function config.lazy()
    config.autocommands()
    config.commands()
    require('greeter').setup()
    require('config.tabline').setup()
    -- require('utils').open_explorer_on_startup()
end

return config
