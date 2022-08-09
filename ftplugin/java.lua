vim.cmd [[setlocal shiftwidth=4 softtabstop=4 expandtab tabstop=4]]
local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

-- Determine OS
local home = os.getenv 'HOME'
if vim.fn.has 'mac' == 1 then
  WORKSPACE_PATH = home .. '/workspace/'
  CONFIG = 'mac'
elseif vim.fn.has 'unix' == 1 then
  WORKSPACE_PATH = home .. '/workspace/'
  CONFIG = 'linux'
else
  print 'Unsupported system'
end

-- Find root of project
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/Users/chaitanyasharma/Projects/Languages/Java/.workspace/'
  .. project_name

local bundles = {
  vim.fn.glob(
    home
      .. '/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
  ),
}

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    '/Users/chaitanyasharma/Programs/jdt-language-server-latest/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration',
    '/Users/chaitanyasharma/Programs/jdt-language-server-latest/config_mac',
    '-data',
    workspace_dir,
  },
  on_attach = require('lsp.setup').common_on_attach,
  capabilities = require('lsp.setup').capabilities(),
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },
  settings = {
    java = {
      referenceCodeLens = true,
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    contentProvider = { preferred = 'fernflower' },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = bundles,
  },
}

require('jdtls').start_or_attach(config)
