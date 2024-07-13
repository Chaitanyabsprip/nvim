-- put this file somewhere in your nvim config, like: ~/.config/nvim/lua/types.lua
-- this code seems weird, but it hints the lsp server to merge the required packages in the vim global variable
vim = require 'vim.shared'
vim = require 'vim.uri'
vim = require 'vim.inspect'
vim = require 'vim.fn'

-- let sumneko know where the sources are for the global vim runtime
vim.lsp = require 'vim.lsp'
vim.treesitter = require 'vim.treesitter'
vim.highlight = require 'vim.highlight'

---@class LspConfig
---@field capabilities?  lsp.ClientCapabilities
---@field on_attach?  vim.lsp.client.on_attach_cb
---@field root_dir? function
---@field cmd? string[]
---@field filetypes? string[]

---@class QfItem
---@field bufnr integer number of buffer that has the file name, use bufname() to get the name
---@field module string? module name
---@field lnum number? line number in the buffer (first line is 1)
---@field end_lnum number? end of line number if the item is multiline
---@field col number? column number (first column is 1)
---@field end_col number? end of column number if the item has range
---@field vcol boolean? |TRUE|: "col" is visual column |FALSE|: "col" is byte index
---@field nr number? error number
---@field pattern string? search pattern used to locate the error
---@field text string? description of the error
---@field type string?|number type of the error, 'E', '1', etc.
---@field valid boolean? |TRUE|: recognized error message
---@field user_data any? custom data associated with the item, can be any type.

-- ---@class QfItemWhat
-- ---@field bufnr number
-- ---@field lnum number
-- ---@field hidden boolean
-- ---@field changed boolean
-- ---@field changedtick number
-- ---@field lastused number

---@class BufInfo: vim.fn.getbufinfo.ret.item

---@class KeymapOpts
---@field noremap? boolean
---@field desc? string
---@field silent? boolean
---@field expr? boolean
---@field nowait? boolean
---@field bufnr? integer
---@field buffer? integer

---@alias SetModeFunc fun(mode: string | string[]): SetKeyFunc

---@alias SetKeyFunc fun(key: string): SetCommandFunc

---@alias SetCommandFunc fun(command: string | function): SetOptionsFunc

---@alias SetOptionsFunc fun(options: KeymapOpts | string): SetDescriptionFunc | nil

---@alias SetDescriptionFunc fun(description: string)
