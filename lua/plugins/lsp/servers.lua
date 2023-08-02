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

-- servers.flutter = require('plugins.lsp.flutter')

servers.__neodev = {
  spec = { 'folke/neodev.nvim', config = function() require('neodev').setup {} end },
}

servers.lsp = {
  spec = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre' },
    config = function()
      local lspconfig = require 'lspconfig'
      ---@diagnostic disable-next-line: no-unknown
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
        completion = {
          workspaceword = true,
          showWord = 'Disable',
          callSnippet = 'Both',
          displayContext = true,
        },
        diagnostics = {
          disable = { 'incomplete-signature-doc' },
          groupFileStatus = {
            ['ambiguity'] = 'Any',
            ['await'] = 'Any',
            ['codestyle'] = 'None',
            ['duplicate'] = 'Any',
            ['global'] = 'Any',
            ['luadoc'] = 'Any',
            ['redefined'] = 'Any',
            ['strict'] = 'Any',
            ['strong'] = 'Any',
            ['type-check'] = 'Any',
            ['unbalanced'] = 'Any',
            ['unused'] = 'Any',
          },
          unusedLocalExclude = { '_*' },
        },
        hint = {
          enable = true,
          semicolon = 'Disable',
          arrayIndex = 'Disable',
        },
        type = { castNumberToInteger = true },
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
  servers.lsp.spec,
  -- servers.flutter.spec,
  servers.__schemastore.spec,
  servers.__neodev.spec,
}

return servers.spec
