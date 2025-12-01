return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  init = function()
    local ra_binary = vim.fn.exepath("rust-analyzer")
    if ra_binary == "" and vim.fn.filereadable("/run/current-system/sw/bin/rust-analyzer") == 1 then
      ra_binary = "/run/current-system/sw/bin/rust-analyzer"
    end

    if ra_binary == "" then
      vim.notify("[rustaceanvim] rust-analyzer not found on PATH; LSP will remain disabled", vim.log.levels.WARN)
    end

    local server = {
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
          diagnostics = {
            enable = true,
          },
          inlayHints = {
            enable = true,
            typeHints = true,
            bindingModeHints = true,
          },
        },
      },
    }

    if ra_binary ~= "" then
      server.cmd = { ra_binary }
    end

    server.on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    vim.g.rustaceanvim = {
      dap = { adapter = false },
      server = server,
    }
  end,
}
