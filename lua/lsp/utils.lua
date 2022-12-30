local M = {}

-- calls function for each capability from a capabilities module if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(client, bufnr)
  local capabilities = require 'lsp.capabilities'
  for _, capability in pairs(capabilities) do
    if client.supports_method(capability.name) then capability.callback(client, bufnr) end
  end
end

-- applies each handler from a handlers module
-- object name: any
-- object structure:
--     name - string, a handler name in `vim.lsp.handlers` object
--     callback - function, a handler callback
M.resolve_handlers = function()
  local handlers = require 'lsp.handlers'
  for _, factory in pairs(handlers) do
    local handler = factory()
    if handler.enabled then vim.lsp.handlers[handler.name] = handler.callback end
  end
end

return M
