local M = {}

-- calls function for each capability from a capabilities directory if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(resolved_capabilities)
  local capabilities = require 'lsp.capabilities'
  for capability, value in pairs(resolved_capabilities) do
    local module = capabilities[capability]
    if module ~= nil and value then
      module(value)
    end
  end
  require('mappings').setup_keymaps()
end

-- applies each handler from a handlers directory
-- module name: any
-- module structure:
--     handler_name - string, a handler name in `vim.lsp.handlers` object
--     hander - object, a handler object
M.apply_handlers = function()
  local handlers = require 'lsp.handlers'
  for _, handler_fn in pairs(handlers) do
    local handler = handler_fn()
    vim.lsp.handlers[handler.handler_name] = handler.handler
  end
end

return M
