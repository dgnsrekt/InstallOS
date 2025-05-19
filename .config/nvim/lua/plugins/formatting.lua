return {
  require("conform").setup({
    -- Add to lua/config/plugins/formatting.lua (or similar)
    formatters_by_ft = {
      python = { "ruff_format" }, -- Uses Ruff for formatting
    },
  }),

  -- Add to your LazyVim plugins
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      auto_detect = true, -- Automatically find .venv
    },
  },
}
