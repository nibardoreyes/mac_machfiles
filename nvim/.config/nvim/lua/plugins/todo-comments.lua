return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPre",
  opts = {
    signs = true,
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  },
  keys = {
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Find TODO/FIX" },
    
    -- Show help with all keywords
    { "<leader>?", function()
      local help = [[
TODO COMMENT KEYWORDS:
  
  TODO:   - Things to implement
  FIXME:  - Known bugs to fix
  BUG:    - Same as FIXME
  HACK:   - Temporary workaround
  WARN:   - Important warnings
  NOTE:   - Important information
  INFO:   - Same as NOTE
  PERF:   - Performance improvements needed
  TEST:   - Testing related

Usage:
  -- TODO: your message here
  <leader>ft  - Find all todos in project
]]
      vim.notify(help, vim.log.levels.INFO, { title = "Todo Comments Help" })
    end, desc = "Todo keywords help" },
  },
}