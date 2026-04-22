-- [[ Basic Keymaps ]]
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', function()
  local choice = vim.fn.confirm('Quit Neovim?', '&Yes\n&No', 2)
  if choice == 1 then
    vim.cmd 'qall!'
  end
end)

-- Stop visual mode pasting over currently selected text by default
vim.keymap.set('x', 'p', '"_dP', { noremap = true, silent = true })

-- Ctrl+S to save the current file
vim.keymap.set('n', '<C-s>', '<cmd>silent wa<CR>')
vim.keymap.set('i', '<C-s>', '<Esc><cmd>silent wa<CR>a')

-- F2 to save without formatting
vim.keymap.set('n', '<F2>', '<cmd>noa w<CR>')
vim.keymap.set('i', '<F2>', '<Esc><cmd>noa w<CR>a')

-- CTRL+Q to quit the current window
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = 'Quit current window' })

-- CTRL+W to close the current buffer
vim.keymap.set('n', '<C-w>', '<cmd>bd<CR>', { desc = 'Close current buffer' })

-- CTRL+E to scroll down more lines
vim.keymap.set('n', '<C-e>', '5<C-e>', { desc = 'Scroll down 5 lines' })

-- Tab to switch between buffers
vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use CTRL+arrow keys to resize windows
vim.keymap.set('n', '<C-Up>', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<C-w>>', { desc = 'Increase window width' })

-- Use | and - to split windows
vim.keymap.set('n', '|', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '-', '<C-w>s', { desc = 'Split window horizontally' })

-- <leader>tl to toggle invisible characters (doesn't work lol)
vim.keymap.set('n', '<leader>tl', function()
  vim.o.list = not vim.o.list
end, { desc = 'Toggle [L]ist chars' })

-- <leader>bo to close all buffers except the current one
vim.keymap.set('n', '<leader>bo', '<cmd>BWipeout other<CR>', { desc = 'Close [B]uffers [O]thers' })

-- <leader>ba to close all buffers
vim.keymap.set('n', '<leader>ba', '<cmd>BWipeout all<CR>', { desc = 'Close [B]uffers [A]ll' })

-- <leader>r to replace word under cursor
vim.keymap.set('n', '<leader>r', ':%s/\\V\\<<C-r><C-w>\\>//g<Left><Left>', { desc = 'Replace word under cursor' })

-- <leader>k to show diagnostics popup (press again to focus into it)
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Show diagnostics popup' })

-- cpd/cpe to disable/enable copilot
vim.keymap.set('n', 'cpd', '<cmd>Copilot disable<CR>', { desc = 'Disable Copilot' })
vim.keymap.set('n', 'cpe', '<cmd>Copilot enable<CR>', { desc = 'Enable Copilot' })

-- <leader>tw to toggle line wrap
vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>', { desc = '[T]oggle line [W]rap' })
