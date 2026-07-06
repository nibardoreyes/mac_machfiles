return {
  {
    "AlphaTechnolog/pywal.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local pywal = require("pywal")
      pywal.setup()
      vim.cmd("colorscheme pywal")
      
      -- Make background transparent
      local function apply_transparency()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        -- Ensure line numbers are always visible
        local linenr = vim.api.nvim_get_hl(0, { name = "LineNr" })
        if not linenr.fg then
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#888888", bg = "NONE" })
          vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "NONE" })
          vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "NONE" })
        end
      end
      
      apply_transparency()

      -- Auto-reload when pywal colors change
      vim.api.nvim_create_autocmd("Signal", {
        pattern = "SIGUSR1",
        callback = function()
          vim.cmd("colorscheme pywal")
          apply_transparency()
        end,
      })
    end,
  },
}