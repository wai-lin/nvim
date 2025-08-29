local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local vue_language_server_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enabled = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				ensure_installed = {
					"lua",
					"html",
					"css",
					"javascript",
					"typescript",
					"vue",
					"php",
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
				desc = "[F]or[m]at buffer",
			},
		},
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },

				php = { "pint" },

				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettierd" },
			},
		},
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		enabled = true,
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "saghen/blink.compat", optional = true, opts = {} },
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				compact = {},
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
					},
				},
			},
		},
		opts_extends = { "sources.default" },
		config = function(_, opts)
			local gen_loader = require("mini.snippets").gen_loader
			require("mini.snippets").setup({
				snippets = {
					-- Load custom file with global snippets first (adjust for Windows)
					gen_loader.from_file("~/.config/nvim/snippets/global.json"),
					-- Load snippets based on current language by reading files from
					-- "snippets/" subdirectories from 'runtimepath' directories.
					gen_loader.from_lang(),
				},
			})
			require("blink.cmp").setup(opts)
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			auto_update = true,
			ensure_installed = {
				"lua_ls",
				"eslint_d",
				"ts_ls",
				"vtsls",
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "mason-org/mason.nvim", opts = {} },
		},
		opts = {
			automatic_enable = true,
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},

				vue_ls = {},
				vtsls = {
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
										configNamespace = "typescript",
									},
								},
							},
						},
					},
					filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
				},
				eslint_d = {},
				tailwindcss = {},
				intelephense = {},
			},
		},
		config = function(_, opts)
			for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
