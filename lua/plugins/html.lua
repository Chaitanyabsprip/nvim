local configure = require('plugins.lsp').configure

local function htmlls()
    local config = {
        filetypes = {
            'html',
            'astro',
            -- 'javascript',
            'javascriptreact',
            'javascript.jsx',
            -- 'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
    }
    configure('html', config)
end

local function emmetls()
    local capabilities = require('plugins.completion').get_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    local config = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        init_options = { html = { options = { ['bem.enabled'] = true } } },
        capabilities = capabilities,
    }
    configure('emmet_ls', config)
end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'html')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'html-lsp',
                'emmet-ls'
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { html = htmlls, emmet_ls = emmetls } },
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'html', 'htmlangular' }) end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return {
                        builtins.formatting.prettierd.with {
                            filetypes = { 'html', 'htmlangular' },
                        },
                    }
                end
            )
        end,
    },
}
