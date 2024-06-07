local setup_keymaps = function()
    local hashish = require 'hashish'
    local nnoremap = hashish.nnoremap
    local vnoremap = hashish.vnoremap
    local builtin = require 'fzf-lua'
    nnoremap '<leader>fh'(builtin.helptags) 'Fzf: Help tags'
    nnoremap '<leader>fk'(builtin.keymaps) 'Fzf: Keymaps'
    nnoremap '<leader>fH'(builtin.highlights) 'Fzf: Higlights'
    nnoremap ';b'(builtin.git_branches) 'Fzf: Git Branches'
    nnoremap ';c'(builtin.git_status) 'Fzf: git changes'
    nnoremap '<leader><space>'(builtin.files) 'Fzf: File Finder'
    nnoremap '<leader>fn'(function() builtin.files { cwd = vim.env.NOTESPATH } end) 'Fzf: Find notes'
    nnoremap 'go'(builtin.oldfiles) 'Fzf: oldfiles'
    nnoremap 'gW'(builtin.grep_cword) 'Fzf: grep word under cursor'
    vnoremap 'gw'(builtin.grep_visual) 'Fzf: grep visual selection'
    nnoremap 'gw'(function() builtin.grep { search = vim.fn.input { prompt = 'Grep > ' } } end) 'Fzf: grep and filter'
end
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = { '<leader><leader>', 'gw', 'gW' },
    config = function()
        require('fzf-lua').setup {}
        setup_keymaps()
    end,
}
