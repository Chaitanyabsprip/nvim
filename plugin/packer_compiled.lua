-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/chaitanyasharma/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/chaitanyasharma/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/chaitanyasharma/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/chaitanyasharma/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/chaitanyasharma/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { "require('Comment').setup()" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["SchemaStore.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/SchemaStore.nvim",
    url = "https://github.com/b0o/SchemaStore.nvim"
  },
  ["auto-session"] = {
    after = { "session-lens" },
    config = { "require 'plugins.nvim.auto-session'" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["awesome-flutter-snippets"] = {
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/awesome-flutter-snippets",
    url = "https://github.com/Nash0x7E2/awesome-flutter-snippets"
  },
  ["bufferline.nvim"] = {
    config = { "require 'plugins.nvim.nvim-bufferline'" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-cmdline-history/after/plugin/cmp_cmdline_history.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-digraphs"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-digraphs/after/plugin/cmp_digraphs.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-digraphs",
    url = "https://github.com/dmitmel/cmp-digraphs"
  },
  ["cmp-emoji"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-emoji/after/plugin/cmp_emoji.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    after = { "nvim-lspconfig" },
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["copilot.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["dart-vim-plugin"] = {
    config = { "require('languages').dart()" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin",
    url = "https://github.com/dart-lang/dart-vim-plugin"
  },
  ["dartlang-snippets"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets",
    url = "https://github.com/natebosch/dartlang-snippets"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\ninput\1\0\0\1\0\1\17prefer_width\3\30\nsetup\rdressing\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fidget.nvim"] = {
    config = { "require('fidget').setup{}" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["filetype.nvim"] = {
    config = { "vim.g.did_load_filetypes = 1" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["flutter-riverpod-snippets"] = {
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/flutter-riverpod-snippets",
    url = "https://github.com/RobertBrunhage/flutter-riverpod-snippets"
  },
  ["flutter-snippets"] = {
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/flutter-snippets",
    url = "https://github.com/Alexisvt/flutter-snippets"
  },
  ["flutter-tools.nvim"] = {
    after = { "flutter-riverpod-snippets", "flutter-snippets", "awesome-flutter-snippets" },
    config = { "require('lsp.servers').dart()" },
    load_after = {
      ["nvim-lspconfig"] = true,
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-worktree.nvim"] = {
    config = { "require('plugins.git').git_worktree()" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/git-worktree.nvim",
    url = "https://github.com/ThePrimeagen/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require 'plugins.git.gitsigns'" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  hop = {
    config = { "require('plugins.editing').hop()" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/hop",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    config = { "require('impatient')" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp-fastaction.nvim"] = {
    config = { "require('plugins.lsp').fastaction()" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lsp-fastaction.nvim",
    url = "https://github.com/windwp/lsp-fastaction.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lua-dev.nvim"] = {
    config = { "require('lsp.servers').lua()" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "require('plugins.editing').autopairs()" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-vsnip", "friendly-snippets", "nvim-autopairs", "vim-vsnip", "cmp-buffer", "cmp-cmdline", "cmp-cmdline-history", "cmp-digraphs", "cmp-emoji", "cmp-nvim-lsp-signature-help", "cmp-nvim-lua", "cmp-path" },
    config = { "require 'plugins.lsp.nvim-cmp'" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    commands = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    config = { "\27LJ\2\nV\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\tdart\1\0\0\1\0\1\vrgb_0x\2\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/afonsocraposo/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-go", "nvim-dap-virtual-text", "telescope-dap.nvim", "nvim-dap-python" },
    config = { "require 'plugins.lsp.nvim-dap'" },
    keys = { { "n", "<leader>c" }, { "n", "<leader>b" }, { "n", "<leader>B" }, { "n", "<leader>gt" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-go"] = {
    config = { "require('plugins.lsp.dap').go()" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap-go",
    url = "https://github.com/leoluz/nvim-dap-go"
  },
  ["nvim-dap-python"] = {
    config = { "require('plugins.lsp.dap').python()" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    config = { "require('plugins.lsp.dap').ui()" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "require('nvim-dap-virtual-text').setup()" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    after = { "lua-dev.nvim", "lsp-fastaction.nvim", "flutter-tools.nvim" },
    config = { "require('lsp').init()" },
    load_after = {
      ["cmp-nvim-lsp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "require('plugins.explorer').nvim_tree()" },
    keys = { { "n", "<leader>e" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require 'plugins.nvim-treesitter'" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/RobertBrunhage/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["obsidian.nvim"] = {
    config = { "\27LJ\2\n„\1\0\0\a\0\t\0\f6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\0045\5\b\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\17jump_to_link\robsidian\frequire\14<leader>o\6n\bset\vkeymap\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/obsidian.nvim",
    url = "/Users/chaitanyasharma/Projects/Languages/Lua/obsidian.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["present.nvim"] = {
    commands = { "Present", "PresentEnable", "PresentDisable" },
    config = { "require('present').setup()" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/present.nvim",
    url = "/Users/chaitanyasharma/Projects/Languages/Lua/present.nvim"
  },
  ["project.nvim"] = {
    config = { "require('plugins.explorer').project()" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\n®\3\0\0\5\0\17\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0029\0\n\0\18\1\0\0'\3\v\0'\4\f\0B\1\3\1\18\1\0\0'\3\r\0'\4\14\0B\1\3\1\18\1\0\0'\3\15\0'\4\16\0B\1\3\1K\0\1\0\20RestNvimPreview\f<A-s-r>\17RestNvimLast\n<A-l>\19<Plug>RestNvim\n<A-r>\rnnoremap\nutils\29custom_dynamic_variables\vresult\1\0\3\rshow_url\2\17show_headers\2\19show_http_info\2\14highlight\1\0\2\fenabled\2\ftimeout\3–\1\1\0\5\26skip_ssl_verification\1\28result_split_horizontal\1\20jump_to_request\2\renv_file\t.env\17yank_dry_run\2\nsetup\14rest-nvim\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim",
    url = "https://github.com/NTBBloodbath/rest.nvim"
  },
  ["session-lens"] = {
    config = { "require 'plugins.nvim.session-lens'" },
    load_after = {
      ["auto-session"] = true,
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/session-lens",
    url = "https://github.com/rmagatti/session-lens"
  },
  ["spellsitter.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["startup.nvim"] = {
    config = { "require('plugins.nvim.startup').setup()" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/startup.nvim",
    url = "https://github.com/startup-nvim/startup.nvim"
  },
  ["surround.nvim"] = {
    config = { "require('surround').setup {}" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/surround.nvim",
    url = "https://github.com/ur4ltz/surround.nvim"
  },
  tabular = {
    after_files = { "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/tabular/after/plugin/TabularMaps.vim" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-dap.nvim"] = {
    config = { "require('telescope').load_extension 'dap'" },
    load_after = {
      ["nvim-dap"] = true,
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    config = { "require('plugins.nvim.file_browser').setup()" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    after = { "project.nvim", "git-worktree.nvim", "telescope-file-browser.nvim", "telescope-dap.nvim", "session-lens", "dressing.nvim", "flutter-tools.nvim" },
    commands = { "Telescope" },
    config = { "require('plugins.telescope').setup()" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm" },
    config = { "require('plugins.toggleterm').setup()" },
    keys = { { "n", "<leader>tf" }, { "n", "<leader>tg" }, { "n", "<leader>tt" }, { "n", "<leader>tr" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["venn.nvim"] = {
    config = { "require('plugins.utilities').venn()" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-fish"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish",
    url = "https://github.com/dag/vim-fish"
  },
  ["vim-graphql"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql",
    url = "https://github.com/jparise/vim-graphql"
  },
  ["vim-markdown"] = {
    config = { "require('languages').markdown()" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 50" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { "require('plugins.utilities').zen_mode()" },
    keys = { { "n", "<leader>z" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lsp_lines\frequire\0", "config", "lsp_lines.nvim")
time([[Config for lsp_lines.nvim]], false)
-- Config for: startup.nvim
time([[Config for startup.nvim]], true)
require('plugins.nvim.startup').setup()
time([[Config for startup.nvim]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
vim.g.did_load_filetypes = 1
time([[Config for filetype.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PresentDisable lua require("packer.load")({'present.nvim'}, { cmd = "PresentDisable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerToggle lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerAttachToBuffer lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerAttachToBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTerm lua require("packer.load")({'toggleterm.nvim'}, { cmd = "ToggleTerm", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Present lua require("packer.load")({'present.nvim'}, { cmd = "Present", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PresentEnable lua require("packer.load")({'present.nvim'}, { cmd = "PresentEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <leader>tf <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>leader>tf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tt <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>leader>tt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>B <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>B", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>z <cmd>lua require("packer.load")({'zen-mode.nvim'}, { keys = "<lt>leader>z", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tr <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>leader>tr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>gt <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>gt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>b <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>b", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>e <cmd>lua require("packer.load")({'nvim-tree.lua'}, { keys = "<lt>leader>e", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tg <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>leader>tg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>c <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>c", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType http ++once lua require("packer.load")({'rest.nvim'}, { ft = "http" }, _G.packer_plugins)]]
vim.cmd [[au FileType https ++once lua require("packer.load")({'rest.nvim'}, { ft = "https" }, _G.packer_plugins)]]
vim.cmd [[au FileType dart ++once lua require("packer.load")({'dartlang-snippets', 'flutter-riverpod-snippets', 'flutter-snippets', 'awesome-flutter-snippets', 'dart-vim-plugin'}, { ft = "dart" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'markdown-preview.nvim', 'spellsitter.nvim', 'cmp-digraphs', 'venn.nvim', 'tabular', 'obsidian.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType txt ++once lua require("packer.load")({'spellsitter.nvim'}, { ft = "txt" }, _G.packer_plugins)]]
vim.cmd [[au FileType fish ++once lua require("packer.load")({'vim-fish'}, { ft = "fish" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-dap-python'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType graphql ++once lua require("packer.load")({'vim-graphql'}, { ft = "graphql" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'copilot.vim', 'popup.nvim', 'fidget.nvim', 'surround.nvim', 'impatient.nvim', 'Comment.nvim', 'SchemaStore.nvim', 'nvim-dap-ui', 'bufferline.nvim', 'auto-session', 'cmp-nvim-lsp', 'tabular', 'nvim-web-devicons'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'null-ls.nvim', 'gitsigns.nvim', 'hop'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'lualine.nvim', 'tokyonight.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au WinEnter * ++once lua require("packer.load")({'telescope.nvim'}, { event = "WinEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dart-vim-plugin/ftdetect/dart.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
