return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- Help install Non-LSPs
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mason = require "mason"
		local mason_lspconfig = require "mason-lspconfig"

		local mason_tool_installer = require "mason-tool-installer"

		mason.setup {}

		mason_lspconfig.setup {
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"jsonls",
				"gopls",
				"yamlls",
				"tailwindcss",
			},
		}

		mason_tool_installer.setup {
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
				"djlint",
			},
		}
	end,
}
