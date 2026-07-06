return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Library_Of_Alexandria",
        path = "~/Library_Of_Alexandria",
      },
    },

    -- Optional, customize how note IDs are generated
    note_id_func = function(title)
      -- Create note IDs from title or use timestamp
      local suffix = ""
      if title ~= nil then
        -- Transform spaces to hyphens and make lowercase
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Use timestamp if no title
        suffix = tostring(os.time())
      end
      return suffix
    end,

    -- Optional, configure note frontmatter
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- Add title if it exists
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Daily notes configuration
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = nil,
    },

    -- Templates
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Completion settings
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Mappings
    mappings = {
      -- "Obsidian follow" - Follow links with gf
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart Enter: Follow links OR toggle checkboxes
      ["<cr>"] = {
        action = function()
          local line = vim.api.nvim_get_current_line()

          -- First priority: Follow links
          local link_start = line:find("%[%[")
          if link_start then
            -- Move cursor to inside the link brackets
            vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), link_start })
            vim.cmd("ObsidianFollowLink")
            return
          end

          -- Second priority: Toggle checkboxes if no link found
          if line:match("^%s*- %[.%]") then
            require("obsidian").util.toggle_checkbox()
            return
          end
        end,
        opts = { buffer = true },
      },
      -- Toggle checkbox (use this specifically for checkboxes)
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },

    -- Disable UI rendering to show raw markdown (cleaner and more reliable)
    ui = {
      enable = false,
    },

    -- Specify how to handle attachments
    attachments = {
      img_folder = "attachments",
    },

    -- Optional, set to true to use the current directory as a vault
    detect_cwd = false,

    -- Optional, configure additional syntax highlighting
    disable_frontmatter = false,

    -- Optional, for backward compatibility
    finder = "telescope.nvim",
  },
}
