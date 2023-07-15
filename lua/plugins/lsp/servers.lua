local servers = {}
local lsp = require 'lsp'

local function extend(config)
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  local defaults = {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', vim.fn.getcwd()),
  }
  local updated_config = vim.tbl_deep_extend('keep', config, defaults)
  return updated_config
end

servers.null = {
  spec = {
    'jose-elias-alvarez/null-ls.nvim',
    ft = { 'lua', 'fish', 'yaml', 'markdown', 'md', 'rmd', 'rst', 'python' },
    config = function() require('plugins.lsp.servers').null.setup() end,
  },

  setup = function()
    local null_ls = require 'null-ls'
    local code_actions = null_ls.builtins.code_actions
    local formatting = null_ls.builtins.formatting
    local get_capabilities = require('plugins.lsp.completion').get_capabilities
    local diagnostics = null_ls.builtins.diagnostics
    local refactoring_opts = {
      filetypes = { 'go', 'javascript', 'typescript', 'lua', 'python', 'c', 'cpp' },
    }

    local python = {
      isort_opts = {
        extra_args = { '--quiet' },
      },
      black_opts = {
        extra_args = { '--quiet', '-l', '80' },
      },
      flake8_opts = {
        extra_args = {
          '--max-line-length=80',
          '--ignore=W503, W504, W391',
          '--exit-zero',
          "--format='%f:%l:%c: %m'",
        },
      },
      pylint_opts = {
        extra_args = {
          '-d',
          'C0114,C0115,C0116',
        },
      },
    }

    null_ls.setup {
      save_after_formatting = true,
      on_attach = lsp.common_on_attach,
      capabilities = get_capabilities(),
      sources = {
        code_actions.refactoring.with(refactoring_opts),
        code_actions.gitsigns,
        diagnostics.yamllint,
        formatting.black.with(python.black_opts),
        formatting.isort.with(python.isort_opts),
        formatting.fish_indent,
        formatting.stylua,
        -- formatting.yapf.with(isort_opts),
      },
    }
    require 'mason-null-ls'
  end,
}

servers.flutter = require('plugins.lsp.flutter').config

servers.__neodev = {
  spec = { 'folke/neodev.nvim', config = function() require('neodev').setup {} end },
}

servers.lsp = {
  setup = function()
    for _, server in pairs(servers.lsp.configs) do
      server()
    end
  end,

  spec = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'FileType' },
    config = function()
      require 'mason-lspconfig'
      require('plugins.lsp.servers').lsp.setup()
    end,
    dependencies = { servers.__neodev.spec },
  },

  configs = {},
}

servers.__schemastore = { spec = { 'b0o/schemastore.nvim', ft = 'json' } }

function servers.lsp.configs.lua()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'

  local config = {
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', '.stylua', vim.fn.getcwd()),
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        completion = { showWord = 'Disable', callSnippet = 'Both', displayContext = true },
        -- diagnostics = { globals = { 'vim', 'require' } },
        telemetry = { enable = false },
        format = { enable = false },
      },
    },
  }
  lspconfig.lua_ls.setup(config)
end

function servers.lsp.configs.json()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  local config = extend {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    settings = { json = { schemas = require('schemastore').json.schemas() } },
    commands = {
      Format = { function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 }) end },
    },
  }
  lspconfig.jsonls.setup(config)
end

function servers.lsp.configs.yaml()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  lspconfig.yamlls.setup {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', vim.fn.getcwd()),
    settings = {
      redhat = { telemetry = false },
      yaml = {
        schemaStore = {
          enable = true,
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
        format = { singleQuote = true },
      },
    },
  }
end

function servers.lsp.configs.python()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  lspconfig.pyright.setup {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern('.git', 'pyproject.toml', '.gitignore', vim.fn.getcwd()),
    settings = { python = { venvPath = '.', analysis = {} } },
  }
end

function servers.lsp.configs.sqlls()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  lspconfig.sqlls.setup {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', '.sqllsrc.json', vim.fn.getcwd()),
  }
end

function servers.lsp.configs.graphql()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  require('lspconfig').graphql.setup {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
  }
end

servers.spec = {
  servers.null.spec,
  servers.lsp.spec,
  servers.flutter.spec,
  servers.__schemastore.spec,
  servers.__neodev.spec,
}

return servers
