-- Disable netrw, since we use a better file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Borders for floating windows
vim.o.winborder = 'single'

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set some basic options
vim.o.scrolloff = 20
vim.o.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true

-- Enable icons and stuff
vim.g.have_nerd_font = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent (nicer wrapped lines)
vim.o.wrap = false
vim.o.breakindent = true
vim.opt.sidescroll = 1 -- Smooth horizontal scrolling
vim.opt.sidescrolloff = 5 -- Keep 5 columns visible when scrolling horizontally

-- Save undo history (undo after file is closed)
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default (git and lsp markers in column)
vim.o.signcolumn = 'yes'
vim.o.foldcolumn = '1'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Show invisible characters (false by default)
vim.o.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Confirm dialog before failed command (e.g. quit before save)
vim.o.confirm = true

-- Diagnostic Config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}
