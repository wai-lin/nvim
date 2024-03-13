local servers = {
	html = {},
	cssls = {},
	tsserver = {
		filetypes = { "javascript", "typescript", "vue" },
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = "/Users/wai-lin/Library/pnpm/nodejs/20.11.1/lib/node_modules/@vue/typescript-plugin",
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},
	},
	eslint = {},
	tailwindcss = {},
	volar = {},
	svelte = {},
	jsonls = {},

	gopls = {},
	templ = {},

	ocamllsp = {},
	elixirls = {},

	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				workspace = {
					checkThirdParty = false,
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.stdpath "config" .. "/lua"] = true,
					},
					-- library = {
					-- 	'${3rd}/luv/library',
					-- 	unpack(vim.api.nvim_get_runtime_file('', true)),
					-- },
				},
				completion = {
					callSnippet = 'Replace',
				},
			},
		},
	},
}

-- Attach LSP related
-- keymaps and autocommands on buffers
local on_attach = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			-- The following two autocommands are used to highlight references of the
			-- word under your cursor when your cursor rests there for a little while.
			--    See `:help CursorHold` for information about when this is executed
			--
			-- When you move your cursor, the highlights will be cleared (the second autocommand).
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end
	})
end

return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	opts = {},
	config = function()
		on_attach()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

		require("mason").setup()

		local ensured_installed = vim.tbl_keys(servers or {})
		require("mason-lspconfig").setup({
			ensured_installed = ensured_installed,
		})

		for server_name in pairs(servers) do
			require("lspconfig")[server_name].setup(servers[server_name] or {})
		end
	end,
}
