local servers = {}
local lsp = require 'lsp'

local function extend(config)
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local def_root = { '.git', '.gitignore', vim.fn.getcwd() }
  local roots = vim.list_extend(def_root, config.root or {})
  local lspconfig = require 'lspconfig'
  local defaults = {
    on_attach = lsp.on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern(unpack(roots)),
  }
  local updated_config = vim.tbl_deep_extend('force', config, defaults)
  return updated_config
end

local null_ft = { 'lua', 'fish', 'yaml', 'markdown', 'md', 'rmd', 'rst', 'python' }
servers.null = {
  ft = null_ft,
  spec = {
    'jose-elias-alvarez/null-ls.nvim',
    ft = null_ft,
    opts = function()
      local get_capabilities = require('plugins.lsp.completion').get_capabilities
      local builtins = require('null-ls').builtins
      local code_actions = builtins.code_actions
      local hover = builtins.hover
      local formatting = builtins.formatting
      local diagnostics = builtins.diagnostics
      local refactoring_opts = {
        filetypes = { 'go', 'javascript', 'typescript', 'lua', 'python', 'c', 'cpp' },
      }
      return {
        save_after_formatting = true,
        on_attach = lsp.on_attach,
        capabilities = get_capabilities(),
        sources = {
          code_actions.gitsigns,
          code_actions.refactoring.with(refactoring_opts),
          diagnostics.markdownlint,
          diagnostics.codespell.with { filetypes = { 'markdown' } },
          diagnostics.yamllint,
          formatting.beautysh,
          formatting.black.with { extra_args = { '--quiet', '-l', '80' } },
          formatting.deno_fmt.with {
            filetypes = { 'markdown' },
            extra_args = { '--prose-wrap="preserve"' },
          },
          formatting.fish_indent,
          formatting.isort.with { extra_args = { '--quiet' } },
          formatting.markdownlint,
          formatting.stylua,
          formatting.shfmt,
          hover.dictionary,
        },
      }
    end,
  },
}

servers.flutter = require('plugins.lsp.flutter').config

servers.__neodev = {
  spec = { 'folke/neodev.nvim', config = function() require('neodev').setup {} end },
}

servers.lsp = {
  spec = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    config = function()
      local lspconfig = require 'lspconfig'
      for _, server in pairs(servers.lsp.configs) do
        server(lspconfig)
      end
    end,
    dependencies = {
      servers.__neodev.spec,
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
  configs = {},
}

servers.__schemastore = { spec = { 'b0o/schemastore.nvim', ft = 'json' } }

function servers.lsp.configs.lua(lspconfig)
  local config = extend {
    root = { '.stylua' },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        completion = { showWord = 'Disable', callSnippet = 'Both', displayContext = true },
        hint = { enable = true },
        telemetry = { enable = false },
        format = { enable = false },
      },
    },
  }
  lspconfig.lua_ls.setup(config)
end

function servers.lsp.configs.json(lspconfig)
  local config = extend {
    settings = { json = { schemas = require('schemastore').json.schemas() } },
    commands = {
      Format = { function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 }) end },
    },
  }
  lspconfig.jsonls.setup(config)
end

function servers.lsp.configs.yaml(lspconfig)
  local config = extend {
    settings = {
      redhat = { telemetry = false },
      yaml = {
        schemaStore = { enable = true, url = 'https://www.schemastore.org/api/json/catalog.json' },
        format = { singleQuote = true },
      },
    },
  }
  lspconfig.yamlls.setup(config)
end

function servers.lsp.configs.python(lspconfig)
  local config = extend {
    root = { 'pyproject.toml' },
    settings = { python = { venvPath = '.', analysis = {} } },
  }
  lspconfig.pyright.setup(config)
end

function servers.lsp.configs.sqlls(lspconfig)
  local config = extend { root = { '.sqllsrc.json' } }
  lspconfig.sqlls.setup(config)
end

function servers.lsp.configs.graphql(lspconfig) lspconfig.graphql.setup(extend {}) end

function servers.lsp.configs.bash(lspconfig) lspconfig.bashls.setup(extend {}) end

function servers.lsp.configs.markdown(lspconfig)
  lspconfig.marksman.setup(extend { root = { '.marksman.toml' } })
end

servers.spec = {
  servers.null.spec,
  servers.lsp.spec,
  servers.flutter.spec,
  servers.__schemastore.spec,
  servers.__neodev.spec,
}

return servers
