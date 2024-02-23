local extend = require('plugins.lsp').extend

local function htmlls(lspconfig)
    local config = extend {
        filetypes = {
            'html',
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
    }
    lspconfig.html.setup(config)
end

local function emmetls(lspconfig)
    local config = extend {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        init_options = { html = { options = { ['bem.enabled'] = true } } },
    }
    lspconfig.emmet_ls.setup(config)
end

local function cssls(lspconfig) lspconfig.cssls.setup(extend {}) end
return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'html', 'css' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { 'prettierd', 'html-lsp', 'css-lsp', 'emmet-ls' }
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = { servers = { html = htmlls, emmet_ls = emmetls, cssls = cssls } },
    },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'html, css, scss, sass' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(
                opts.sources,
                { function(builtins) return { builtins.formatting.prettierd } end }
            )
        end,
    },
}
