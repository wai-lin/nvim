return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.icons").setup()
			require("mini.notify").setup()
			require("mini.pairs").setup()
			require("mini.ai").setup()
			require("mini.cursorword").setup()
			require("mini.move").setup()

			-- MiniFiles
			require("mini.files").setup()
			vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open file explorer" })

			require("mini.extra").setup()
			require("mini.git").setup()
			require("mini.diff").setup()
			require("mini.statusline").setup()
		end,
		---@module 'mini'
		---@type mini.SetupOpts
		opts = {},
	},
}
