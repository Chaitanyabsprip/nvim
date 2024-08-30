local config = require 'config.theme'
local name = 'palenightfall'

---@type LazySpec
return {
    'JoosepAlviste/palenightfall.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = { transparent = config.transparent },
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}
