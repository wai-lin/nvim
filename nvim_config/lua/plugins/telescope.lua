return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
				},
			},
		})

		local builtin = function(picker)
			return "<CMD>lua require('telescope.builtin')."
				.. picker
				.. "(require('telescope.themes').get_dropdown({}))<CR><ESC>"
		end

		vim.keymap.set("n", "<leader>ff", builtin("find_files"), { desc = "Telescope: Find files" })
		vim.keymap.set("n", "<leader>fg", builtin("live_grep"), { desc = "Telescope: Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin("buffers"), { desc = "Telescope: Buffers" })
		vim.keymap.set("n", "<leader>fd", builtin("diagnostics"), { desc = "Telescope: LSP Diagnostics" })
		vim.keymap.set("n", "<leader>fh", builtin("help_tags"), { desc = "Telescope: Help tags" })
		vim.keymap.set("n", "<leader>fp", builtin("builtin"), { desc = "Telescope: List pickers" })
	end,
}
