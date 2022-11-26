return {
  init = function()
    local servers = require 'lsp.servers'
    local lsp_utils = require 'lsp.utils'
    lsp_utils.apply_handlers()
    for _, server in ipairs(servers.list) do
      servers[server]()
    end
    servers.setup()
  end,
}
