return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 20,
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- Space + t toggles floating terminal
    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    vim.keymap.set("t", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle floating terminal" })
    
    -- Easy escape from terminal
    vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  end,
}