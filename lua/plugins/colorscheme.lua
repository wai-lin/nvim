return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		local bg_color = "#262220"

		require("catppuccin").setup({
			integrations = {
				cmp = true,
				treesitter = true,
				fidget = true,
				which_key = true,
			},
			color_overrides = {
				mocha = {
					base = bg_color,
					mantle = bg_color,
					crust = bg_color,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
