local nvim_lsp = require('lspconfig')
local user = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
  sumneko_root_path = "/Users/" .. user ..
                          "/.config/nvim/lang-servers/lua-language-server"
  sumneko_binary = "/Users/" .. user ..
                       "/.config/nvim/lang-servers/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  sumneko_root_path = vim.fn.expand('$HOME') ..
                          "/.config/nvim/lang-servers/lua-language-server"
  sumneko_binary = vim.fn.expand('$HOME') ..
                       "/.config/nvim/lang-servers/lua-language-server/bin/Linux/lua-language-server"
else
  print("Unsupported system for sumneko")
end

--[[ nvim_lsp.sumneko_lua.setup {
  on_attach = LSP.on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
      diagnostics = {globals = {'vim'}},
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
} ]] --
--
--
-- put this file somewhere in your nvim config, like: ~/.config/nvim/lua/config/lua-lsp.lua
-- usage: require'lspconfig'.sumneko_lua.setup(require("config.lua-lsp"))
local library = {}

local path = vim.split(package.path, ";")

-- this is the ONLY correct way to setup your path
table.insert(path, "lua/?.lua")

local function add(lib)
  for _, p in pairs(vim.fn.expand(lib, false, true)) do
    p = vim.loop.fs_realpath(p)
    library[p] = true
  end
end

-- add runtime
--[[ add("$VIMRUNTIME")
add("~/.config/nvim")
add("~/.local/share/nvim/site/pack/packer/start/*") ]]

local config = {
  -- delete root from workspace to make sure we don't trigger duplicate warnings
  on_new_config = function(config, root)
    local libs = vim.tbl_deep_extend("force", {}, library)
    libs[root] = nil
    config.settings.Lua.workspace.library = libs
    return config
  end,
  root_dir = require'lspconfig'.util.root_pattern(".git", ".gitignore",
                                                  vim.fn.getcwd()),
  capabilities = LSP.capabilities,
  on_attach = LSP.common_on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = path
      },
      completion = {callSnippet = "Both"},
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library,
        maxPreload = 2000,
        preloadFileSize = 50000
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}

local luadev = require"lua-dev".setup({lspconfig = config})
nvim_lsp.sumneko_lua.setup(luadev)
