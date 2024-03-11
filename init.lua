-- [[ Start initialization ]]
--  This file contain necessary neovim defaults and some overrides
require("configs.options")
require("configs.keymaps")
require("configs.autocmds")

-- [[ Install `lazy.nvim` plugin manager ]]
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins", {
	defaults = {
		lazy = true, -- all plugins are lazy by default
	},
	change_detection = {
		enabled = true, -- automatically check for config file changes and reload the ui
		notify = true,  -- get a notification when changes are found
	},
	ui = {
		-- change icons to unicode emojies so that it works on every system
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	}
})
