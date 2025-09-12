return {
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd([[colorscheme kanagawa-dragon]])
	-- 	end,
	-- },

	{
		"mini-nvim/mini.base16",
		opts = {
			use_cterm = true, -- enable 256-color compatibility for terminals
			plugins = { default = true },

			-- gruvbox super contrast
			palette = {
				base00 = "#1d2021", -- bg hard
				base01 = "#282828", -- bg0
				base02 = "#32302f", -- bg0_s
				base03 = "#7c6f64", -- brighter gray for comments
				base04 = "#928374", -- lighter gray
				base05 = "#ebdbb2", -- default fg
				base06 = "#fbf1c7", -- bright fg
				base07 = "#fdf4c1", -- white-ish
				base08 = "#ea6962", -- pastel red
				base09 = "#fe8019", -- orange
				base0A = "#b8bb26", -- green
				base0B = "#fabd2f", -- yellow
				base0C = "#8ec07c", -- aqua
				base0D = "#83a598", -- blue
				base0E = "#d3869b", -- purple
				base0F = "#d65d0e", -- brown / dark orange
			},
		},
	},
}
