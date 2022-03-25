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
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  Flutter = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/Flutter",
    url = "https://github.com/Dart-Code/Flutter"
  },
  ["HighStr.nvim"] = {
    config = { "\27LJ\2\nÓ\3\0\0\6\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\0045\5\15\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0=\5\20\0045\5\21\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3B\1\2\1K\0\1\0\21highlight_colors\fcolor_9\1\3\0\0\f#7d5c34\nsmart\fcolor_8\1\3\0\0\f#FFF9E3\nsmart\fcolor_7\1\3\0\0\f#FFC0CB\nsmart\fcolor_6\1\3\0\0\f#0000FF\nsmart\fcolor_5\1\3\0\0\f#008000\nsmart\fcolor_4\1\3\0\0\f#FF4500\nsmart\fcolor_3\1\3\0\0\f#8A2BE2\nsmart\fcolor_2\1\3\0\0\f#7FFFD4\nsmart\fcolor_1\1\3\0\0\f#e5c07b\nsmart\fcolor_0\1\0\0\1\3\0\0\f#0c0d0e\nsmart\1\0\2\16saving_path\18/tmp/highstr/\14verbosity\3\0\nsetup\rhigh-str\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/HighStr.nvim",
    url = "https://github.com/Pocco81/HighStr.nvim"
  },
  ["Sakura.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/Sakura.nvim",
    url = "https://github.com/numToStr/Sakura.nvim"
  },
  ["SchemaStore.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/SchemaStore.nvim",
    url = "https://github.com/b0o/SchemaStore.nvim"
  },
  ["arch.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/arch.nvim",
    url = "/Users/chaitanyasharma/Projects/Languages/Lua/arch.nvim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["awesome-flutter-snippets"] = {
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/awesome-flutter-snippets",
    url = "https://github.com/Nash0x7E2/awesome-flutter-snippets"
  },
  ["blue-moon"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/blue-moon",
    url = "https://github.com/kyazdani42/blue-moon"
  },
  ["calvera-dark.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/calvera-dark.nvim",
    url = "https://github.com/yashguptaz/calvera-dark.nvim"
  },
  catppuccin = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/catppuccin",
    url = "https://github.com/catppuccin/nvim"
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
  ["conflict-marker.vim"] = {
    config = { "\27LJ\2\n£\4\0\0\3\0\n\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\b\0'\2\t\0B\0\2\1K\0\1\0ß\2        highlight link ConflictMarkerOurs DiagnosticVirtualTextHint\n        highlight ConflictMarkerBegin guibg=#2f7366\n        highlight ConflictMarkerOurs guibg=#2e5049\n        highlight ConflictMarkerTheirs guibg=#344f69\n        highlight ConflictMarkerEnd guibg=#2f628e\n        highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81\n      \bcmd\17^>>>>>>> .*$\24conflict_marker_end\17^||||||| .*$%conflict_marker_common_ancestors\17^<<<<<<< .*$\26conflict_marker_begin\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["copilot.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["dart-code"] = {
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dart-code",
    url = "/Users/chaitanyasharma/.cache/nvim/dart-code"
  },
  ["dart-vim-plugin"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\bvim\0" },
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
  ["dependency-assist.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0" },
    load_after = {
      ["flutter-tools.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dependency-assist.nvim",
    url = "https://github.com/akinsho/dependency-assist.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\n4\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\23did_load_filetypes\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
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
    after = { "nvim-dap-ui", "dart-code", "awesome-flutter-snippets", "dependency-assist.nvim", "flutter-snippets" },
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tdart\16lsp.servers\frequire\0" },
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
  ["github-nvim-theme"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
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
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\bhop\20plugins.editing\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/hop",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["line-number-interval.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/line-number-interval.nvim",
    url = "https://github.com/IMOKURI/line-number-interval.nvim"
  },
  ["lsp-fastaction.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15fastaction\16plugins.lsp\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lsp-fastaction.nvim",
    url = "https://github.com/windwp/lsp-fastaction.nvim"
  },
  ["lsp-trouble.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\ftrouble\16plugins.lsp\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lsp-trouble.nvim",
    url = "https://github.com/folke/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lua-dev.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\blua\16lsp.servers\frequire\0" },
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
  ["material.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/material.nvim",
    url = "https://github.com/marko-cerovac/material.nvim"
  },
  ["mkdnflow.nvim"] = {
    config = { "\27LJ\2\ná\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14filetypes\1\0\3\brmd\2\amd\2\rmarkdown\2\1\0\a\22wrap_to_beginning\1\20new_file_prefix\6n\20evaluate_prefix\2\16wrap_to_end\1\22links_relative_to\fcurrent\16create_dirs\2\21default_mappings\2\nsetup\rmkdnflow\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/mkdnflow.nvim",
    url = "https://github.com/jakewvincent/mkdnflow.nvim"
  },
  ["moonlight.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/moonlight.nvim",
    url = "https://github.com/shaunsingh/moonlight.nvim"
  },
  ["nebulous.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nebulous.nvim",
    url = "https://github.com/Yagua/nebulous.nvim"
  },
  neon = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/neon",
    url = "https://github.com/rafamadriz/neon"
  },
  ["nightfox.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["null-ls.nvim"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14autopairs\20plugins.editing\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    config = { "require 'plugins.nvim.nvim-bufferline'" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    after = { "cmp-emoji", "nvim-autopairs", "friendly-snippets", "vim-vsnip", "cmp-cmdline-history", "cmp-vsnip", "cmp-nvim-lua", "cmp-path", "cmp-cmdline" },
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
    after = { "nvim-dap-virtual-text", "telescope-dap.nvim" },
    config = { "require 'plugins.lsp.nvim-dap'" },
    load_after = {
      ["nvim-dap-ui"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    after = { "nvim-dap" },
    load_after = {
      ["flutter-tools.nvim"] = true,
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
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
  ["nvim-lspconfig"] = {
    after = { "lsp-fastaction.nvim", "lua-dev.nvim", "nvim-dap-ui", "rust-tools.nvim", "renamer.nvim", "lsp-trouble.nvim", "flutter-tools.nvim" },
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0056\0\0\0'\2\1\0B\0\2\2B\0\1\1K\0\1\0\rlsp.init\frequire\0" },
    load_after = {
      ["cmp-nvim-lsp"] = true,
      ["lsp_signature.nvim"] = true,
      ["null-ls.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.nvim.notify\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-toggleterm.lua"] = {
    commands = { "ToggleTerm" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23plugins.toggleterm\frequire\0" },
    keys = { { "n", "<leader>tf" }, { "n", "<leader>tg" }, { "n", "<leader>tt" }, { "n", "<leader>tr" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14nvim_tree\21plugins.explorer\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require 'plugins.nvim-treesitter'" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["persisted.nvim"] = {
    config = { "require 'plugins.nvim.persisted'" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/persisted.nvim",
    url = "https://github.com/olimorris/persisted.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["present.nvim"] = {
    commands = { "Present", "PresentEnable", "PresentDisable" },
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fpresent\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/present.nvim",
    url = "/Users/chaitanyasharma/Projects/Languages/Lua/present.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n¥\3\0\0\6\0\18\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0026\3\n\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2=\3\14\2B\0\2\0016\0\0\0'\2\15\0B\0\2\0029\0\16\0'\2\17\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\rdatapath\tdata\fstdpath\afn\bvim\15ignore_lsp\1\2\0\0\fnull-ls\rpatterns\1\14\0\0\17pubspec.yaml\17package.json\14config.py\rsetup.py\15cargo.toml\rMakefile\rmakefile\t.git\15.gitignore\v_darcs\b.hg\t.bzr\t.svn\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16manual_mode\1\16show_hidden\1\17silent_chdir\2\nsetup\17project_nvim\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["renamer.nvim"] = {
    config = { "require 'plugins.lsp'.renamer()" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\nÉ\3\0\0\5\0\17\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0029\0\n\0\18\1\0\0'\3\v\0'\4\f\0B\1\3\1\18\1\0\0'\3\r\0'\4\14\0B\1\3\1\18\1\0\0'\3\15\0'\4\16\0B\1\3\1K\0\1\0\31:<Plug>RestNvimPreview<cr>\f<A-s-r>\28:<Plug>RestNvimLast<cr>\n<A-l>\24:<Plug>RestNvim<cr>\n<A-r>\rnnoremap\nutils\29custom_dynamic_variables\vresult\1\0\3\17show_headers\2\19show_http_info\2\rshow_url\2\14highlight\1\0\2\ftimeout\3–\1\fenabled\2\1\0\5\26skip_ssl_verification\1\28result_split_horizontal\2\20jump_to_request\2\renv_file\t.env\17yank_dry_run\2\nsetup\14rest-nvim\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim",
    url = "https://github.com/NTBBloodbath/rest.nvim"
  },
  ["rose-pine"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["spellsitter.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/surround.nvim",
    url = "https://github.com/Mephistophiles/surround.nvim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    config = { "\27LJ\2\nå\2\0\0\6\0\r\0\0176\0\0\0009\0\1\0005\1\3\0005\2\4\0=\2\5\0014\2\0\0=\2\6\1=\1\2\0006\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2\24:SymbolsOutline<CR>\n<M-s>\6n\20nvim_set_keymap\bapi\18lsp_blacklist\fkeymaps\1\0\6\17hover_symbol\14<C-space>\19focus_location\6o\18rename_symbol\6r\18goto_location\t<Cr>\17code_actions\6a\nclose\6q\1\0\4\16show_guides\2\27highlight_hovered_item\2\rposition\nright\17auto_preview\1\20symbols_outline\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
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
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    config = { "\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\30plugins.nvim.file_browser\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-file-browser.nvim", "project.nvim", "flutter-tools.nvim" },
    config = { "require 'plugins.explorer'.telescope()" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nÇ\4\0\0\6\0\26\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0005\5\14\0=\5\6\4=\4\15\0035\4\16\0005\5\17\0=\5\6\4=\4\18\0035\4\19\0005\5\20\0=\5\6\4=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\24\3=\3\25\2B\0\2\1K\0\1\0\14highlight\fexclude\1\0\6\nafter\afg\fpattern\21.*<(KEYWORDS)\\s*\18comments_only\2\17max_line_len\3\3\fkeyword\twide\vbefore\5\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tï¡§ \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tï™‘ \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tï± \ncolor\fwarning\tHACK\1\0\2\ncolor\fwarning\ticon\tï’ \tTODO\1\0\2\ncolor\tinfo\ticon\tï€Œ \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tï†ˆ \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["twilight.nvim"] = {
    commands = { "Twilight", "TwilightEnable" },
    config = { "\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fdimming\1\0\1\fcontext\3\15\1\0\2\nalpha\4\0€€Àþ\3\rinactive\2\nsetup\rtwilight\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["venn.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tvenn\22plugins.utilities\frequire\0" },
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
    config = { '\27LJ\2\n¾\3\0\0\2\0\n\0!6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0)\1\2\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0K\0\1\0\1\v\0\0\blua\tjson\15typescript\15javascript\18js=javascript\18ts=typescript\rshell=sh\vpython\ash\15console=sh"vim_markdown_fenced_languages\29vim_markdown_toc_autofit\27vim_markdown_autowrite+vim_markdown_no_extensions_in_markdown&vim_markdown_new_list_item_indent\31vim_markdown_strikethrough"vim_markdown_folding_disabled\6g\bvim\0' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-moonfly-colors"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-moonfly-colors",
    url = "https://github.com/bluz71/vim-moonfly-colors"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-nightfly-guicolors",
    url = "https://github.com/bluz71/vim-nightfly-guicolors"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    config = { "vim.g.startuptime_tries = 15" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-ultest"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.test\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-ultest",
    url = "https://github.com/rcarriga/vim-ultest"
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
  ["vn-night.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vn-night.nvim",
    url = "https://github.com/nxvu699134/vn-night.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nÅ\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\fplugins\1\0\0\fpresets\1\0\a\6z\2\bnav\2\fwindows\2\17text_objects\2\fmotions\2\14operators\2\6g\2\rspelling\1\0\0\1\0\2\16suggestions\3\20\fenabled\2\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { "\27LJ\2\n&\0\1\4\0\2\0\0046\1\0\0'\3\1\0B\1\2\1K\0\1\0\rZEN MODE\nprint)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16NORMAL MODE\nprintå\1\1\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\3=\3\v\0023\3\f\0=\3\r\0023\3\14\0=\3\15\2B\0\2\1K\0\1\0\ron_close\0\fon_open\0\fplugins\nkitty\1\0\2\tfont\a+4\fenabled\2\rgitsigns\1\0\0\1\0\1\fenabled\2\vwindow\1\0\0\1\0\2\rbackdrop\4\0€€ ÿ\3\nwidth\4š³æÌ\t™³¦ÿ\3\nsetup\rzen-mode\frequire\0" },
    keys = { { "", "<leader>z" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: persisted.nvim
time([[Config for persisted.nvim]], true)
require 'plugins.nvim.persisted'
time([[Config for persisted.nvim]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\23did_load_filetypes\6g\bvim\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14nvim_tree\21plugins.explorer\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
require 'plugins.nvim.nvim-bufferline'
time([[Config for nvim-bufferline.lua]], false)
-- Config for: vim-ultest
time([[Config for vim-ultest]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.test\frequire\0", "config", "vim-ultest")
time([[Config for vim-ultest]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PresentDisable lua require("packer.load")({'present.nvim'}, { cmd = "PresentDisable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PresentEnable lua require("packer.load")({'present.nvim'}, { cmd = "PresentEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Twilight lua require("packer.load")({'twilight.nvim'}, { cmd = "Twilight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerToggle lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TwilightEnable lua require("packer.load")({'twilight.nvim'}, { cmd = "TwilightEnable", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ColorizerAttachToBuffer lua require("packer.load")({'nvim-colorizer.lua'}, { cmd = "ColorizerAttachToBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Present lua require("packer.load")({'present.nvim'}, { cmd = "Present", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleTerm lua require("packer.load")({'nvim-toggleterm.lua'}, { cmd = "ToggleTerm", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <leader>z <cmd>lua require("packer.load")({'zen-mode.nvim'}, { keys = "<lt>leader>z", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tf <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>tf", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tr <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>tr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tg <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>tg", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <leader>tt <cmd>lua require("packer.load")({'nvim-toggleterm.lua'}, { keys = "<lt>leader>tt", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'mkdnflow.nvim', 'tabular', 'spellsitter.nvim', 'venn.nvim', 'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType txt ++once lua require("packer.load")({'spellsitter.nvim'}, { ft = "txt" }, _G.packer_plugins)]]
vim.cmd [[au FileType dart ++once lua require("packer.load")({'dart-code', 'dartlang-snippets', 'Flutter', 'flutter-snippets', 'dart-vim-plugin'}, { ft = "dart" }, _G.packer_plugins)]]
vim.cmd [[au FileType fish ++once lua require("packer.load")({'vim-fish'}, { ft = "fish" }, _G.packer_plugins)]]
vim.cmd [[au FileType http ++once lua require("packer.load")({'rest.nvim'}, { ft = "http" }, _G.packer_plugins)]]
vim.cmd [[au FileType https ++once lua require("packer.load")({'rest.nvim'}, { ft = "https" }, _G.packer_plugins)]]
vim.cmd [[au FileType rmd ++once lua require("packer.load")({'mkdnflow.nvim'}, { ft = "rmd" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'dependency-assist.nvim'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType graphql ++once lua require("packer.load")({'vim-graphql'}, { ft = "graphql" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'mkdnflow.nvim'}, { ft = "md" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'hop', 'lsp_extensions.nvim', 'null-ls.nvim', 'lsp_signature.nvim', 'gitsigns.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'surround.nvim', 'impatient.nvim', 'line-number-interval.nvim', 'which-key.nvim', 'telescope.nvim', 'tabular', 'HighStr.nvim', 'nvim-notify', 'copilot.vim', 'Comment.nvim', 'nvim-web-devicons', 'fidget.nvim', 'todo-comments.nvim', 'SchemaStore.nvim', 'cmp-nvim-lsp', 'conflict-marker.vim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'github-nvim-theme', 'kanagawa.nvim', 'vn-night.nvim', 'neon', 'lualine.nvim', 'material.nvim', 'moonlight.nvim', 'nebulous.nvim', 'nightfox.nvim', 'catppuccin', 'vim-nightfly-guicolors', 'rose-pine', 'tokyonight.nvim', 'Sakura.nvim', 'arch.nvim', 'blue-moon', 'calvera-dark.nvim', 'vim-moonfly-colors'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/rest.nvim/ftdetect/http.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/dartlang-snippets/ftdetect/gitignore.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
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
