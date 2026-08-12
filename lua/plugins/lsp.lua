-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
      ft = { "lua", "python", "cpp", "c", "typescript", "javascript" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- if you use nvim-cmp for completion
    },
    config = function()
      -- 1. Mason: installs/manages LSP binaries
      require("mason").setup()

      -- 2. Global defaults applied to every server
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        ),
      })

      -- 3. Per-server overrides (only needed if you want non-default settings)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = { typeCheckingMode = "basic" },
          },
        },
      })

      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index" },
      })

      -- 4. mason-lspconfig: bridges Mason-installed servers to vim.lsp.enable()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "clangd", "ts_ls" },
        automatic_enable = true, -- calls vim.lsp.enable() for you
      })

      -- 5. Keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
}
