---@diagnostic disable: no-unknown
local editing = {}

---@type LazyPluginSpec
editing.bigfiles = {
    'LunarVim/bigfile.nvim',
    event = 'BufReadPre',
    opts = {},
}

---@type LazyPluginSpec
editing.eyeliner = {
    'jinh0/eyeliner.nvim',
    event = 'BufReadPre',
    opts = {
        highlight_on_key = true,
        dim = true,
        disabled_filetypes = { 'fastaction_popup' },
        disabled_buftypes = { 'nofile', 'prompt' },
    },
}

---@type LazyPluginSpec
editing.surround = {
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufReadPre',
    opts = { keymaps = { visual = 's' } },
}

---@type LazyPluginSpec
editing.ufo = {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async', 'luukvbaal/statuscol.nvim' },
    -- keys = {
    --     { 'zc' },
    --     { 'zo' },
    --     { 'zC' },
    --     { 'zO' },
    --     { 'za' },
    --     { 'zA' },
    -- },
    keys = {
        {
            'zR',
            function() require('ufo').openAllFolds() end,
            silent = true,
            noremap = true,
            desc = 'Open all folds',
        },
        {
            'zM',
            function() require('ufo').closeAllFolds() end,
            silent = true,
            noremap = true,
            desc = 'Close all folds',
        },
    },
    config = function(_, opts)
        local nnoremap = require('hashish').nnoremap
        local ufo = require 'ufo'
        ---@type number?
        local fold_win
        local hover = function()
            if fold_win and vim.api.nvim_win_is_valid(fold_win) then
                vim.api.nvim_set_current_win(fold_win)
            end
            fold_win = ufo.peekFoldedLinesUnderCursor()
            if not fold_win then
                vim.lsp.buf.hover()
            else
                vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = fold_win })
                vim.api.nvim_set_option_value('winblend', 0, { win = fold_win })
            end
        end
        require('lsp.capabilities').hover.callback = function(_, bufnr)
            nnoremap 'K'(hover) { bufnr = bufnr, silent = true } 'Show hover info of symbol under cursor'
        end
        local ftMap = { markdown = 'treesitter' }

        ---@param bufnr number
        ---@return Promise
        local function customizeSelector(bufnr)
            local function handleFallbackException(err, providerName)
                if type(err) == 'string' and err:match 'UfoFallbackException' then
                    return require('ufo').getFolds(bufnr, providerName)
                else
                    return require('promise').reject(err)
                end
            end

            return require('ufo')
                .getFolds(bufnr, 'lsp')
                :catch(function(err) return handleFallbackException(err, 'treesitter') end)
                :catch(function(err) return handleFallbackException(err, 'indent') end)
        end
        opts.provider_selector = function(_, filetype, _)
            return ftMap[filetype] or customizeSelector
        end
        ufo.setup(opts)
    end,
    opts = { close_fold_kinds_for_ft = { default = { 'imports', 'comment' } } },
}

editing.spec = {
    editing.eyeliner,
    editing.surround,
    editing.ufo,
}

return editing.spec
