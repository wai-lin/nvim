return {
	"folke/neodev.nvim",
	"folke/which-key.nvim",
	"MunifTanjim/nui.nvim",
	{ "nvim-tree/nvim-web-devicons", opts = {} },

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
			gui_style = { fg = "BOLD", bg = "BOLD" },
			highlight = { before = "", keyword = "wide_fg", after = "" },
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#fb2c36" },
				warning = { "DiagnosticWarn", "WarningMsg", "#ff6900" },
				info = { "DiagnosticInfo", "#00a6f4" },
				hint = { "DiagnosticHint", "#96f7e4" },
				default = { "Identifier", "#8e51ff" },
				test = { "Identifier", "#f0b100" },
			},
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
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
