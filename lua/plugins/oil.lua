return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup({
			columns = {},
			float = { max_width = 100 },
		})

		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
	end,
}
