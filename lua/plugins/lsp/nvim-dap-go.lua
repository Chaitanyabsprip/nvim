local M = {}

M.setup = function()
  local nnoremap = require('mappings').nnoremap
  require('dap-go').setup()
  nnoremap '<leader>gt'(function()
    require('dap-go').debug_test()
  end) {} 'Debug test'
  -- vim.cmd [[nmap <leader>gt :lua require('dap-go').debug_test()<CR>]]
end

return M
