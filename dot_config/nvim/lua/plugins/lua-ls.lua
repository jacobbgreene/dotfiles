local function prefer_system_binary(exe, fallback)
  local found = vim.fn.exepath(exe)
  return (found ~= "" and found) or fallback
end

local skip_servers = {
  lua_ls = true,
  rust_analyzer = true,
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          -- Use the Nix-provided binary since the Mason build fails to run on NixOS.
          cmd = { prefer_system_binary("lua-language-server", "/run/current-system/sw/bin/lua-language-server") },
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      -- Mason installs non-Nix binaries that cannot run on this system,
      -- so remove servers we provide via Nix from its auto-install list.
      local filtered = {}
      for _, server in ipairs(opts.ensure_installed) do
        if not skip_servers[server] then
          table.insert(filtered, server)
        end
      end
      opts.ensure_installed = filtered
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      local filtered = {}
      for _, tool in ipairs(opts.ensure_installed) do
        if tool ~= "lua-language-server" and tool ~= "rust-analyzer" then
          table.insert(filtered, tool)
        end
      end
      opts.ensure_installed = filtered
    end,
  },
}
