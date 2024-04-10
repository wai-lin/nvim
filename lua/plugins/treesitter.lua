local ensure_installed = {
	"bash",
	"json",
	"yaml",
	"toml",
	"regex",
	"tmux",
	"ssh_config",
	"vim",
	"vimdoc",
	"comment",
	"gitcommit",
	"gitignore",

	"html",
	"css",
	"typescript",
	"astro",
	"vue",
	"svelte",
	"graphql",
	"php",
	"sql",

	"c",
	"lua",
	"luadoc",
	"go",
	"gomod",
	"gowork",
	"gotmpl",
	"templ",
	"elixir",
	"rust",
	"ocaml",
	"ocaml_interface",
	"ocamllex",
	"zig",
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = ensure_installed,
		})
	end,
}
