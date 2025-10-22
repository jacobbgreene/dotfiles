return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  init = function()
    -- Make sure rustaceanvim does NOT try to manage any debug adapter
    vim.g.rustaceanvim = {
      dap = { adapter = false },
      -- keep anything else you had here (tools/server settings), or leave it empty
    }
  end,
}
