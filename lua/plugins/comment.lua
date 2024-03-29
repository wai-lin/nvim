return {
	"numToStr/Comment.nvim",
	lazy = false,
	dependencies = {
		-- NOTE: Comment.nvim doesn't work with jsx and tsx filetypes.
		-- This plugin tells Comment.nvim to comment correctly in jsx and tsx filetypes.
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				-- Disabling autocmd is required to work with Comment.nvim.
				require("ts_context_commentstring").setup({ enable_autocmd = false })
			end,
		},
	},
	config = function()
		require("Comment").setup({
			-- NOTE: This hook enables Comment.nvim to aware of jsx and tsx filetypes.
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
