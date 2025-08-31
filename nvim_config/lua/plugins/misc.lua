return {
	"folke/neodev.nvim",
	"folke/which-key.nvim",
	"MunifTanjim/nui.nvim",

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
		config = function(_, opts)
			local todo_comments = require("todo-comments")
			todo_comments.setup(opts)

			vim.keymap.set("n", "<leader>ft", "<CMD>TodoLocList<CR><ESC>", { desc = "Search todo comments in project" })
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "<m-f>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "<c-f>", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
}
