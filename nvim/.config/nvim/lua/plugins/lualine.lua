return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = require("pywal.core").get_colors()
    
    -- Custom pywal theme for lualine
    local pywal_theme = {
      normal = {
        a = { fg = colors.color0, bg = colors.color4, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
      insert = {
        a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
      visual = {
        a = { fg = colors.color0, bg = colors.color5, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
      replace = {
        a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
      command = {
        a = { fg = colors.color0, bg = colors.color3, gui = "bold" },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
      inactive = {
        a = { fg = colors.color7, bg = colors.color8 },
        b = { fg = colors.color7, bg = colors.color8 },
        c = { fg = colors.color7, bg = colors.color0 },
      },
    }

    require("lualine").setup({
      options = {
        theme = pywal_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { 
          "branch",
          "diff",
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_c = { 
          {
            "filename",
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = { 
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { 
          "progress",
        },
        lualine_z = { 
          "location",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "lazy" },
    })

    -- Reload lualine colors when pywal colors change
    vim.api.nvim_create_autocmd("Signal", {
      pattern = "SIGUSR1",
      callback = function()
        require("lualine").setup({
          options = {
            theme = pywal_theme,
          },
        })
      end,
    })
  end,
}