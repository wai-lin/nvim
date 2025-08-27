return {
  -- {
  --   "Mofiqul/vscode.nvim",
  --   opts = {
  --     style = "dark",
  --     italic_comments = true,
  --     underline_links = true,
  --   },
  -- },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = true,
      terminal_colors = true,
      styles = {
        comment = { italic = true },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "thick",
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
          },
        },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "monokai-pro",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
}
