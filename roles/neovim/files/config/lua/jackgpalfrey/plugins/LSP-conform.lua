return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require "conform"

		conform.setup {
			formatters_by_ft = {
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
			},
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local disable_filetypes = { c = false, cpp = false }
				return {
					timeout_ms = 500,
					async = false,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
		}

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			}
		end, { desc = "[F]ormat file or visual selection" })

		vim.keymap.set({ "n" }, "<leader>tf", function()
			-- If autoformat is currently disabled for this buffer,
			-- then enable it, otherwise disable it
			if vim.b.disable_autoformat then
				vim.cmd "FormatEnable"
				vim.notify "Enabled autoformat for current buffer"
			else
				vim.cmd "FormatDisable!"
				vim.notify "Disabled autoformat for current buffer"
			end
		end, { desc = "Toggle autoformat for current buffer" })

		vim.keymap.set({ "n" }, "<leader>tF", function()
			-- If autoformat is currently disabled globally,
			-- then enable it globally, otherwise disable it globally
			if vim.g.disable_autoformat then
				vim.cmd "FormatEnable"
				vim.notify "Enabled autoformat globally"
			else
				vim.cmd "FormatDisable"
				vim.notify "Disabled autoformat globally"
			end
		end, { desc = "Toggle autoformat globally" })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- :FormatDisable! disables autoformat for this buffer only
				vim.b.disable_autoformat = true
			else
				-- :FormatDisable disables autoformat globally
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true, -- allows the ! variant
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		-- Formatter config
		require("conform").formatters.djlint = {
			prepend_args = { "--indent", "2" },
		}
	end,
}
