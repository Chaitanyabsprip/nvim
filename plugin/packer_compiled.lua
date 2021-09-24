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
  ["JABS.nvim"] = {
    config = { "\27LJ\2\n”\2\0\0\5\0\r\2\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2:\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\6\0005\4\a\0=\4\b\0039\4\t\0\24\4\0\4=\4\n\0039\4\v\0\25\4\1\4=\4\f\3B\1\2\1K\0\1\0\brow\vheight\bcol\nwidth\fpreview\1\0\3\vborder\vdouble\vheight\3\30\nwidth\3d\1\0\5\vborder\vsingle\vheight\3\n\nwidth\3F\rposition\vcorner\21preview_position\vbottom\nsetup\tjabs\frequire\18nvim_list_uis\bapi\bvimµæÌ™\19™³†ÿ\3\4\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/JABS.nvim"
  },
  ["auto-session"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/auto-session"
  },
  ["awesome-flutter-snippets"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/awesome-flutter-snippets"
  },
  ["conflict-marker.vim"] = {
    config = { "\27LJ\2\nu\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\17^>>>>>>> .*$\24conflict_marker_end\17^<<<<<<< .*$\26conflict_marker_begin\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["dart-vim-plugin"] = {
    config = { "\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/dart-vim-plugin"
  },
  ["dependency-assist.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/dependency-assist.nvim"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  kommentary = {
    config = { "\27LJ\2\n«\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\3\31use_consistent_indentation\2 prefer_single_line_comments\2\22ignore_whitespace\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-fastaction.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp-fastaction.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["material.nvim"] = {
    config = { "\27LJ\2\nÞ\3\0\0\6\0\17\0)6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0+\1\2\0=\1\a\0006\0\0\0009\0\1\0+\1\1\0=\1\b\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2>:lua require('material.functions').toggle_style(true)<CR>\14<leader>m\6n\20nvim_set_keymap\bapi\15deep ocean\19material_style\30material_italic_variables\29material_italic_keywords\30material_italic_functions\29material_italic_comments material_disable_background\22material_contrast\21material_borders\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\2\ne\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\16number_only\1\20show_cursorline\2\17show_numbers\2\nsetup\tnumb\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-dap-ui"
  },
  ["nvim-gps"] = {
    config = { "\27LJ\2\n£\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\14languages\nicons\1\0\1\14separator\t -> \1\0\3\16method-name\tïš¦ \15class-name\tï – \18function-name\tïž” \nsetup\rnvim-gps\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-gps"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rthrottle\2\venable\2\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n¡\3\0\0\6\0\18\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0026\3\n\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2=\3\14\2B\0\2\0016\0\0\0'\2\15\0B\0\2\0029\0\16\0'\2\17\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\rdatapath\tdata\fstdpath\afn\bvim\15ignore_lsp\1\2\0\0\befm\rpatterns\1\14\0\0\17pubspec.yaml\17package.json\14config.py\rsetup.py\15cargo.toml\rMakefile\rmakefile\t.git\15.gitignore\v_darcs\b.hg\t.bzr\t.svn\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16show_hidden\1\16manual_mode\1\17silent_chdir\1\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\n¸\1\0\0\6\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2,<cmd>lua require('rest-nvim').run()<CR>\15<leader>rn\6n\20nvim_set_keymap\bapi\bvim\nsetup\14rest-nvim\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/rest.nvim"
  },
  ["rose-pine"] = {
    config = { "\27LJ\2\nŽ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0K\0\1\0!rose_pine_disable_background\29rose_pine_enable_italics\tbase\22rose_pine_variant\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/rose-pine"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["session-lens"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/session-lens"
  },
  snap = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/snap"
  },
  sniprun = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/sniprun"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["twilight.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "\27LJ\2\nk\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\n<C-u>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vgit.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vgit.nvim"
  },
  ["vim-fish"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-fish"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-ultest"] = {
    config = { "\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\25ultest_output_on_run\6g\bvim\0" },
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-ultest"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-workman"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/vim-workman"
  },
  ["visual-split.vim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/visual-split.vim"
  },
  ["yabs.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/yabs.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/Users/chaitanyasharma/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: JABS.nvim
time([[Config for JABS.nvim]], true)
try_loadstring("\27LJ\2\n”\2\0\0\5\0\r\2\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2:\0\1\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\6\0005\4\a\0=\4\b\0039\4\t\0\24\4\0\4=\4\n\0039\4\v\0\25\4\1\4=\4\f\3B\1\2\1K\0\1\0\brow\vheight\bcol\nwidth\fpreview\1\0\3\vborder\vdouble\vheight\3\30\nwidth\3d\1\0\5\vborder\vsingle\vheight\3\n\nwidth\3F\rposition\vcorner\21preview_position\vbottom\nsetup\tjabs\frequire\18nvim_list_uis\bapi\bvimµæÌ™\19™³†ÿ\3\4\0", "config", "JABS.nvim")
time([[Config for JABS.nvim]], false)
-- Config for: rose-pine
time([[Config for rose-pine]], true)
try_loadstring("\27LJ\2\nŽ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0K\0\1\0!rose_pine_disable_background\29rose_pine_enable_italics\tbase\22rose_pine_variant\6g\bvim\0", "config", "rose-pine")
time([[Config for rose-pine]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: conflict-marker.vim
time([[Config for conflict-marker.vim]], true)
try_loadstring("\27LJ\2\nu\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\17^>>>>>>> .*$\24conflict_marker_end\17^<<<<<<< .*$\26conflict_marker_begin\6g\bvim\0", "config", "conflict-marker.vim")
time([[Config for conflict-marker.vim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\rthrottle\2\venable\2\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: material.nvim
time([[Config for material.nvim]], true)
try_loadstring("\27LJ\2\nÞ\3\0\0\6\0\17\0)6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0006\0\0\0009\0\1\0+\1\2\0=\1\a\0006\0\0\0009\0\1\0+\1\1\0=\1\b\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0005\5\16\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2>:lua require('material.functions').toggle_style(true)<CR>\14<leader>m\6n\20nvim_set_keymap\bapi\15deep ocean\19material_style\30material_italic_variables\29material_italic_keywords\30material_italic_functions\29material_italic_comments material_disable_background\22material_contrast\21material_borders\6g\bvim\0", "config", "material.nvim")
time([[Config for material.nvim]], false)
-- Config for: dart-vim-plugin
time([[Config for dart-vim-plugin]], true)
try_loadstring("\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0", "config", "dart-vim-plugin")
time([[Config for dart-vim-plugin]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
try_loadstring("\27LJ\2\ne\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\16number_only\1\20show_cursorline\2\17show_numbers\2\nsetup\tnumb\frequire\0", "config", "numb.nvim")
time([[Config for numb.nvim]], false)
-- Config for: dependency-assist.nvim
time([[Config for dependency-assist.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0", "config", "dependency-assist.nvim")
time([[Config for dependency-assist.nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\2\n«\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\3\31use_consistent_indentation\2 prefer_single_line_comments\2\22ignore_whitespace\2\fdefault\23configure_language\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n¡\3\0\0\6\0\18\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0026\3\n\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2=\3\14\2B\0\2\0016\0\0\0'\2\15\0B\0\2\0029\0\16\0'\2\17\0B\0\2\1K\0\1\0\rprojects\19load_extension\14telescope\rdatapath\tdata\fstdpath\afn\bvim\15ignore_lsp\1\2\0\0\befm\rpatterns\1\14\0\0\17pubspec.yaml\17package.json\14config.py\rsetup.py\15cargo.toml\rMakefile\rmakefile\t.git\15.gitignore\v_darcs\b.hg\t.bzr\t.svn\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16show_hidden\1\16manual_mode\1\17silent_chdir\1\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nvim-gps
time([[Config for nvim-gps]], true)
try_loadstring("\27LJ\2\n£\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\14languages\nicons\1\0\1\14separator\t -> \1\0\3\16method-name\tïš¦ \15class-name\tï – \18function-name\tïž” \nsetup\rnvim-gps\frequire\0", "config", "nvim-gps")
time([[Config for nvim-gps]], false)
-- Config for: rest.nvim
time([[Config for rest.nvim]], true)
try_loadstring("\27LJ\2\n¸\1\0\0\6\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\fnoremap\2\vsilent\2,<cmd>lua require('rest-nvim').run()<CR>\15<leader>rn\6n\20nvim_set_keymap\bapi\bvim\nsetup\14rest-nvim\frequire\0", "config", "rest.nvim")
time([[Config for rest.nvim]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: vim-ultest
time([[Config for vim-ultest]], true)
try_loadstring("\27LJ\2\n6\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\25ultest_output_on_run\6g\bvim\0", "config", "vim-ultest")
time([[Config for vim-ultest]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
