local server = {}
local lsp = require 'lsp.setup'
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

server.dart = function()
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
      on_attach = lsp.common_on_attach,
      capabilities = lsp.capabilities(),
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

server.go = function()
  nvim_lsp.gopls.setup {
    settings = {
      gopls = { analyses = { unusedparams = true }, staticcheck = true },
    },
    root_dir = nvim_lsp.util.root_pattern('.git', '.gitignore', 'go.mod', '.'),
    init_options = { usePlaceholders = true, completeUnimported = true },
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
  }
end

server.html = function()
  nvim_lsp.html.setup {
    root_dir = require('lspconfig').util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
    init_options = { provideFormatter = false },
    capabilities = lsp.capabilities(),
    on_attach = lsp.nf_on_attach,
  }
end

server.null = function()
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
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
    sources = {
      code_actions.eslint_d,
      code_actions.gitsigns,
      -- code_actions.refactoring.with(refactoring_opts),
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

server.tsserver = function()
  nvim_lsp.tsserver.setup {
    on_attach = lsp.nf_on_attach,
    capabilities = lsp.capabilities(),
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

server.json = function()
  nvim_lsp.jsonls.setup {
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
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

server.lua = function()
  local user = vim.fn.expand '$USER'

  local sumneko_root_path = ''
  local sumneko_binary = ''

  if vim.fn.has 'mac' == 1 then
    sumneko_root_path = '/Users/'
      .. user
      .. '/.config/nvim/lang-servers/lua-language-server'
    sumneko_binary = '/Users/'
      .. user
      .. '/.config/nvim/lang-servers/lua-language-server/bin/lua-language-server'
  elseif vim.fn.has 'unix' == 1 then
    sumneko_root_path = vim.fn.expand '$HOME'
      .. '/.config/nvim/lang-servers/lua-language-server'
    sumneko_binary = vim.fn.expand '$HOME'
      .. '/.config/nvim/lang-servers/lua-language-server/bin/lua-language-server'
  else
    print 'Unsupported system for sumneko'
  end

  local library = {
    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
    [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
  }

  local path = vim.split(package.path, ';')

  table.insert(path, vim.fn.expand '$HOME' .. '/.config/nvim/lua/?.lua')
  table.insert(path, vim.fn.expand '$HOME' .. '/.config/nvim/lua/lsp/?.lua')
  table.insert(path, vim.fn.expand '$HOME' .. '/.config/nvim/lua/plugins/?.lua')

  local config = {
    on_new_config = function(config, root)
      local libs = vim.tbl_deep_extend('force', {}, library)
      libs[root] = nil
      config.settings.Lua.workspace.library = libs
      return config
    end,
    root_dir = nvim_lsp.util.root_pattern(
      '.git',
      '.gitignore',
      vim.fn.getcwd()
    ),
    capabilities = lsp.capabilities(),
    on_attach = lsp.common_on_attach,
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = path },
        completion = { callSnippet = 'Both' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = library,
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        telemetry = { enable = false },
      },
    },
  }

  local luadev = require('lua-dev').setup {
    library = {
      vimruntime = true,
      types = true,
      plugins = true,
    },
    runtime_path = true,
    lspconfig = config,
  }
  nvim_lsp.sumneko_lua.setup(luadev)
end

server.pyright = function()
  nvim_lsp.pyright.setup {
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
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

server.rust = function()
  nvim_lsp.rust_analyzer.setup {
    cmd = { 'rust-analyzer' },
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
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
        assist = {
          importGranularity = 'module',
          importPrefix = 'by_self',
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
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

server.setup = function()
  for _, lsp_server in ipairs(servers) do
    nvim_lsp[lsp_server].setup {
      on_attach = lsp.common_on_attach,
      capabilities = lsp.capabilities(),
      root_dir = require('lspconfig').util.root_pattern(
        '.git',
        '.gitignore',
        vim.fn.getcwd()
      ),
    }
  end
end

server.yaml = function()
  nvim_lsp.yamlls.setup {
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities(),
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

return server
