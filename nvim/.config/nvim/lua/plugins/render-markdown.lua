return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- Render styles
    heading = {
      -- Turn on / off heading icon & background rendering
      enabled = true,
      -- Replaces '#+' of 'atx_h._marker'
      -- The number of '#' in the heading determines which sign is used
      sign = true,
      -- Width of the heading background
      -- block: width of the heading text
      -- full: full width of the window
      width = "full",
      -- The 'level' is used to index into the array
      -- Highlight for the heading icon and extends through the entire line
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      -- The 'level' is used to index into the array
      -- Highlight for the heading and sign icons
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    code = {
      -- Turn on / off code block & inline code rendering
      enabled = true,
      -- Determines how code blocks are rendered
      --  none: disables all rendering
      --  normal: adds highlight group to code blocks
      --  language: adds language icon to sign column and icon + name above code block
      --  full: normal + language
      style = "full",
      -- Width of the code block background
      -- block: width of the code block
      -- full: full width of the window
      width = "full",
      -- Highlight for code blocks
      highlight = "RenderMarkdownCode",
      -- Highlight for inline code
      highlight_inline = "RenderMarkdownCodeInline",
    },
    bullet = {
      -- Turn on / off list bullet rendering
      -- DISABLED: obsidian.nvim handles bullet rendering to avoid conflicts
      enabled = false,
      -- Replaces '-', '+', and '*' of 'list_item'
      -- How deeply nested the list is determines which icon is used
      icons = { "●", "○", "◆", "◇" },
      -- Highlight for the bullet icon
      highlight = "RenderMarkdownBullet",
    },
    checkbox = {
      -- Turn on / off checkbox state rendering
      -- DISABLED: obsidian.nvim handles checkbox rendering to avoid text cutoff
      enabled = false,
      unchecked = {
        -- Replaces '[ ]' of 'task_list_marker_unchecked'
        icon = "󰄱 ",
        -- Highlight for the unchecked icon
        highlight = "RenderMarkdownUnchecked",
      },
      checked = {
        -- Replaces '[x]' of 'task_list_marker_checked'
        icon = " ",
        -- Highlight for the checked icon
        highlight = "RenderMarkdownChecked",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownImportant" },
      },
    },
    quote = {
      -- Turn on / off block quote rendering
      enabled = true,
      -- Replaces '>' of 'block_quote'
      icon = "▋",
      -- Highlight for the quote icon
      highlight = "RenderMarkdownQuote",
    },
    pipe_table = {
      -- Turn on / off pipe table rendering
      enabled = true,
      -- Determines how the table as a whole is rendered
      --  none: disables all rendering
      --  normal: applies the 'cell' style rendering to each row of the table
      --  full: normal + a top & bottom line that fill out the table
      style = "full",
      -- Determines how individual cells of a table are rendered
      --  overlay: writes completely over the table, removing conceal behavior and highlights
      --  raw: replaces only the '|' characters in each row, leaving the cells unmodified
      --  padded: raw + cells are padded to maximum visual width for each column
      cell = "padded",
      -- Characters used to replace table border
      -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
      -- stylua: ignore
      border = {
        '┌', '┬', '┐',
        '├', '┼', '┤',
        '└', '┴', '┘',
        '│', '─',
      },
      -- Highlight for table heading, delimiter, and the line above
      head = "RenderMarkdownTableHead",
      -- Highlight for table row
      row = "RenderMarkdownTableRow",
    },
    link = {
      -- Turn on / off inline link rendering
      enabled = true,
      -- Inlined with text
      inline = " ",
      -- Highlight for the link label
      highlight = "RenderMarkdownLink",
    },
    sign = {
      -- Turn on / off sign rendering
      enabled = true,
    },
    -- Disable rendering in specific file types
    anti_conceal = {
      -- This enables hiding any added text and using the conceallevel
      -- that was present when render-markdown was setup
      enabled = true,
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
