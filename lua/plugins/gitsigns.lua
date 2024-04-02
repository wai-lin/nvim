return {
	"lewis6991/gitsigns.nvim",
	event = "VimEnter",
	config = function()
		require("gitsigns").setup({})

		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "[G]itSigns: [B]lame line" })
	end,
}
