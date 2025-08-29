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

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			gui_style = {
				fg = "BOLD", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
		},
		-- TODO: hello
		-- TODO: hi
		config = function(_, opts)
			local todo_comments = require("todo-comments")
			todo_comments.setup(opts)

			vim.keymap.set("n", "<leader>ft", "<CMD>TodoLocList<CR><ESC>", { desc = "Search todo comments in project" })
		end,
	},
}
