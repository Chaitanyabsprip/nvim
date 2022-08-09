return {
  init = function()
    local servers = require 'lsp.servers'
    local lsp_utils = require 'lsp.utils'
    lsp_utils.apply_handlers()
    local lsp_servers = {
      'go',
      'html',
      'json',
      'null',
      'pyright',
      'tsserver',
      'yaml',
    }
    for _, server in ipairs(lsp_servers) do
      servers[server]()
    end
    servers.setup()
  end,
}
