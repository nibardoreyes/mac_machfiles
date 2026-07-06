return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local previewers = require("telescope.previewers")

    -- Custom file previewer that handles images
    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}
      
      -- Check if file is an image
      if vim.fn.executable("chafa") == 1 then
        local is_image = function(path)
          local image_extensions = { "png", "jpg", "jpeg", "gif", "webp", "bmp" }
          local ext = vim.fn.fnamemodify(path, ":e"):lower()
          return vim.tbl_contains(image_extensions, ext)
        end

        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "chafa",
            filepath,
          }, {
            on_stdout = send_output,
            stdout_buffered = true,
          })
          return
        end
      end

      -- Default preview for non-images
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end

    telescope.setup({
      defaults = {
        buffer_previewer_maker = new_maker,
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        
        -- Side-by-side layout
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 1,
        },
        
        sorting_strategy = "ascending",
        
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap

    -- Regular telescope keymaps
    keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
  end,
}