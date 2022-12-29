local M = {}

-- calls function for each capability from a capabilities module if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(client)
  local capabilities = require 'lsp.capabilities'
  for _, capability in pairs(capabilities) do
    if client.supports_method(capability.name) then capability.callback() end
  end
  -- for capability, module in pairs(capabilities) do
  --   if client.supports_method(capability) then module() end
  -- end
end

-- applies each handler from a handlers module
-- object name: any
-- object structure:
--     name - string, a handler name in `vim.lsp.handlers` object
--     callback - function, a handler callback
M.resolve_handlers = function()
  local handlers = require 'lsp.handlers'
  for _, handler_fn in pairs(handlers) do
    local handler = handler_fn()
    if handler.enabled then vim.lsp.handlers[handler.name] = handler.callback end
  end
end

M.prequire = function(module)
  local status, err = pcall(require, module)
  if not status then
    print(err)
    return nil
  end
  return status
end

return M
