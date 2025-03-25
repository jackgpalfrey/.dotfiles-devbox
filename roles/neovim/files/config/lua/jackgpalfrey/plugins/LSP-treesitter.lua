return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		local treesitter = require "nvim-treesitter.configs"

		require "jackgpalfrey.config"

		treesitter.setup {
			ensure_installed = TS_ensure_installed,
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true },

			-- Seems to cause errors
			incremental_selection = {
				enable = false,
				keymaps = {
					init_selection = "<C-space>", -- set to `false` to disable one of the mappings
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			textobjects = {
				select = { enable = true, lookahead = true },
				move = { set_jumps = true },
				swap = { enable = true },
			},

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		}
	end,
}
