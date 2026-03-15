local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local vue_language_server_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"
local proj_conf = require("utils.project_config")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = true,
				modules = {},
				ignore_install = {},
				auto_install = true,
				highlight = {
					enable = true,
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
					"go",
					"html",
					"css",
					"javascript",
					"typescript",
					"vue",
					"php",
					"svelte",
					"ruby",
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
			lsp_fallback = true,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },

				go = {},
				gleam = {},
				ocaml = { "ocamlformat", stop_after_first = true }, -- ocaml

				php = { "pint" },
				-- ruby = { "rubocob" },

				-- NOTE:
				-- JS Frameworks doesn't need prettired.
				-- Since I use eslint_d lsp to format.
				--
				--
				-- INFO: uncomment the following configs
				-- if you want to enable formatting with prettierd.
				--
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				-- vue = { "prettier" },
				-- svelte = { "prettier" },
				-- json = { "prettier" },
				-- jsonc = { "prettier" },
				-- html = { "prettier" },
				prisma = {},
				-- javascript = {},
				-- javascriptreact = {},
				-- typescript = {},
				-- typescriptreact = {},
				vue = { stop_after_first = true },
				svelte = {},
				json = { "prettier" },
				jsonc = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},
		},
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
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
			keymap = {
				preset = "default",
				["<CR>"] = { "select_and_accept", "fallback" },
			},
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				compact = {},
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = {
						name = "LSP",
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
				"ts_ls",
				"vtsls",
				"eslint",
				"intelephense",
				"pint",
				"ruby_lsp",
			},
		},
	},

	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
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
				gopls = {},
				gleam = {},
				ocamllsp = {},
				rust_analyzer = {},

				sqlls = {},

				intelephense = {}, -- Licence Key is set at ~/intelephense/licence.txt
				ruby_lsp = {},

				prismals = {},
				html = {},
				css = {},
				somesass_ls = {},
				unocss = {},
				vtsls = { -- Typescript server that also support .vue files
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

				svelte = {
					on_attach = function(client, bufnr)
						if client.server_capabilities then
							local fmt = proj_conf.get({ "lsp", "svelte", "formatting" }, nil, bufnr)
							if fmt == false then
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							elseif fmt == true then
								client.server_capabilities.documentFormattingProvider = true
								client.server_capabilities.documentRangeFormattingProvider = true
							end
						end
					end,
				},
				vue_ls = {
					on_attach = function(client, bufnr)
						if client.server_capabilities then
							local fmt = proj_conf.get({ "lsp", "vue", "formatting" }, nil, bufnr)
							if fmt == false then
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							elseif fmt == true then
								client.server_capabilities.documentFormattingProvider = true
								client.server_capabilities.documentRangeFormattingProvider = true
							end
						end
					end,
				},

				tailwindcss = {},
				eslint = { -- NOTE: config is from https://github.com/antfu/eslint-config
					settings = {
						rulesCustomizations = {
							{ rule = "style/*", severity = "off", fixable = true },
							{ rule = "format/*", severity = "off", fixable = true },
							{ rule = "*-indent", severity = "off", fixable = true },
							{ rule = "*-spacing", severity = "off", fixable = true },
							{ rule = "*-spaces", severity = "off", fixable = true },
							{ rule = "*-order", severity = "off", fixable = true },
							{ rule = "*-dangle", severity = "off", fixable = true },
							{ rule = "*-newline", severity = "off", fixable = true },
							{ rule = "*quotes", severity = "off", fixable = true },
							{ rule = "*semi", severity = "off", fixable = true },
						},
					},
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
						"vue",
						"html",
						"markdown",
						"json",
						"jsonc",
						"yaml",
						"toml",
						"xml",
						"gql",
						"graphql",
						"astro",
						"svelte",
						"css",
						"less",
						"scss",
						"pcss",
						"postcss",
					},
				},
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
