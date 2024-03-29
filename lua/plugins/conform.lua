local formatters_by_ft = {
	lua = { "stylua" },
	javascript = { { "prettierd", "prettier" } },
	typescript = { { "prettierd", "prettier" } },
	javascriptreact = { { "prettierd", "prettier" } },
	typescriptreact = { { "prettierd", "prettier" } },
	vue = { { "prettierd", "prettier" } },
	go = { "gofumpt", "goimports-reviser" },
}

return {
	"stevearc/conform.nvim",
	event = "VimEnter",
	config = function()
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end

			require("conform").format({
				async = true,
				lsp_fallback = true,
				range = range,
			})
		end, { range = true })

		vim.keymap.set("n", "<leader>fm", "<CMD>Format<CR>", { desc = "[F]or[m]at Current Buffer" })
	end,
}
