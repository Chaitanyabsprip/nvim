local M = {}
local _ = {}

function M.setup()
    vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'TabLine', { link = 'Normal' })
    local fg = vim.api.nvim_get_hl(0, { name = '@class' }).fg
    local bg = vim.api.nvim_get_hl(0, { name = 'TreesitterContext' }).bg
    vim.api.nvim_set_hl(0, 'TabLineSel', { fg = fg, bg = bg, bold = true })
    _.command()
end

function M.tabline()
    local tabline = ''
    local tabpages = vim.api.nvim_list_tabpages()
    for tab, tabpage in ipairs(tabpages) do
        if tab == vim.fn.tabpagenr() then
            tabline = tabline .. '%#TabLineSel#'
        else
            tabline = tabline .. '%#TabLine#'
        end

        tabline = tabline .. '%' .. tab .. 'T'

        local win = vim.fn.tabpagewinnr(tab)
        local cwd = vim.fn.getcwd(win, tab)
        local project = vim.fn.fnamemodify(cwd, ':t')
        local name = _.get_tab_name(tabpage)
        tabline = tabline .. ' ' .. tab .. ' ' .. (name or project) .. ' '
    end
    tabline = tabline .. '%#TabLineFill#%T'

    if vim.fn.tabpagenr '$' > 1 then tabline = tabline .. '%=%#TabLine#%999X ✕ ' end
    return tabline
end

function _.get_tab_name(tabpage)
    local ok, name = pcall(vim.api.nvim_tabpage_get_var, tabpage, 'tab_name')
    if not ok or type(name) ~= 'string' or name == '' then return nil end
    -- tabline uses statusline syntax; escape %
    return name:gsub('%%', '%%%%')
end

function _.command()
    vim.api.nvim_create_user_command('TabRename', function(opts)
        local new_name = opts.args ~= '' and opts.args or nil
        local current = vim.t.tab_name

        if new_name then
            vim.t.tab_name = new_name
            vim.cmd.redrawtabline()
            return
        end

        vim.ui.input({ prompt = 'Tab name: ', default = current }, function(input)
            if input == nil then return end -- cancelled
            input = vim.trim(input)
            if input == '' then return end -- do nothing

            vim.t.tab_name = input
            vim.cmd.redrawtabline()
        end)
    end, { nargs = '*' })
end
return M
