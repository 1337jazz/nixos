-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Save all files (override LazyVim's single-file <C-s>)
vim.keymap.set({ 'n', 'x', 's' }, '<C-s>', '<cmd>silent wa<CR>', { desc = 'Save All Files' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>silent wa<CR>a', { desc = 'Save All Files' })

-- Save without formatting
vim.keymap.set('n', '<F2>', '<cmd>noa w<CR>', { desc = 'Save Without Formatting' })
vim.keymap.set('i', '<F2>', '<Esc><cmd>noa w<CR>a', { desc = 'Save Without Formatting' })

-- Quit current window
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit Current Window' })

-- Close current buffer
vim.keymap.set('n', '<C-w>', '<cmd>bd<CR>', { desc = 'Close Current Buffer' })

-- Scroll down 5 lines
vim.keymap.set('n', '<C-e>', '5<C-e>', { desc = 'Scroll Down 5 Lines' })

-- Buffer navigation (using bufferline for consistency with <S-h>/<S-l>)
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })

-- Paste in visual mode without clobbering the register
vim.keymap.set('x', 'p', '"_dP', { noremap = true, silent = true })

-- Bare splits (without <leader>)
vim.keymap.set('n', '|', '<C-w>v', { desc = 'Split Window Vertically' })
vim.keymap.set('n', '-', '<C-w>s', { desc = 'Split Window Horizontally' })

-- Quit Neovim with confirm dialog
vim.keymap.set('n', '<leader>q', function()
  local choice = vim.fn.confirm('Quit Neovim?', '&Yes\n&No', 2)
  if choice == 1 then
    vim.cmd 'qall!'
  end
end, { desc = 'Quit Neovim' })

-- Replace word under cursor
vim.keymap.set('n', '<leader>r', ':%s/\\V\\<<C-r><C-w>\\>//g<Left><Left>', { desc = 'Replace Word Under Cursor' })

-- Toggle invisible characters
vim.keymap.set('n', '<leader>tl', function()
  vim.o.list = not vim.o.list
end, { desc = 'Toggle List Chars' })

-- Toggle line wrap (alias for <leader>uw)
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<CR>', { desc = 'Toggle Wrap' })

-- Diagnostics popup (alias for <leader>cd)
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

-- Terminal (alias for <C-/> which Snacks already maps)
vim.keymap.set({ 'n', 't' }, '<C-\\>', function()
  Snacks.terminal.toggle(nil, { cwd = LazyVim.root() })
end, { desc = 'Terminal (Root Dir)' })

-- File picker (old <C-p> from Telescope)
vim.keymap.set('n', '<C-p>', function()
  Snacks.picker.files()
end, { desc = 'Find Files' })

-- Search: recent files (LazyVim has <leader>fr but not <leader>sr)
vim.keymap.set('n', '<leader>sr', function()
  Snacks.picker.recent()
end, { desc = 'Search Recent Files' })

-- Search: resume (LazyVim has <leader>sR, add <leader>s. alias)
vim.keymap.set('n', '<leader>s.', function()
  Snacks.picker.resume()
end, { desc = 'Search Resume' })

-- Search: neovim config files
vim.keymap.set('n', '<leader>sn', function()
  Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Search Neovim Config Files' })

-- Search: live grep (override <leader>st which LazyVim uses for todo-comments)
vim.keymap.set('n', '<leader>st', function()
  Snacks.picker.grep()
end, { desc = 'Search Text (Live Grep)' })

-- Comment toggle (override <leader>/ which LazyVim uses for grep)
-- Uses Neovim 0.10+ built-in gc operator
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Toggle Comment', remap = true })
