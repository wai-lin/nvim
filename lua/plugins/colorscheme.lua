return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		local bg_color = "#262220"
		local html_tag = ""

		-- custom_highlights = function(colors)
		--         return {
		--             Comment = { fg = colors.flamingo },
		--             TabLineSel = { bg = colors.pink },
		--             CmpBorder = { fg = colors.surface2 },
		--             Pmenu = { bg = colors.none },
		--         }
		-- end
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
