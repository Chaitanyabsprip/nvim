local M = {}

-- calls function for each capability from a capabilities directory if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(resolved_capabilities)
  for capability, value in pairs(resolved_capabilities) do
    print(capability)
    local res, module = pcall(require, 'lsp.capabilities.' .. capability)
    if res and value then
      module(value)
    end
  end
end

return M
