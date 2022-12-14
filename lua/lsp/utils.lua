local M = {}

-- calls function for each capability from a capabilities directory if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(client)
  local capabilities = require 'lsp.capabilities'
  for capability, module in pairs(capabilities) do
    if client.supports_method(capability) then
      module()
    end
  end
end

-- applies each handler from a handlers files
-- module name: any
-- module structure:
--     name - string, a handler name in `vim.lsp.handlers` object
--     hander - object, a handler object
M.apply_handlers = function()
  local handlers = require 'lsp.handlers'
  for _, handler_fn in pairs(handlers) do
    local handler = handler_fn()
    vim.lsp.handlers[handler.name] = handler.handler
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
