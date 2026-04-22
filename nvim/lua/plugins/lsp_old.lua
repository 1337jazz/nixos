return {}
-- return {
--   'neovim/nvim-lspconfig',
--   config = function()
--     -- Special case for Java 'cos it's a lil' bitch
--     require('java').setup()

--     local lspconfig = require 'lspconfig'

--     -- Keymaps with individual descriptions
--     local on_attach = function(_, bufnr)
--       vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: [R]e[n]ame' })
--       vim.keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code [A]ction' })
--       vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'LSP: [G]oto [R]eferences' })
--       vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' })
--       vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' })
--       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' })
--       vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, { buffer = bufnr, desc = 'LSP: [G]oto [T]ype Definition' })
--     end

--     -- Path to mason bin directory
--     local masonpath = vim.fn.stdpath 'data' .. '/mason/bin/'

--     -- Setup language servers: lua
--     lspconfig.lua_ls.setup {
--       on_attach = on_attach,
--       cmd = { masonpath .. 'lua-language-server' },
--     }

--     -- Setup language servers: go
--     lspconfig.gopls.setup {
--       on_attach = on_attach,
--       cmd = { masonpath .. 'gopls' },
--     }

--     -- Setup language servers: java
--     lspconfig.jdtls.setup {
--       on_attach = on_attach,
--     }

--     -- Setup language servers: typescript/javascript/jsx/tsx
--     lspconfig.ts_ls.setup {
--       on_attach = on_attach,
--       cmd = { masonpath .. 'typescript-language-server', '--stdio' },
--     }

--     -- Setup language servers: tailwindcss
--     lspconfig.tailwindcss.setup {
--       on_attach = on_attach,
--       cmd = { masonpath .. 'tailwindcss-language-server', '--stdio' },
--     }

--     lspconfig.eslint.setup {
--       on_attach = on_attach,
--       cmd = { masonpath .. 'vscode-eslint-language-server', '--stdio' },
--     }
--   end,
-- }
