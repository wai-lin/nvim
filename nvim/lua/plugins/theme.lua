return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config =  function() 
        require("catppuccin").setup({
            flavour = "mocha",
            dim_inactive = { enabled = false },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
