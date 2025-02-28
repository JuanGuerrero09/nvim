return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "jose-elias-alvarez/typescript.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Set LSP capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Function to attach LSPs with keymaps
    local on_attach = function(_, bufnr)
      local keymap = vim.keymap.set
      local opts = { buffer = bufnr, noremap = true, silent = true }

      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- Show references
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- Go to definition
      keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- Show implementations
      keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- Type definitions
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename
      keymap("n", "<leader>d", vim.diagnostic.open_float, opts) -- Show diagnostics
      keymap("n", "[d", vim.diagnostic.goto_prev, opts) -- Prev diagnostic
      keymap("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
      keymap("n", "<leader>h", vim.lsp.buf.hover, opts) -- Hover
      keymap("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts) -- Format
    end

    -- List of LSPs to enable
    local servers = {
      "gopls", -- Go
      "pyright", -- Python
      "tsserver", -- JavaScript & TypeScript
      "html", -- HTML
      "cssls", -- CSS
      "tailwindcss", -- Tailwind
      "svelte", -- Svelte
      "prismals", -- Prisma
      "jsonls", -- JSON
      "terraformls", -- Terraform
      "lua_ls", -- Lua
    }

    -- Setup all LSPs in the list
    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end

    -- Special Lua settings
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- ESLint with formatting on save
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
      end,
    })
  end,
}
