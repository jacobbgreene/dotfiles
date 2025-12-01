return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  opts = function(_, opts)
    local ok, actions = pcall(require, "fzf-lua.actions")
    if not ok then
      return opts
    end

    local exec_menu = actions.exec_menu
    opts.menus = opts.menus or {}
    opts.menus.actions = opts.menus.actions or {}

    opts.menus.actions["enter"] = function(selected, ...)
      if #selected == 0 then
        return
      end
      vim.cmd("stopinsert")
      local success, result = pcall(exec_menu, selected, ...)
      if not success then
        vim.notify(result, vim.log.levels.ERROR, { title = "fzf-lua menu" })
      end
      return result
    end

    return opts
  end,
}
