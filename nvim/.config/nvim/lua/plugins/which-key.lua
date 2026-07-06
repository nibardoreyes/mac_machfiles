return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Register key groups with icons
    wk.add({
      { "<leader>f", group = " Find" },
      { "<leader>s", group = "󰩈 Split" },
      { "<leader>n", group = " Clear" },
      { "<leader>r", group = " Rename" },
      { "<leader>c", group = " Code" },
      { "<leader>b", group = "󰓩 Buffer" },
      { "<leader>h", desc = "󱡀 Harpoon menu" },
      { "<leader>a", desc = "󱡁 Harpoon add" },  
      { "<leader>e", desc = " Explorer" },
      { "<leader>q", desc = " Quit" },
    })
  end,
}