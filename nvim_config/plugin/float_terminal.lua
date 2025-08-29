local state = {
	float_term = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the center of the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Buffer
	local buf = nil
	if not vim.api.nvim_buf_is_valid(state.float_term.buf) then
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	else
		buf = state.float_term.buf
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local function toggle_float_term()
	if not vim.api.nvim_win_is_valid(state.float_term.win) then
		state.float_term = create_floating_window({ buf = state.float_term.buf })
		if vim.bo[state.float_term.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end
	else
		vim.api.nvim_win_hide(state.float_term.win)
	end
end

vim.api.nvim_create_user_command("FloatTerm", toggle_float_term, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", "<CMD>FloatTerm<CR>", { desc = "[T]oggle Floating [T]erminal" })
