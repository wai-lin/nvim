return {
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		branch = "stable",
		config = function()
			require("fyler").setup({
				icon_provider = "nvim_web_devicons",
				close_on_select = false,
			})
			vim.keymap.set("n", "<leader>e", "<CMD>Fyler kind=split_right_most<CR>", { desc = "Open File Explorer" })
		end,
	},
}
