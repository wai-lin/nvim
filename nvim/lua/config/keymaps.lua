-- Normal Mode
vim.keymap.set("n", ";", ":", { desc = "Lazy command mode" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { silent = true, desc = "Close current buffer" })

-- Insert Mode
vim.keymap.set("i", "jj", "<ESC>", { desc = "Lazy escape mode" })
