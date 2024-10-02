local extend = require('plugins.lsp').extend

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'javascript',
                'typescript',
                'jsdoc'
            )
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'typescript-language-server',
                'prettierd',
                'js-debug-adapter'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes)
            return vim.list_extend(filetypes, { 'javascript', 'typescript' })
        end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return {
                        builtins.formatting.prettierd.with {
                            filetypes = {
                                'javascript',
                                'typescript',
                                'javascriptreact',
                                'typescriptreact',
                            },
                        },
                    }
                end
            )
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        ft = { 'javascript', 'typescript' },
        opts = {
            on_attach = require('lsp').on_attach,
            settings = {
                -- spawn additional tsserver instance to calculate diagnostics on it
                separate_diagnostic_server = true,
                -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                publish_diagnostic_on = 'insert_leave',
                -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
                -- "remove_unused_imports"|"organize_imports") -- or string "all"
                -- to include all supported code actions
                -- specify commands exposed as code_actions
                expose_as_code_action = 'all',
                -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                -- not exists then standard path resolution strategy is applied
                tsserver_path = nil,
                -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                -- (see 💅 `styled-components` support section)
                tsserver_plugins = {},
                -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                -- memory limit in megabytes or "auto"(basically no limit)
                tsserver_max_memory = 'auto',
                -- described below
                tsserver_format_options = {
                    insertSpaceAfterCommaDelimiter = true,
                    insertSpaceAfterConstructor = false,
                    insertSpaceAfterSemicolonInForStatements = true,
                    insertSpaceBeforeAndAfterBinaryOperators = true,
                    insertSpaceAfterKeywordsInControlFlowStatements = true,
                    insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                    insertSpaceBeforeFunctionParenthesis = false,
                    insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
                    insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true, -- modified
                    insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                    insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false, -- modified
                    insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
                    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
                    insertSpaceAfterTypeAssertion = true,
                    placeOpenBraceOnNewLineForFunctions = false,
                    placeOpenBraceOnNewLineForControlBlocks = false,
                    semicolons = 'insert',
                    indentSwitchCase = true,
                },
                tsserver_file_preferences = {
                    quotePreference = 'double',
                    importModuleSpecifierEnding = 'auto',
                    jsxAttributeCompletionStyle = 'auto',
                    allowTextChangesInNewFiles = true,
                    providePrefixAndSuffixTextForRename = true,
                    allowRenameOfImportPath = true,
                    includeAutomaticOptionalChainCompletions = true,
                    provideRefactorNotApplicableReason = true,
                    generateReturnInDocTemplate = true,
                    includeCompletionsForImportStatements = true,
                    includeCompletionsWithSnippetText = true,
                    includeCompletionsWithClassMemberSnippets = true,
                    includeCompletionsWithObjectLiteralMethodSnippets = true,
                    useLabelDetailsInCompletionEntries = true,
                    allowIncompleteCompletions = true,
                    displayPartsForJSDoc = true,
                    disableLineTextInReferences = true,
                    includeInlayParameterNameHints = 'none',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = false,
                    includeInlayVariableTypeHints = false,
                    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                    includeInlayPropertyDeclarationTypeHints = false,
                    includeInlayFunctionLikeReturnTypeHints = false,
                    includeInlayEnumMemberValueHints = false,
                },
                -- locale of all tsserver messages, supported locales you can find here:
                -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                tsserver_locale = 'en',
                -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                complete_function_calls = true,
                include_completions_with_insert_text = true,
                -- CodeLens
                -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
                -- possible values: ("off"|"all"|"implementations_only"|"references_only")
                code_lens = 'off',
                -- by default code lenses are displayed on all referenceable values and for some of you it can
                -- be too much this option reduce count of them by removing member references from lenses
                disable_member_code_lens = true,
                -- JSXCloseTag
                -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
                -- that maybe have a conflict if enable this feature. )
                jsx_close_tag = {
                    enable = true,
                    filetypes = { 'javascriptreact', 'typescriptreact' },
                },
            },
        },
    },
    {
        'mfussenegger/nvim-dap',
        opts = {
            adapters = {
                ['pwa-node'] = {
                    type = 'server',
                    host = 'localhost',
                    port = '${port}',
                    executable = {
                        command = 'js-debug-adapter',
                        args = { '${port}' },
                    },
                },
            },
            configurations = {
                javascript = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = '${workspaceFolder}',
                    },
                },
                typescript = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = '${workspaceFolder}',
                    },
                },
            },
        },
    },
}
