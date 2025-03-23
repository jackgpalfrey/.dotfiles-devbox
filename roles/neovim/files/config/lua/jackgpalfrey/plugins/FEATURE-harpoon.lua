local harpoon = function()
	return require "harpoon"
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		harpoon():setup {
			settings = {
				save_on_toggle = true,
			},
		}

		-- -- basic telescope configuration
		-- local conf = require("telescope.config").values
		-- local function toggle_telescope(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, item.value)
		-- 	end
		--
		-- 	require("telescope.pickers")
		-- 		.new({}, {
		-- 			prompt_title = "Harpoon",
		-- 			finder = require("telescope.finders").new_table {
		-- 				results = file_paths,
		-- 			},
		-- 			previewer = conf.file_previewer {},
		-- 			sorter = conf.generic_sorter {},
		-- 		})
		-- 		:find()
		-- end

		-- vim.keymap.set("n", "<leader><C-e>", function()
		-- 	toggle_telescope(harpoon():list())
		-- end, { desc = "Open harpoon in telescope" })
	end,
	keys = {
		{
			"<leader>a",
			function()
				harpoon():list():add()
			end,
			desc = "[A]dd current buffer to harpoon",
		},
		{
			"<C-e>",
			function()
				harpoon().ui:toggle_quick_menu(harpoon():list())
			end,
			desc = "Show harpoon",
		},

		{
			"<leader>1",
			function()
				harpoon():list():select(1)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>2",
			function()
				harpoon():list():select(2)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>3",
			function()
				harpoon():list():select(3)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>4",
			function()
				harpoon():list():select(4)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>5",
			function()
				harpoon():list():select(5)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>6",
			function()
				harpoon():list():select(6)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>7",
			function()
				harpoon():list():select(7)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>8",
			function()
				harpoon():list():select(8)
			end,
			desc = "which_key_ignore",
		},
		{
			"<leader>9",
			function()
				harpoon():list():select(9)
			end,
			desc = "which_key_ignore",
		},
	},
}
