-- Syntax Highlighting

local ensure_installed = {
	"c",
	"cpp",
	"vim",
	"vimdoc",

	"lua",
	"luadoc",

	"http",
	"bash",
	"csv",
	"diff",
	"comment",
	"editorconfig",
	"mermaid",
	"toml",
	"xml",
	"yaml",
	"nginx",
	"dockerfile",
	"ssh_config",
	"tmux",
	
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",

	"dart",

	"html",
	"css",
	"scss",
	"javascript",
	"typescript",
	"jsdoc",
	"json",
	"jsonc",
	"regex",

	"astro",
	"vue",
	"svelte",

	"sql",
	"prisma",

	"go",
	"gomod",
	"gosum",
	"gotmpl",
	"gowork",
	"templ",

	"python",
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			auto_install = true,
			ensure_installed = ensure_installed,
		})
	end,
	config = function(_, opts)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require('nvim-treesitter.configs').setup(opts)

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
