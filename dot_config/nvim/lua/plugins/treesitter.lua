return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- This ensures we don't try to auto-install (which is messy on NixOS)
      opts.auto_install = false
      -- This silences the "Installed X/X" message
      opts.ensure_installed = {} 
    end,
  },
}
