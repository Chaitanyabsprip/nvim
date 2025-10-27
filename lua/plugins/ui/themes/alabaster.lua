local config = require 'config.theme'
local name = 'alabaster'

---@type LazySpec
return {
    url = 'https://git.sr.ht/~p00f/alabaster.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {}
    end,
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}
