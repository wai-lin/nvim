-- File Manager with Vim Motions

return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { 
        { "echasnovski/mini.icons", opts = {} },
    },
    config = function()
        require("oil").setup({
            float = { max_width = 80 }
        })

        vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
    end,
}
