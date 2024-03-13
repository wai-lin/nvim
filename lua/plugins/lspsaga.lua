return {
	"nvimdev/lspsaga.nvim",
	event = "BufEnter",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = { enable = false },
		})

		vim.keymap.set("n", "<leader>rn", "<CMD>Lspsaga rename<CR>", { desc = "Lspsaga: [R]e[n]ame" })
	end,
}
