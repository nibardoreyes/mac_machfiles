return {
  "numToStr/Comment.nvim",
  event = "BufReadPre",
  opts = {},
  config = function()
    require("Comment").setup()
    -- gcc - toggle line comment
    -- gbc - toggle block comment
    -- gc in visual mode - comment selection
  end,
}