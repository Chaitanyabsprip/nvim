local nvim_lsp = require 'lspconfig'
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
  root_dir = nvim_lsp.util.root_pattern('.git', '.gitignore', vim.fn.getcwd()),
  capabilities = LSP.capabilities,
  on_attach = LSP.common_on_attach,
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
