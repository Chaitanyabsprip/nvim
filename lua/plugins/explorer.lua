local explorer = {}
local nnoremap = require("mappings.hashish").nnoremap

local highlight_override = function()
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NeogitHunkHeader" })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "NeogitHunkHeader" })
	vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "diffRemoved" })
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "Substitute" })
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "Search" })
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { link = "EndOfBuffer" })
end

local setkeymaps = function()
	local builtins = require("telescope.builtin")
	local themes = require("telescope.themes")
	local find_notes = function()
		builtins.fd({ cwd = "/Users/chaitanyasharma/Projects/Notes", hidden = true })
	end
	nnoremap("<A-p>")("<cmd>Telescope projects<CR>")({})("Telescope Projects")
	nnoremap("<leader>tht")(function()
		builtins.help_tags(themes.get_ivy({ layout_config = { height = 12 } }))
	end)({})("Telescope Help tags")
	nnoremap("<leader>thk")(function()
		builtins.keymaps(themes.get_ivy({ layout_config = { height = 12 } }))
	end)({})("Telescope Keymaps")
	nnoremap("<leader>thi")(function()
		builtins.higlights()
	end)({})("Telescope Higlights")
	nnoremap("<leader>gb")("<cmd> Telescope git_branches<CR>")({})("Telescope Git Branches")
	nnoremap("<leader>gc")("<cmd> Telescope git_status<cr>")({ silent = true })("Telescope git changes")
	nnoremap("<leader><space>")(function()
		builtins.fd()
	end)({ silent = true })("Telescope File Finder")
	nnoremap("<leader>fb")("<cmd>Telescope buffers previewer=false theme=dropdown initial_mode=normal<CR>")({
		silent = true,
	})("Telescope Buffers")
	nnoremap("<leader>fo")("<cmd> Telescope oldfiles<cr>")({ silent = true })("Telescope oldfiles")
	nnoremap("<leader>fg")("<cmd> Telescope live_grep<cr>")({ silent = true })("Telescope live grep")
	nnoremap("<leader>fw")("<cmd> Telescope grep_string<cr>")({ silent = true })("Telescope grep word under cursor")
	nnoremap("<leader>fn")(find_notes)({ silent = true })("Word Search")
end

explorer.telescope = {
	plug = {
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
		module = { "telescope.builtin", "telescope" },
		cmd = { "Telescope" },
		-- event = { "BufWinEnter" },
		config = function()
			require("plugins.explorer").telescope.setup()
		end,
	},

	setup = function()
		local actions = require("telescope.actions")

		local mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
			},
			n = {
				["q"] = actions.close,
				["<c-c>"] = actions.close,
			},
		}

		require("telescope").setup({
			defaults = {
				border = nil,
				borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				color_devicons = true,
				extensions = { file_browser = {} },
				file_ignore_patterns = {},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				initial_mode = "insert",
				layout_config = {
					horizontal = { mirror = false },
					vertical = { mirror = false },
					prompt_position = "top",
					height = 0.8,
					width = 0.9,
				},
				layout_strategy = "horizontal",
				mappings = mappings,
				path_display = { shorten = { len = 1, exclude = { -1 } } },
				prompt_prefix = "   ",
				selection_strategy = "reset",
				set_env = { ["COLORTERM"] = "truecolor" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		})
		setkeymaps()
		highlight_override()
	end,

	diagnostic_keymaps = function()
		local builtins = require("telescope.builtin")
		local themes = require("telescope.themes")
		local document_diagnostics_config = {
			layout_config = { height = 12 },
			bufnr = 0,
			initial_mode = "normal",
		}
		local workspace_diagnostics_config =
			{ layout_config = { height = 12, preview_width = 80 }, initial_mode = "normal" }
		nnoremap("<leader>dd")(function()
			builtins.diagnostics(themes.get_ivy(document_diagnostics_config))
		end)({})("Document diagnostics")
		nnoremap("<leader>dw")(function()
			builtins.diagnostics(themes.get_ivy(workspace_diagnostics_config))
		end)({})("Workspace diagnostics")
	end,
}

explorer.nvim_tree = {
	plug = {
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		cmd = { "Explorer" },
		config = function()
			require("plugins.explorer").nvim_tree.setup()
		end,
	},
	setup = function()
		vim.api.nvim_create_user_command("Explorer", "NvimTreeToggle", { nargs = 0 })
		function explorer.nvim_tree.grep_at_current_tree_node()
			local node = require("nvim-tree.lib").get_node_at_cursor()
			if not node then
				return
			end
			require("telescope.builtin").live_grep({
				search_dirs = { node.absolute_path },
			})
		end

		local tree_cb = require("nvim-tree.config").nvim_tree_callback
		local mappings = {
			custom_only = false,
			list = {
				{
					key = { "<Leader>gr", "gr" },
					cb = ":lua require'plugins.explorer'.nvim_tree.grep_at_current_tree_node()<CR>",
					mode = "n",
				},
				{ key = { "<CR>", "<2-LeftMouse>", "l" }, cb = tree_cb("edit") },
				{ key = { "<2-RightMouse>", "<C-]>", "cd" }, cb = tree_cb("cd") },
				{ key = { "<C-v>", "v" }, cb = tree_cb("vsplit") },
				{ key = { "<C-x>", "s" }, cb = tree_cb("split") },
				{ key = { "<BS>", "h", "<S-CR>" }, cb = tree_cb("close_node") },
				{ key = { "o" }, cb = tree_cb("system_open") },
			},
		}
		require("nvim-tree").setup({
			diagnostics = { debounce_delay = 400, enable = true, show_on_dirs = true, show_on_open_dirs = false },
			filters = { dotfiles = false },
			git = { enable = true, ignore = true, show_on_open_dirs = false, timeout = 400 },
			renderer = {
				add_trailing = true,
				full_name = true,
				highlight_git = true,
				indent_markers = { enable = true },
			},
			trash = { cmd = "trash", require_confirm = true },
			sync_root_with_cwd = true,
			update_focused_file = { enable = true },
			view = {
				centralize_selection = true,
				mappings = mappings,
				preserve_window_proportions = true,
				side = "right",
				width = 40,
			},
		})
	end,
}

explorer.plug = { explorer.telescope.plug, explorer.nvim_tree.plug }
return explorer
