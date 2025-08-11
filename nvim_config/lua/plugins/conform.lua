return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        javascriptreact = { "prettierd", stop_after_first = true },
        typescriptreact = { "prettierd", stop_after_first = true },
        vue = { "prettierd", stop_after_first = true },
        ruby = { "rubocop", stop_after_first = true },
      },
    },
  },
}
