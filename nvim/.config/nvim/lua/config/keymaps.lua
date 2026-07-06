local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Navigate between splits
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Neo-tree
keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- Quit all
keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit all" })

-- for selecting all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Buffer navigation
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Buffer management
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Force delete buffer" })

-- Quick telescope access
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })

-- Obsidian keybindings
keymap.set("n", "<leader>oh", "<cmd>e ~/Library_Of_Alexandria/home.md<cr>", { desc = "Open home dashboard" })
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New note" })
keymap.set("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch notes" })
keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search notes" })
keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Today's daily note" })
keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Yesterday's note" })
keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert template" })
keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks" })
keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Show all links" })
keymap.set("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link" })
keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Switch workspace" })

-- Quick task/checkbox creation
keymap.set("n", "<leader>oc", "o- [ ] ", { desc = "Create task below" })
keymap.set("n", "<leader>oC", "O- [ ] ", { desc = "Create task above" })
keymap.set("v", "<leader>oc", ":s/^/- [ ] /<CR>:nohl<CR>", { desc = "Convert to tasks" })

-- Mouse click to follow links in markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Double-click to follow link
    vim.keymap.set("n", "<2-LeftMouse>", function()
      -- First process the mouse click to position cursor
      vim.cmd("normal! <LeftMouse>")

      local line = vim.api.nvim_get_current_line()
      local link_start = line:find("%[%[")
      if link_start then
        -- Move cursor to inside the link brackets
        vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), link_start })
        vim.cmd("ObsidianFollowLink")
      end
    end, { buffer = true, desc = "Follow link with mouse" })
  end,
})

