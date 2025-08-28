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
}
