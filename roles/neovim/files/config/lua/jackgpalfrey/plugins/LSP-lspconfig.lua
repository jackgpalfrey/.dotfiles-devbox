-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
--
-- This can vary by config, but in general for nvim-lspconfig:

local map = vim.keymap.set

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"b0o/schemastore.nvim",
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- Update imports on file rename
		"folke/lazydev.nvim",
	},

	config = function()
		-- example using `opts` for defining servers
		local opts = {
			servers = {
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
			},
		}

		local lspconfig = require "lspconfig"

		-- Global Diagnostic keymaps
		map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
		map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
		map("n", "<leader>de", vim.diagnostic.open_float, { desc = "[E]xpand floating [d]iagnostic message" })
		map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "[D]iagnostics [q]uicklist" })

		-- Diagnostics Config
		vim.diagnostic.config {
			virtual_text = true,
			update_in_insert = false,
			underline = true,
			float = {
				focusable = true,
				style = "minimal",
				source = true,
				header = "",
				prefix = "",
			},
		}

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local lsp = vim.lsp.buf
				local telebin = require "telescope.builtin"

				vim.api.nvim_buf_create_user_command(ev.buf, "Format", function()
					lsp.format { async = true }
				end, { nargs = 0 })

				vim.api.nvim_buf_create_user_command(ev.buf, "ToggleInlayHints", function()
					local currentState = vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf }
					vim.lsp.inlay_hint.enable(not currentState, { bufnr = ev.buf })
				end, { nargs = 0 })

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				map("n", "<leader>rn", lsp.rename, { buffer = ev.buf, desc = "[R]e[n]ame" })
				map({ "n", "v" }, "<leader>ca", lsp.code_action, { buffer = ev.buf, desc = "[C]ode [A]ction" })

				map("n", "gd", telebin.lsp_definitions, { buffer = ev.buf, desc = "[G]oto [D]efinition" })
				map("n", "gr", telebin.lsp_references, { buffer = ev.buf, desc = "[G]oto [R]eferences" })
				map("n", "gi", telebin.lsp_implementations, { buffer = ev.buf, desc = "[G]oto [I]mplementations" })
				map("n", "gt", telebin.lsp_type_definitions, { buffer = ev.buf, desc = "[G]oto [T]ype Definitions" })
				map("n", "gD", lsp.declaration, { buffer = ev.buf, desc = "[G]oto [D]eclaration" })

				map("n", "K", lsp.hover, { buffer = ev.buf, desc = "[K] Hover Documentation" })
				map({ "n", "i" }, "<C-k>", lsp.signature_help, { buffer = ev.buf, desc = "[C-k] Signature Documentation" })

				map("n", "<leader>wa", lsp.add_workspace_folder, { buffer = ev.buf, desc = "[W]orkspace [A]dd folder" })
				map("n", "<leader>wr", lsp.remove_workspace_folder, { buffer = ev.buf, desc = "[W]orkspace [R]emove folder" })
				map("n", "<leader>wl", function()
					print(vim.inspect(lsp.list_workspace_folders()))
				end, { buffer = ev.buf, desc = "[W]orkspace [L]ist Folders" })

				-- map("n", "<leader>f", vim.cmd.Format, { buffer = ev.buf, desc = "[F]ormat" })

				map("n", "<leader>th", vim.cmd.ToggleInlayHints, { buffer = ev.buf, desc = "[T]oggle Inlay [H]ints" })
			end,
		})

		local on_attach = function(client, bufnr)
			if client.supports_method "textDocument/inlayHint" then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config.on_attach = on_attach

			if server == "lua_ls" then
				require("lazydev").setup()
			end

			lspconfig[server].setup(config)
		end
	end,
}
