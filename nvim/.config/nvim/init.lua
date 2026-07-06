-- Set leader key FIRST, before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load core configs
require("config.options")
require("config.keymaps")