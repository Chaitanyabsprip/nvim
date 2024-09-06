vim.opt_local.autoindent = true
vim.opt_local.smartindent = false
vim.opt_local.smarttab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.spell = true
vim.opt_local.formatoptions:append 'p'
vim.opt_local.comments = 'n:>'
vim.opt_local.list = true
vim.opt_local.listchars.nbsp = '_'
local formatlistpat = { -- (^\s*\d+[\.)\]}]\s+|^\s*[-*+]\s(\[[x\s]\]\s)?)
    '^\\s*', -- leading whitespace
    -- '\\(', -- start group
    '\\d\\+', -- any number
    -- [[\\\|]], -- or
    -- '[a-zA-Z]', -- letters
    -- '\\)', -- end group
    '[\\.)\\]}]', -- punctuation . ) ] }
    '\\s', -- single whitespace
    [[\\\|]], -- or
    '^\\s*', -- leading whitespace
    '[-\\*+]', -- bullet
    '\\s', -- single whitespace
}
vim.opt_local.formatlistpat = table.concat(formatlistpat, '')

local group = vim.api.nvim_create_augroup('markdown-fold', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
    group = group,
    pattern = '*.md',
    callback = function(event)
        vim.api.nvim_create_autocmd(
            'BufWritePost',
            { group = group, buffer = event.buf, command = '1 foldc' }
        )
    end,
})
