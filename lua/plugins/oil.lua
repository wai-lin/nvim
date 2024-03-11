return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		local columns = {}
		-- Show icons when nerd font is enabled
		if (vim.g.has_nerd_font == true) then
			table.insert(columns, "icon")
		end

		require("oil").setup({
			columns = columns,
			float = { max_width = 100 },
		})

		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Parent Directory" })
	end,
}
