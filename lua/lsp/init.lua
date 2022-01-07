return function()
  local servers = require 'lsp.servers'
  local lsp_utils = require 'lsp.utils'
  lsp_utils.apply_handlers()
  servers.go()
  servers.html()
  servers.json()
  servers.null()
  servers.pyright()
  servers.setup()
  servers.tsserver()
  servers.yaml()
end
