return {
	"folke/snacks.nvim",
	priority = 1000,
	---@type snacks.Config
	opts = {
		notifier = {},
		bigfile = {},
		lazygit = {},
		image = {},
		animate = {},
	},
	config = function()
		vim.keymap.set("n", "<leader>gg", "<CMD>lua Snacks.lazygit.open()<CR>", { desc = "Open LazyGit" })
	end,
}
