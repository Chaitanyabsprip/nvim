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
  local success, result = pcall(loadstring(s))
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
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["JABS.nvim"] = {
    config = { "\27LJ\2\n”\2\0\0\5\0\r\2\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2:\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\6\0005\4\a\0=\4\b\0039\4\t\0\24\4\0\4=\4\n\0039\4\v\0\25\4\1\4=\4\f\3B\1\2\1K\0\1\0\brow\vheight\bcol\nwidth\fpreview\1\0\3\vborder\vdouble\vheight\3\30\nwidth\3d\1\0\5\rposition\vcorner\21preview_position\vbottom\vborder\vsingle\vheight\3\n\nwidth\3F\nsetup\tjabs\frequire\18nvim_list_uis\bapi\bvimµæÌ™\19™³†ÿ\3\4\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/JABS.nvim",
    url = "https://github.com/matbme/JABS.nvim"
  },
  ["auto-session"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["awesome-flutter-snippets"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/awesome-flutter-snippets",
    url = "https://github.com/Nash0x7E2/awesome-flutter-snippets"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim",
    url = "https://github.com/yashguptaz/calvera-dark.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["conflict-marker.vim"] = {
    config = { "\27LJ\2\n³\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\17^>>>>>>> .*$\24conflict_marker_end\17^||||||| .*$%conflict_marker_common_ancestors\17^<<<<<<< .*$\26conflict_marker_begin\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["dart-vim-plugin"] = {
    config = { "\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/dart-vim-plugin",
    url = "https://github.com/dart-lang/dart-vim-plugin"
  },
  ["dependency-assist.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/dependency-assist.nvim",
    url = "https://github.com/akinsho/dependency-assist.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\n4\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\23did_load_filetypes\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lsp-fastaction.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp-fastaction.nvim",
    url = "https://github.com/windwp/lsp-fastaction.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim",
    url = "https://github.com/folke/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress",
    url = "https://github.com/arkav/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rthrottle\2\venable\2\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
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
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n¡\3\0\0\6\0\18\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0026\3\n\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2=\3\14\2B\0\2\0016\0\0\0'\2\15\0B\0\2\0029\0\16\0'\2\17\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\rdatapath\tdata\fstdpath\afn\bvim\15ignore_lsp\1\2\0\0\befm\rpatterns\1\14\0\0\17pubspec.yaml\17package.json\14config.py\rsetup.py\15cargo.toml\rMakefile\rmakefile\t.git\15.gitignore\v_darcs\b.hg\t.bzr\t.svn\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16manual_mode\1\17silent_chdir\1\16show_hidden\1\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rose-pine"] = {
    config = { "\27LJ\2\nŽ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0K\0\1\0!rose_pine_disable_background\29rose_pine_enable_italics\tbase\22rose_pine_variant\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["session-lens"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/session-lens",
    url = "https://github.com/rmagatti/session-lens"
  },
  snap = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/snap",
    url = "https://github.com/camspiers/snap"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/surround.nvim",
    url = "https://github.com/blackCauldron7/surround.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n±\4\0\0\2\0\17\00116\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\0\0009\0\1\0+\1\1\0=\1\a\0006\0\0\0009\0\1\0+\1\2\0=\1\b\0006\0\0\0009\0\1\0+\1\2\0=\1\t\0006\0\0\0009\0\1\0+\1\2\0=\1\n\0006\0\0\0009\0\1\0+\1\1\0=\1\v\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0006\0\0\0009\0\1\0'\1\15\0=\1\14\0006\0\0\0009\0\1\0+\1\1\0=\1\16\0K\0\1\0\27tokyonight_transparent\nstorm\21tokyonight_style\1\2\0\0\vpacker\24tokyonight_sidebars tokyonight_italic_variables\31tokyonight_italic_keywords tokyonight_italic_functions\31tokyonight_italic_comments(tokyonight_hide_inactive_statusline\30tokyonight_day_brightness\28tokyonight_dark_sidebar\26tokyonight_dark_float\1\0\2\vborder\f#7aa2f7\abg\f#262C3A\22tokyonight_colors\6g\bvimçÌ™³\6³æÌþ\3\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["vim-fish"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-fish",
    url = "https://github.com/dag/vim-fish"
  },
  ["vim-graphql"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-graphql",
    url = "https://github.com/jparise/vim-graphql"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-ultest"] = {
    config = { "\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\25ultest_output_on_run\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-ultest",
    url = "https://github.com/rcarriga/vim-ultest"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n¡\3\0\0\6\0\18\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0026\3\n\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2=\3\14\2B\0\2\0016\0\0\0'\2\15\0B\0\2\0029\0\16\0'\2\17\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\rdatapath\tdata\fstdpath\afn\bvim\15ignore_lsp\1\2\0\0\befm\rpatterns\1\14\0\0\17pubspec.yaml\17package.json\14config.py\rsetup.py\15cargo.toml\rMakefile\rmakefile\t.git\15.gitignore\v_darcs\b.hg\t.bzr\t.svn\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16manual_mode\1\17silent_chdir\1\16show_hidden\1\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: conflict-marker.vim
time([[Config for conflict-marker.vim]], true)
try_loadstring("\27LJ\2\n³\1\0\0\2\0\b\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\17^>>>>>>> .*$\24conflict_marker_end\17^||||||| .*$%conflict_marker_common_ancestors\17^<<<<<<< .*$\26conflict_marker_begin\6g\bvim\0", "config", "conflict-marker.vim")
time([[Config for conflict-marker.vim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rthrottle\2\venable\2\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\23did_load_filetypes\6g\bvim\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: JABS.nvim
time([[Config for JABS.nvim]], true)
try_loadstring("\27LJ\2\n”\2\0\0\5\0\r\2\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2:\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\6\0005\4\a\0=\4\b\0039\4\t\0\24\4\0\4=\4\n\0039\4\v\0\25\4\1\4=\4\f\3B\1\2\1K\0\1\0\brow\vheight\bcol\nwidth\fpreview\1\0\3\vborder\vdouble\vheight\3\30\nwidth\3d\1\0\5\rposition\vcorner\21preview_position\vbottom\vborder\vsingle\vheight\3\n\nwidth\3F\nsetup\tjabs\frequire\18nvim_list_uis\bapi\bvimµæÌ™\19™³†ÿ\3\4\0", "config", "JABS.nvim")
time([[Config for JABS.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n±\4\0\0\2\0\17\00116\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0*\1\0\0=\1\6\0006\0\0\0009\0\1\0+\1\1\0=\1\a\0006\0\0\0009\0\1\0+\1\2\0=\1\b\0006\0\0\0009\0\1\0+\1\2\0=\1\t\0006\0\0\0009\0\1\0+\1\2\0=\1\n\0006\0\0\0009\0\1\0+\1\1\0=\1\v\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0006\0\0\0009\0\1\0'\1\15\0=\1\14\0006\0\0\0009\0\1\0+\1\1\0=\1\16\0K\0\1\0\27tokyonight_transparent\nstorm\21tokyonight_style\1\2\0\0\vpacker\24tokyonight_sidebars tokyonight_italic_variables\31tokyonight_italic_keywords tokyonight_italic_functions\31tokyonight_italic_comments(tokyonight_hide_inactive_statusline\30tokyonight_day_brightness\28tokyonight_dark_sidebar\26tokyonight_dark_float\1\0\2\vborder\f#7aa2f7\abg\f#262C3A\22tokyonight_colors\6g\bvimçÌ™³\6³æÌþ\3\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: dart-vim-plugin
time([[Config for dart-vim-plugin]], true)
try_loadstring("\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0", "config", "dart-vim-plugin")
time([[Config for dart-vim-plugin]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: rose-pine
time([[Config for rose-pine]], true)
try_loadstring("\27LJ\2\nŽ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0K\0\1\0!rose_pine_disable_background\29rose_pine_enable_italics\tbase\22rose_pine_variant\6g\bvim\0", "config", "rose-pine")
time([[Config for rose-pine]], false)
-- Config for: vim-ultest
time([[Config for vim-ultest]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\25ultest_output_on_run\6g\bvim\0", "config", "vim-ultest")
time([[Config for vim-ultest]], false)
-- Config for: dependency-assist.nvim
time([[Config for dependency-assist.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0", "config", "dependency-assist.nvim")
time([[Config for dependency-assist.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
