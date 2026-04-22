return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'nvim-java/nvim-java',
    'b0o/schemastore.nvim',
  },
  config = function()
    -- ==================================================================
    -- !! LSP-specific keymaps are in autocommands.lua !!
    -- ==================================================================

    -- First thing's first, setup java with nvim-java since it's a special snowflake
    -- And also setup jdtls like this instead of through mason-lspconfig (idk why, it just doesn't work otherwise)
    require('java').setup()
    require('lspconfig').jdtls.setup {}

    -- Extend LSP capabilities with blink.nvim's capabilities
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- A list of lsps we should install
    local servers = {
      lua_ls = {},
      gopls = {},
      ts_ls = {},
      jdtls = {}, -- already set up above, but we include it here so mason-tool-installer installs it
      tailwindcss = {},
      eslint = {},
      emmet_ls = {},
      buf = {},
      html = {},
      cssls = {},
      dockerls = {},
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(), -- Add common json schemas from schemastore (e.g. package.json, tsconfig.json, etc.)
            validate = { enable = true },
          },
        },
      },
      terraformls = {
        filetypes = { 'terraform', 'tfvars', 'hcl' },
      },
    }

    -- A list of tools we should install (e.g. formatters, linters, etc.)
    local tools = {
      'stylua',
      'prettierd',
    }

    -- Now use mason-tool-installer to install the servers and tools
    require('mason-tool-installer').setup { ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools) }

    -- Now we can use mason-lspconfig to setup the servers
    require('mason-lspconfig').setup {
      ensure_installed = {}, -- explicitly set to an empty table since we are using mason-tool-installer
      automatic_installation = false, -- same here, we are using mason-tool-installer
      handlers = {
        function(server_name)
          -- Skip jdtls since we already set it up above
          if server_name == 'jdtls' then
            return
          end
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
