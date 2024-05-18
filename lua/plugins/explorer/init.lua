local explorer = {}

---@type LazyPluginSpec
explorer.better_qf = {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    dependencies = { 'yorickpeterse/nvim-pqf' },
    opts = {
        auto_resize_height = true,
        func_map = { open = 'o', openc = '<cr>' },
    },
}

---@type LazyPluginSpec
explorer.harpoon2 = {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<c-b>',
            function() require('harpoon'):list():add() end,
            noremap = true,
            desc = 'Add file to harpoon',
        },
        {
            '<c-f>',
            function()
                local harpoon = require 'harpoon'
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            noremap = true,
            desc = 'Toggle harpoon marks list',
        },
        {
            '<c-n>',
            function() require('harpoon'):list():select(1) end,
            noremap = true,
            desc = 'Jump to file 1 in harpoon',
        },
        {
            '<c-e>',
            function() require('harpoon'):list():select(2) end,
            noremap = true,
            desc = 'Jump to file 2 in harpoon',
        },
        {
            '<c-o>',
            function() require('harpoon'):list():select(3) end,
            noremap = true,
            desc = 'Jump to file 3 in harpoon',
        },
        {
            '<c-s>',
            function() require('harpoon'):list():select(4) end,
            noremap = true,
            desc = 'Jump to file 4 in harpoon',
        },
    },
    config = function()
        local harpoon = require 'harpoon'
        harpoon:setup { settings = { save_on_toggle = true, sync_on_ui_close = true } }
        harpoon:extend {
            UI_CREATE = function(cx)
                vim.keymap.set(
                    'n',
                    '<C-v>',
                    function() harpoon.ui:select_menu_item { vsplit = true } end,
                    { buffer = cx.bufnr }
                )

                vim.keymap.set(
                    'n',
                    '<C-x>',
                    function() harpoon.ui:select_menu_item { split = true } end,
                    { buffer = cx.bufnr }
                )

                vim.keymap.set(
                    'n',
                    '<C-t>',
                    function() harpoon.ui:select_menu_item { tabedit = true } end,
                    { buffer = cx.bufnr }
                )
            end,
        }
        -- -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
        -- vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)
    end,
}

---@type LazyPluginSpec
explorer.oil = {
    'stevearc/oil.nvim',
    lazy = (function()
        if vim.fn.argc() < 1 or vim.fn.argc() > 1 then return end
        ---@type string
        local path = require('utils').getargs()[1]
        local directory = vim.fn.isdirectory(path) == 1
        return not directory
    end)(),
    cmd = { 'Oil', 'Explorer' },
    opts = function()
        vim.api.nvim_create_user_command('Explorer', function()
            if vim.bo[vim.api.nvim_win_get_buf(0)].filetype == 'oil' then
                require('oil').close()
            else
                return require('oil').open()
            end
        end, { nargs = 0 })
        return {
            default_file_explorer = true,
            columns = { 'icon', 'permissions' }, -- See :help oil-columns
            buf_options = { buflisted = false, bufhidden = 'hide' },
            win_options = {
                wrap = false,
                signcolumn = 'no',
                cursorcolumn = false,
                foldcolumn = '0',
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = 'nvic',
            },
            delete_to_trash = false,
            skip_confirm_for_simple_edits = false, -- Skip the confirmation popup for simple operations
            trash_command = 'trash', -- Change this to customize the command used when deleting to trash
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            keymaps = { -- See :help oil-actions for a list of all available actions
                ['g?'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['L'] = 'actions.select',
                ['s'] = 'actions.select_split',
                ['S'] = 'actions.select_vsplit',
                ['<C-t>'] = 'actions.select_tab',
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['q'] = 'actions.close',
                ['<C-l>'] = 'actions.refresh',
                ['H'] = 'actions.parent',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                ['~'] = 'actions.tcd',
                ['gs'] = 'actions.change_sort',
                ['g.'] = 'actions.toggle_hidden',
            },
            use_default_keymaps = false, -- Set to false to disable all of the above keymaps
            view_options = {
                show_hidden = true, -- Show files and directories that start with "."
                is_hidden_file = function(name, _) return vim.startswith(name, '.') end,
                is_always_hidden = function(_, _) return false end,
                sort = { { 'type', 'asc' }, { 'name', 'asc' } }, -- see :help oil-columns to see sortable cols
            },
            float = {
                padding = 1,
                max_width = 50,
                max_height = 20,
                border = 'rounded',
                win_options = { winblend = 0 },
                override = function(conf)
                    local HEIGHT_RATIO = 0.9
                    local WIDTH_RATIO = 0.3
                    local screen_w = vim.opt.columns:get()
                    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                    local window_w = screen_w * WIDTH_RATIO
                    local window_h = screen_h * HEIGHT_RATIO
                    local window_w_int = math.floor(window_w)
                    local window_h_int = math.floor(window_h)
                    local center_x = (screen_w - window_w - (screen_w * 0.03))
                    local center_y = ((vim.opt.lines:get() - window_h) / 2)
                        - vim.opt.cmdheight:get()
                    conf.row = center_y
                    conf.col = center_x
                    conf.width = window_w_int
                    conf.height = window_h_int
                    return conf
                end,
            },
            preview = {
                max_width = { 80, 0.6 },
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 30, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = 'rounded',
                win_options = { winblend = 0 },
            },
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = 'rounded',
                minimized_border = 'none',
                win_options = { winblend = 0 },
            },
        }
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}

---@type LazyPluginSpec
explorer.pretty_qf = {
    'yorickpeterse/nvim-pqf',
    event = 'Filetype qf',
    opts = {},
}

---@type LazyPluginSpec
explorer.cartographer = {
    -- 'Chaitanyabsprip/cartographer',
    url = os.getenv 'HOME' .. '/projects/cartographer',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'go build -o bin/cartographer; cp -r cartographer.nvim/lua .',
    enabled = false,
    event = 'VeryLazy',
    opts = { python_path = '/home/chaitanya/projects/cartographer/.venv/bin' },
    config = function(_, opts) require('cartographer').setup(opts) end,
}

explorer.spec = {
    explorer.better_qf,
    explorer.harpoon2,
    explorer.oil,
    explorer.pretty_qf,
    explorer.cartographer,
}

return explorer.spec
