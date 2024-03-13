return {
	"stevearc/conform.nvim",
	event = "VimEnter",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { { "prettierd", "prettier" } },
			vue = { { "prettierd", "prettier" } },
			go = { "gofumpt", "goimports-reviser" },
		},
	},
	config = function()
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end

			local filetype = vim.bo.filetype
			local lsp_fallback = function()
				if filetype == "vue" then
					return false
				else
					return true
				end
			end
			print(filetype, lsp_fallback())

			require("conform").format({
				async = true,
				lsp_fallback = lsp_fallback(),
				range = range,
			})
		end, { range = true })

		vim.keymap.set("n", "<leader>fm", "<CMD>Format<CR>", { desc = "[F]or[m]at Current Buffer" })
	end,
}
