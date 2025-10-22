-- plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
  event = "VeryLazy",
  config = function()
    local codex_status = function()
      local ok, codex = pcall(require, "codex")
      if not ok or not codex.status then
        return ""
      end
      return codex.status()
    end

    require("lualine").setup({
      sections = {
        lualine_c = { "filename", codex_status }, -- ← this is the “drop in” bit
      },
    })
  end,
}
