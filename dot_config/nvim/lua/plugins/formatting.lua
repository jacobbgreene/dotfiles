return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = {
          -- This forces conform to use the one in your $PATH
          command = "stylua",
        },
        shfmt = {
          command = "shfmt",
        },
      },
    },
  },
}
