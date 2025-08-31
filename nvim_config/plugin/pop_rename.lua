-- Thanks to TJ
-- https://gist.github.com/tjdevries/69771e9ac4605a9df893977055e21377

local Input = require("nui.input")

local function pop_rename()
	local current_value = vim.fn.expand("<cword>")

	local popup_options = {
		relative = "cursor",
		position = {
			row = 1,
			col = 0,
		},
		size = 50,
		border = {
			style = "rounded",
			text = {
				top = "[Rename: " .. current_value .. "]",
				top_align = "left",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	}

	local input = Input(popup_options, {
		prompt = "",
		default_value = current_value,
		on_submit = function(value)
			print("Value submitted: ", value)

			---@diagnostic disable-next-line: missing-parameter
			local position_params = vim.lsp.util.make_position_params()
			---@diagnostic disable-next-line: inject-field
			position_params.newName = value

			vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, method, result, ...)
				if err then
					vim.notify("Rename failed: " .. err.message, vim.log.levels.ERROR)
					return
				end

				if result then
					vim.lsp.handlers["textDocument/rename"](err, method, result, ...)
					vim.notify("Rename successful!", vim.log.levels.INFO)
				else
					vim.notify("Nothing to rename!", vim.log.levels.WARN)
				end
			end)
		end,
	})

	input:mount()
end

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
vim.keymap.set("n", "<leader>rn", pop_rename, { desc = "LSP: [R]e[n]ame" })
