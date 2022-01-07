local lsp = {}
local prequire = require('utils').preq
local nvim_lsp = require 'lspconfig'
local servers = {
  'bashls',
  'clangd',
  'cssls',
  'emmet_ls',
  'graphql',
  'vimls',
}

lsp.dart = function()
  prequire('flutter-tools').setup {
    closing_tags = { enabled = false },
    dev_tools = { autostart = true, auto_open_browser = true },
    debugger = {
      enabled = true,
      run_via_dap = true,
      register_configurations = function(_)
        require('dap').configurations.dart = {}
        require('dap.ext.vscode').load_launchjs()
      end,
    },
    flutter_path = os.getenv 'HOME' .. '/Downloads/flutter/bin/flutter',
    lsp = {
      on_attach = LSP.common_on_attach,
      capabilities = LSP.capabilities,
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
      },
      root_dir = require('lspconfig').util.root_pattern(
        '.git',
        '.gitignore',
        'pubspec.yaml',
        vim.fn.getcwd()
      ),
      settings = {
        showTodos = false,
        completeFunctionCalls = true,
        renameFilesWithClasses = true,
      },
    },
    ui = { border = 'rounded' },
    widget_guides = { enabled = false },
  }
  prequire('telescope').load_extension 'flutter'
  vim.api.nvim_set_keymap(
    'n',
    '<leader>fc',
    ":lua require('telescope').extensions.flutter.commands()<CR>",
    { noremap = true, silent = true }
  )
end

lsp.go = function()
  nvim_lsp.gopls.setup {
    cmd = { '/home/chaitanya/.config/nvim/lang-servers/gopls/gopls' },
    settings = {
      gopls = { analyses = { unusedparams = true }, staticcheck = true },
    },
    root_dir = nvim_lsp.util.root_pattern('.git', '.gitignore', 'go.mod', '.'),
    init_options = { usePlaceholders = true, completeUnimported = true },
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
  }
end

lsp.html = function()
  nvim_lsp.html.setup {
    root_dir = require('lspconfig').util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
    init_options = { provideFormatter = false },
    capabilities = LSP.capabilities,
    on_attach = LSP.nf_on_attach,
  }
end

lsp.java = function()
  vim.cmd [[
		augroup lsp
			au!
			au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
		augroup end
  ]]
end

lsp.null = function()
  local null_ls = require 'null-ls'
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  local prettier_opts = {
    extra_args = {
      '--single-quote',
      '--jsx-single-quote',
      '--trailing_comma all',
      '--bracket-same-line',
      '--prose-wrap always',
    },
  }

  local isort_opts = {
    extra_args = {
      '--quiet',
    },
  }

  local flake8_opts = {
    extra_args = {
      '--max-line-length=80',
      '--ignore=W503, W504, W391',
      '--exit-zero',
      "--format='%f:%l:%c: %m'",
    },
  }

  local shfmt_opts = {
    extra_args = {
      '-ci',
      '-s',
      '-bn',
    },
    filetypes = {
      'sh',
      'bash',
    },
  }

  local shellcheck_opts = {
    extra_args = {
      '-x',
    },
    filetypes = {
      'sh',
      'bash',
    },
  }

  local refactoring_opts = {
    filetypes = {
      'go',
      'javascript',
      'typescript',
      'lua',
      'python',
      'c',
      'cpp',
    },
  }

  null_ls.setup {
    save_after_formatting = true,
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    sources = {
      code_actions.eslint_d,
      code_actions.gitsigns,
      code_actions.refactoring.with(refactoring_opts),
      code_actions.proselint,
      diagnostics.eslint_d,
      diagnostics.flake8.with(flake8_opts),
      diagnostics.shellcheck.with(shellcheck_opts),
      diagnostics.yamllint,
      diagnostics.proselint,
      formatting.eslint_d,
      formatting.isort.with(isort_opts),
      formatting.prettier.with(prettier_opts),
      formatting.shfmt.with(shfmt_opts),
      formatting.stylua,
      formatting.yapf.with(isort_opts),
    },
  }
end

lsp.tsserver = function()
  nvim_lsp.tsserver.setup {
    on_attach = LSP.nf_on_attach,
    capabilities = LSP.capabilities,
    settings = { documentFormatting = false, documentRangeFormatting = false },
    root_dir = require('lspconfig/util').root_pattern(
      'package.json',
      'tsconfig.json',
      'jsconfig.json',
      '.git/',
      '.gitignore',
      vim.fn.getcwd()
    ),
  }
end

lsp.json = function()
  nvim_lsp.jsonls.setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    root_dir = require('lspconfig').util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
        end,
      },
    },
  }
end

lsp.pyright = function()
  nvim_lsp.pyright.setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    root_dir = require('lspconfig/util').root_pattern(
      '.git/',
      '.gitignore',
      'setup.py',
      vim.fn.getcwd()
    ),
    setttings = {
      python = {
        analysis = {
          diagnosticMode = 'workspace',
          typeCheckingMode = 'strict',
        },
      },
    },
  }
end

lsp.rust = function()
  nvim_lsp.rust_analyzer.setup {
    cmd = { 'rust-analyzer' },
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    settings = {
      ['rust_analyzer'] = {
        rustfmt = { enableRangeFormatting = true },
        lens = {
          debug = true,
          enable = true,
          foreCustomCommands = true,
          implementations = true,
          methodReferences = true,
          references = true,
          run = true,
        },
        inlayHints = {
          enable = true,
          chainingHints = true,
          maxLength = 50,
          parameterHints = true,
          smallerHints = true,
          typeHints = true,
        },
        -- hoverActions = {}
      },
    },
    root_dir = require('lspconfig/util').root_pattern(
      'Cargo.toml',
      'rust-project.json',
      '.git/',
      '.gitignore',
      vim.fn.getcwd()
    ),
  }
end

lsp.setup = function()
  for _, server in ipairs(servers) do
    nvim_lsp[server].setup {
      on_attach = LSP.common_on_attach,
      capabilities = LSP.capabilities,
      root_dir = require('lspconfig').util.root_pattern(
        '.git',
        '.gitignore',
        vim.fn.getcwd()
      ),
    }
  end
end

lsp.yaml = function()
  nvim_lsp.yamlls.setup {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    root_dir = require('lspconfig').util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
    settings = {
      redhat = {
        telemetry = false,
      },
      yaml = {
        schemaStore = {
          enable = true,
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
        format = {
          singleQuote = true,
        },
      },
    },
  }
end

return lsp
