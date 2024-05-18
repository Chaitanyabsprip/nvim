---@diagnostic disable: no-unknown
return {
    ---@type LazyPluginSpec
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = { adapters = {} },
        config = function(_, opts)
            if opts.adapters then
                local adapters = {}
                for name, config in pairs(opts.adapters or {}) do
                    if config ~= false then
                        local adapter = require(name)
                        if type(config) == 'table' and not vim.tbl_isempty(config) then
                            local meta = getmetatable(adapter)
                            if adapter.setup then
                                adapter.setup(config)
                            elseif meta and meta.__call then
                                adapter(config)
                            else
                                error('Adapter ' .. name .. ' does not support setup')
                            end
                        end
                        adapters[#adapters + 1] = adapter
                    end
                end
                opts.adapters = adapters
            end
            require('neotest').setup(opts)
        end,
        keys = {
            {
                '<leader>ta',
                function() require('neotest').run.run(vim.fn.expand '%') end,
                desc = 'Test: Run File',
            },
            {
                '<leader>tA',
                function() require('neotest').run.run(vim.uv.cwd()) end,
                desc = 'Test: Run All Test Files',
            },
            {
                '<leader>tt',
                function() require('neotest').run.run() end,
                desc = 'Test: Run Nearest',
            },
            {
                '<leader>tl',
                function() require('neotest').run.run_last() end,
                desc = 'Test: Run Last',
            },
            {
                '<leader>ts',
                function() require('neotest').summary.toggle() end,
                desc = 'Test: Toggle Summary',
            },
            {
                '<leader>to',
                function() require('neotest').output.open { enter = true, auto_close = true } end,
                desc = 'Test: Show Output',
            },
            {
                '<leader>tO',
                function() require('neotest').output_panel.toggle() end,
                desc = 'Test: Toggle Output Panel',
            },
            { '<leader>tS', function() require('neotest').run.stop() end, desc = 'Stop' },
        },
    },
}
