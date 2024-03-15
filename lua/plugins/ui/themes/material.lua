local config = require 'config.theme'

local name = 'material'

---@class Colorscheme
local material = {
    'marko-cerovac/material.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = 'material-stealth'
        ---@diagnostic disable-next-line: no-unknown
        vim.g.material_style = 'deep ocean'
        return {
            contrast = {
                terminal = true,
                sidebars = true,
                floating_windows = true,
                non_current_windows = false,
            },
            -- disable = { background = false },
            styles = { comments = { italic = true } },
            plugins = {
                'dap',
                'dashboard',
                'eyeliner',
                'gitsigns',
                'harpoon',
                'mini',
                'neogit',
                'neotest',
                'noice',
                'nvim-cmp',
                'nvim-navic',
                'nvim-tree',
                'nvim-web-devicons',
                'telescope',
                'nvim-notify',
            },
        }
    end,
    config = function(_, opts)
        local colors = require 'material.colors'
        local utils = require 'utils'
        opts.custom_highlights = {
            ---@diagnostic disable-next-line: no-unknown
            -- NotifyBackground = { bg = colors.editor.bg, fg = colors.editor.fg },
            CursorLine = { bg = '#1a1c25' },
            LeapBackdrop = { fg = '#545c7e' },
            ['@text.reference'] = { fg = 'cyan' },
            Headline1 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.red, colors.editor.bg, 0.8),
            },
            Headline2 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.orange, colors.editor.bg, 0.8),
            },
            Headline3 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.yellow, colors.editor.bg, 0.8),
            },
            Headline4 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.green, colors.editor.bg, 0.8),
            },
            Headline5 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.blue, colors.editor.bg, 0.8),
            },
            Headline6 = {
                bg = colors.backgrounds.cursor_line,
                fg = utils.blend(colors.main.purple, colors.editor.bg, 0.8),
            },
        }
        require('material').setup(opts)
        vim.cmd.colorscheme 'material'
    end,
}

function material.set() end

return material
