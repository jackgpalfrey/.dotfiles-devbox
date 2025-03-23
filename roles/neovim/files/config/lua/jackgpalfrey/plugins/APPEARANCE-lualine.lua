return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require "lualine"
		local lazy_status = require "lazy.status"

		lualine.setup {
			options = {
				theme = "catppuccin-mocha",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { {
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = "#ff9e64" },
				}, "encoding", "fileformat", "filetype" },
				lualine_y = { "searchcount", "selectioncount", "progress" },
				lualine_z = { "location" },
			},
		}
	end,
}
