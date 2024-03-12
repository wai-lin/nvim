-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")

-- Diagnostic Keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D}iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode with easier shortcut
--
-- NOTE: This won't work in all terminal emulators/tmuxt/etc.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<CMD>echo 'Use h to move!!'<CR>")
vim.keymap.set("n", "<right>", "<CMD>echo 'Use l to move!!'<CR>")
vim.keymap.set("n", "<up>", "<CMD>echo 'Use k to move!!'<CR>")
vim.keymap.set("n", "<down>", "<CMD>echo 'Use j to move!!'<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Move focus from Terminal mode
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Move focus to left window" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Move focus to right window" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Move focus to lower window" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Move focus to upper window" })

-- Resize windows
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window to left" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window to right" })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window to upper" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window to lower" })
-- Resize terminal
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize window to left" })
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize window to right" })
vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize window to upper" })
vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize window to lower" })


-- Lazy command mode with `;` instead of `:`
vim.keymap.set("n", ";", ":", { desc = "Lazy command mode with `;`" })

-- Escape to Normal mode with `jk`
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape to Normal mode" })

-- Close current buffer
vim.keymap.set("n", "<leader>x", "<CMD>bd<CR>", { desc = "Close current buffer" })

-- Indent while keeping visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep visual mode" })
