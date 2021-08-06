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
local package_path_str = "/home/chaitanya/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/chaitanya/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/chaitanya/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/chaitanya/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/chaitanya/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["awesome-flutter-snippets"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/awesome-flutter-snippets"
  },
  ["ayu-vim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/ayu-vim"
  },
  ["blue-moon"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/blue-moon"
  },
  ["dart-vim-plugin"] = {
    config = { "\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/dart-vim-plugin"
  },
  ["dependency-assist.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/dependency-assist.nvim"
  },
  dracula = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/dracula"
  },
  flattened = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/flattened"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim"
  },
  ["focus.nvim"] = {
    config = { "\27LJ\2\nâ\1\0\0\3\0\b\0\0166\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0)\1x\0=\1\3\0)\1(\0=\1\4\0)\1\25\0=\1\5\0+\1\2\0=\1\6\0+\1\2\0=\1\a\0K\0\1\0\15signcolumn\15cursorline\14treewidth\vheight\nwidth\venable\nfocus\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/focus.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/github-nvim-theme"
  },
  kommentary = {
    config = { "\27LJ\2\n´\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\3 prefer_single_line_comments\2\22ignore_whitespace\2\31use_consistent_indentation\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-fastaction.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lsp-fastaction.nvim"
  },
  ["lsp-rooter.nvim"] = {
    config = { "\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15ignore_lsp\1\0\0\1\2\0\0\befm\nsetup\15lsp-rooter\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lsp-rooter.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  ["moonlight.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/moonlight.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugin-config.toggleterm\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rest.nvim"] = {
    config = { "\27LJ\2\n∏\1\0\0\6\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2,<cmd>lua require('rest-nvim').run()<CR>\15<leader>rn\6n\20nvim_set_keymap\bapi\bvim\nsetup\14rest-nvim\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/rest.nvim"
  },
  snap = {
    config = { "\27LJ\2\ní\2\0\0\t\1\v\2#-\0\0\0009\0\0\0005\2\4\0-\3\0\0009\3\1\3'\5\2\0B\3\2\2*\5\0\0-\6\0\0009\6\1\6'\b\3\0B\6\2\0A\3\1\2=\3\5\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\a\3=\3\a\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\b\3=\3\b\0024\3\3\0-\4\0\0009\4\1\4'\6\t\0B\4\2\0?\4\1\0=\3\n\2B\0\2\1K\0\1\0\0¿\nviews\20preview.vimgrep\16multiselect\vselect\19select.vimgrep\rproducer\1\0\0\29producer.ripgrep.vimgrep\19consumer.limit\bget\brun¿ö\f\3ÄÄ¿ô\4Ä\2\0\0\b\1\v\1\"-\0\0\0009\0\0\0005\2\4\0-\3\0\0009\3\1\3'\5\2\0B\3\2\2-\5\0\0009\5\1\5'\a\3\0B\5\2\0A\3\0\2=\3\5\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\a\3=\3\a\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\b\3=\3\b\0024\3\3\0-\4\0\0009\4\1\4'\6\t\0B\4\2\0?\4\0\0=\3\n\2B\0\2\1K\0\1\0\0¿\nviews\17preview.file\16multiselect\vselect\16select.file\rproducer\1\0\0\26producer.ripgrep.file\17consumer.fzf\bget\brun\3ÄÄ¿ô\4ë\1\1\0\6\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0005\4\5\0003\5\6\0B\1\4\0019\1\2\0009\1\3\0015\3\a\0005\4\b\0003\5\t\0B\1\4\0012\0\0ÄK\0\1\0\0\1\2\0\0\15<Leader>ff\1\2\0\0\6n\0\1\2\0\0\15<Leader>fg\1\2\0\0\6n\bmap\rregister\tsnap\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/snap"
  },
  ["surround.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  ["tabout.nvim"] = {
    config = { "\27LJ\2\n»\2\0\0\5\0\r\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\b\0005\4\4\0>\4\1\0035\4\5\0>\4\2\0035\4\6\0>\4\3\0035\4\a\0>\4\4\0035\4\b\0>\4\5\0035\4\t\0>\4\6\0035\4\n\0>\4\a\3=\3\v\0024\3\0\0=\3\f\2B\0\2\1K\0\1\0\fexclude\ftabouts\1\0\2\topen\6<\nclose\6>\1\0\2\topen\6{\nclose\6}\1\0\2\topen\6[\nclose\6]\1\0\2\topen\6(\nclose\6)\1\0\2\topen\6`\nclose\6`\1\0\2\topen\6\"\nclose\6\"\1\0\2\topen\6'\nclose\6'\1\0\4\21ignore_beginning\2\15completion\2\15act_as_tab\2\vtabkey\n<Tab>\nsetup\vtabout\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/opt/tabout.nvim",
    wants = { "nvim-treesitter" }
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n©\3\0\0\6\0\23\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\21\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0005\5\r\0=\5\5\4=\4\14\0035\4\15\0005\5\16\0=\5\5\4=\4\17\0035\4\18\0005\5\19\0=\5\5\4=\4\20\3=\3\22\2B\0\2\1K\0\1\0\rkeywords\1\0\0\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ticon\tÔíê \ncolor\fwarning\tTODO\1\0\2\ticon\tÔÄå \ncolor\tinfo\bFIX\1\0\0\balt\1\6\0\0\nFIXME\bBUG\nFIXIT\nISSUE\bXXX\1\0\2\ticon\tÔÜà \ncolor\nerror\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["twilight.nvim"] = {
    commands = { "Twilight" },
    config = { "\27LJ\2\nÿ\1\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\0025\3\b\0=\3\t\0024\3\0\0=\3\n\2B\0\2\1K\0\1\0\fexclude\vexpand\1\5\0\0\rfunction\vmethod\ntable\17if_statement\fdimming\1\0\1\fcontext\3\n\ncolor\1\3\0\0\vNormal\f#ffffff\1\0\2\rinactive\2\nalpha\4\0ÄÄ¿˛\3\nsetup\rtwilight\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/opt/twilight.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "\27LJ\2\nk\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\n<C-u>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-substrata"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/vim-substrata"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/start/wilder.nvim"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { "\27LJ\2\n&\0\1\4\0\2\0\0046\1\0\0'\3\1\0B\1\2\1K\0\1\0\rZEN MODE\nprint)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16NORMAL MODE\nprintï\1\1\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0023\3\b\0=\3\t\0023\3\n\0=\3\v\2B\0\2\1K\0\1\0\ron_close\0\fon_open\0\fplugins\1\0\0\nkitty\1\0\0\1\0\2\tfont\a+4\fenabled\2\nsetup\rzen-mode\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/chaitanya/.local/share/nvim/site/pack/packer/opt/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: snap
time([[Config for snap]], true)
try_loadstring("\27LJ\2\ní\2\0\0\t\1\v\2#-\0\0\0009\0\0\0005\2\4\0-\3\0\0009\3\1\3'\5\2\0B\3\2\2*\5\0\0-\6\0\0009\6\1\6'\b\3\0B\6\2\0A\3\1\2=\3\5\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\a\3=\3\a\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\b\3=\3\b\0024\3\3\0-\4\0\0009\4\1\4'\6\t\0B\4\2\0?\4\1\0=\3\n\2B\0\2\1K\0\1\0\0¿\nviews\20preview.vimgrep\16multiselect\vselect\19select.vimgrep\rproducer\1\0\0\29producer.ripgrep.vimgrep\19consumer.limit\bget\brun¿ö\f\3ÄÄ¿ô\4Ä\2\0\0\b\1\v\1\"-\0\0\0009\0\0\0005\2\4\0-\3\0\0009\3\1\3'\5\2\0B\3\2\2-\5\0\0009\5\1\5'\a\3\0B\5\2\0A\3\0\2=\3\5\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\a\3=\3\a\2-\3\0\0009\3\1\3'\5\6\0B\3\2\0029\3\b\3=\3\b\0024\3\3\0-\4\0\0009\4\1\4'\6\t\0B\4\2\0?\4\0\0=\3\n\2B\0\2\1K\0\1\0\0¿\nviews\17preview.file\16multiselect\vselect\16select.file\rproducer\1\0\0\26producer.ripgrep.file\17consumer.fzf\bget\brun\3ÄÄ¿ô\4ë\1\1\0\6\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0005\4\5\0003\5\6\0B\1\4\0019\1\2\0009\1\3\0015\3\a\0005\4\b\0003\5\t\0B\1\4\0012\0\0ÄK\0\1\0\0\1\2\0\0\15<Leader>ff\1\2\0\0\6n\0\1\2\0\0\15<Leader>fg\1\2\0\0\6n\bmap\rregister\tsnap\frequire\0", "config", "snap")
time([[Config for snap]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rsurround\frequire\0", "config", "surround.nvim")
time([[Config for surround.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: lsp-rooter.nvim
time([[Config for lsp-rooter.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\15ignore_lsp\1\0\0\1\2\0\0\befm\nsetup\15lsp-rooter\frequire\0", "config", "lsp-rooter.nvim")
time([[Config for lsp-rooter.nvim]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\2\n´\1\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\3 prefer_single_line_comments\2\22ignore_whitespace\2\31use_consistent_indentation\2\fdefault\23configure_language\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Config for: focus.nvim
time([[Config for focus.nvim]], true)
try_loadstring("\27LJ\2\nâ\1\0\0\3\0\b\0\0166\0\0\0'\2\1\0B\0\2\2+\1\2\0=\1\2\0)\1x\0=\1\3\0)\1(\0=\1\4\0)\1\25\0=\1\5\0+\1\2\0=\1\6\0+\1\2\0=\1\a\0K\0\1\0\15signcolumn\15cursorline\14treewidth\vheight\nwidth\venable\nfocus\frequire\0", "config", "focus.nvim")
time([[Config for focus.nvim]], false)
-- Config for: dart-vim-plugin
time([[Config for dart-vim-plugin]], true)
try_loadstring("\27LJ\2\nh\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0#let dart_html_in_string=v:true\bcmd\24dart_format_on_save\6g\bvim\0", "config", "dart-vim-plugin")
time([[Config for dart-vim-plugin]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugin-config.toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n©\3\0\0\6\0\23\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\21\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0005\5\r\0=\5\5\4=\4\14\0035\4\15\0005\5\16\0=\5\5\4=\4\17\0035\4\18\0005\5\19\0=\5\5\4=\4\20\3=\3\22\2B\0\2\1K\0\1\0\rkeywords\1\0\0\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ticon\tÔíê \ncolor\fwarning\tTODO\1\0\2\ticon\tÔÄå \ncolor\tinfo\bFIX\1\0\0\balt\1\6\0\0\nFIXME\bBUG\nFIXIT\nISSUE\bXXX\1\0\2\ticon\tÔÜà \ncolor\nerror\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: dependency-assist.nvim
time([[Config for dependency-assist.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22dependency_assist\frequire\0", "config", "dependency-assist.nvim")
time([[Config for dependency-assist.nvim]], false)
-- Config for: rest.nvim
time([[Config for rest.nvim]], true)
try_loadstring("\27LJ\2\n∏\1\0\0\6\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2,<cmd>lua require('rest-nvim').run()<CR>\15<leader>rn\6n\20nvim_set_keymap\bapi\bvim\nsetup\14rest-nvim\frequire\0", "config", "rest.nvim")
time([[Config for rest.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Twilight lua require("packer.load")({'twilight.nvim'}, { cmd = "Twilight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
