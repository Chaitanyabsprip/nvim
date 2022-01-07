local scandir = require 'plenary.scandir'
local utils = require 'utils'

local M = {}

-- calls function for each capability from a capabilities directory if it's resolved
-- module name: the same as appropriate capability
-- module structure:
--     function(capability_value) - function to call if capability were resolved
M.resolve_capabilities = function(resolved_capabilities)
  for capability, value in pairs(resolved_capabilities) do
    local res, module = pcall(require, 'lsp.capabilities.' .. capability)
    if res and value then
      module(value)
    end
  end
end

-- applies each handler from a handlers directory
-- module name: any
-- module structure:
--     handler_name - string, a handler name in `vim.lsp.handlers` object
--     hander - object, a handler object
M.apply_handlers = function()
  local handlers_path = vim.fn.expand '~' .. '/.config/nvim/lua/lsp/handlers'
  local handler_files = scandir.scan_dir(handlers_path, { depth = 1 })
  for _, file in ipairs(handler_files) do
    local handler_module = loadfile(file)()
    vim.lsp.handlers[handler_module.handler_name] = handler_module.handler
  end
end

return M
