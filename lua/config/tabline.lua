local M = {}

function M.setup()
    vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'TabLine', { link = 'Normal' })
    local fg = vim.api.nvim_get_hl(0, { name = '@class' }).fg
    local bg = vim.api.nvim_get_hl(0, { name = 'TreesitterContext' }).bg
    vim.api.nvim_set_hl(0, 'TabLineSel', { fg = fg, bg = bg, bold = true })
end

function M.tabline()
    local tabline = ''
    for tab = 1, vim.fn.tabpagenr '$' do
        if tab == vim.fn.tabpagenr() then
            tabline = tabline .. '%#TabLineSel#'
        else
            tabline = tabline .. '%#TabLine#'
        end

        tabline = tabline .. '%' .. tab .. 'T'

        local win = vim.fn.tabpagewinnr(tab)
        local cwd = vim.fn.getcwd(win, tab)
        local project = vim.fn.fnamemodify(cwd, ':t')
        tabline = tabline .. ' ' .. tab .. ' ' .. project .. ' '
    end
    tabline = tabline .. '%#TabLineFill#%T'

    if vim.fn.tabpagenr '$' > 1 then tabline = tabline .. '%=%#TabLine#%999X ✕ ' end
    return tabline
end

return M
