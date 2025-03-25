Linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	-- python = { "pylint" },
}

Formatters_by_ft = {
	lua = { "stylua" },
	python = { "isort", "black" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	svelte = { "prettier" },
	css = { "prettier" },
	html = { "prettier" },
	htmldjango = { "djlint" },
	json = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	graphql = { "prettier" },
	templ = {},
}

LSP_servers = {
	lua_ls = {},
	emmet_ls = {
		filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
	},
	tailwindcss = {
		filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
	},
	ts_ls = {
		runtime = { version = "LuaJIT" },
		settings = {
			Lua = {
				hint = {
					enable = true,
					semicolon = "All",
					setType = true,
				},
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	svelte = {},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					jedi_completion = { fuzzy = true },
					pycodestyle = { enabled = true },
				},
			},
		},
	},
	html = {},
	cssls = {},
	graphql = {},
	prismals = {},
	-- pyright = {},
	gopls = {},
}

TS_ensure_installed = { "c", "cpp", "go", "lua", "jinja", "python", "rust", "tsx", "json", "javascript", "typescript", "yaml", "html", "css", "prisma", "markdown", "markdown_inline", "svelte", "graphql", "vimdoc", "vim", "bash", "dockerfile", "gitignore", "query" }
LSP_ensure_installed = {}
Tool_ensure_installed = {}

-------------------------------------------------------------------------------
------------------------------- Auto population -------------------------------
-------------------------------------------------------------------------------
--- Tools
local tool_ensure_installed_temp = {}

for _, tools in pairs(Linters_by_ft) do
	for _, tool in pairs(tools) do
		tool_ensure_installed_temp[tool] = true
	end
end
for _, tools in pairs(Formatters_by_ft) do
	for _, tool in pairs(tools) do
		tool_ensure_installed_temp[tool] = true
	end
end

for tool, _ in pairs(tool_ensure_installed_temp) do
	table.insert(Tool_ensure_installed, tool)
end

--- LSP Servers

for server, _ in pairs(LSP_servers) do
	table.insert(LSP_ensure_installed, server)
end
