return {
  {
    "folke/snacks.nvim",
    init = function()
      LazyVim.on_very_lazy(function()
        local picker = require("snacks.picker.core.picker")
        local update_titles = picker.update_titles
        picker.update_titles = function(self, ...)
          if not self.layout or not self.layout.wins or not self.layout.box_wins then
            return
          end
          return update_titles(self, ...)
        end
      end)
    end,
  },
}

