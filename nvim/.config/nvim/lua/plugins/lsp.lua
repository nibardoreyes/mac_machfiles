return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "ts_ls",
        },
        automatic_installation = true,
      })

      -- Setup LSP servers using the new vim.lsp.config API
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Lua Language Server
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Python
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = capabilities,
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "rust-project.json", ".git" },
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        capabilities = capabilities,
      })

      -- Enable LSP servers
      vim.lsp.enable({ "lua_ls", "pyright", "rust_analyzer", "ts_ls" })

      -- LSP Keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
        end,
      })
    end,
  },
}