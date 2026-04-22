return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  lazy = false,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  keys = {
    { '<leader>gb', '<cmd>Gitsigns blame_line<CR>', desc = 'Git [B]lame line' },
    { '<leader>gB', '<cmd>Gitsigns blame<CR>', desc = 'Git [B]lame (full)' },
    { '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Git [P]review hunk' },
    { '<leader>gR', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Git [R]eset hunk' },
    { '<leader>gS', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Git [S]tage hunk' },
    { '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Git [U]nstage hunk' },
  },
}
