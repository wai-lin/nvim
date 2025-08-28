return {
	{
		"echasnovski/mini.nvim",
		---@module 'mini'
		---@type mini.SetupOpts
		opts = {},

		config = function()
			require("mini.icons").setup()
			require("mini.notify").setup()
			require("mini.pairs").setup()
			require("mini.ai").setup()
			require("mini.cursorword").setup()
			require("mini.move").setup()

			-- MiniFiles
			require("mini.files").setup()
			vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open file explorer" })

			require("mini.extra").setup()
			require("mini.git").setup()
			require("mini.diff").setup()

			-- MiniStatusline
			local MiniStatusline = require('mini.statusline')

			local function location()
			  local line_icon = ""  -- You can use any icon you like here (this is a common line icon)
			  local col_icon = "󱥖"   -- Icon for column (choose any you prefer)

			  local line = vim.fn.line(".")          -- current line number
			  local col = vim.fn.col(".")            -- current column number

			  -- Format: "icon line" and "icon col"
			  local line_str = string.format("%s %d", line_icon, line)
			  local col_str = string.format("%s %d", col_icon, col)

			  -- Return combined string with a space between
			  return line_str .. "  " .. col_str
			end

			require("mini.statusline").setup({
				content = {
					inactive = nil,
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git           = MiniStatusline.section_git({ trunc_width = 75 })
						local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
						local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
						local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
						-- local location      = MiniStatusline.section_location({ trunc_width = 75 })

						-- Get current time in H:m format
						local time = "  " .. os.date("%H:%M")

						return MiniStatusline.combine_groups({
							{ hl = mode_hl,                  strings = { mode } },
							{ hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
							'%<', -- Mark general truncate point
							{ hl = 'MiniStatuslineFilename', strings = { filename } },
							'%=', -- End left alignment
							{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
							{ hl = mode_hl,                  strings = { search, location(), time } },
						})
					end,
				},
			})
		end,
	},
}
