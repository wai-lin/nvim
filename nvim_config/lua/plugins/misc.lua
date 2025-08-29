return {
	"folke/neodev.nvim",
	"folke/which-key.nvim",

	{
		"saghen/blink.nvim",
		lazy = false,
		opts = {
			chartoggle = { enabled = true },
		},
		keys = {
			-- chartoggle
			{
				"<C-;>",
				function()
					require("blink.chartoggle").toggle_char_eol(";")
				end,
				mode = { "n", "v" },
				desc = "Toggle ; at eol",
			},
			{
				",",
				function()
					require("blink.chartoggle").toggle_char_eol(",")
				end,
				mode = { "n", "v" },
				desc = "Toggle , at eol",
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>zm", "<CMD>lua require('zen-mode').toggle({})<CR>", { desc = "[Z]en [M]ode" })
		end,
	},
}
