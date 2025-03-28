return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "catppuccin"
	end,
	opts = {
		integrations = {
			telescope = { enabled = true },
            blink_cmp = true
		},
	},
}
