local neo_opts = {
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = 'open_current',
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
      position = 'right',
      width = 100,
    },
  },
  event_handlers = {
    {
      event = 'file_opened',
      handler = function()
        require('neo-tree.command').execute { action = 'close' }
      end,
    },
  },
}

-- Function to toggle flattening of empty directories
local function toggle_flatten()
  -- First, close neotree if it's open
  pcall(vim.cmd, 'Neotree close')

  -- Then, toggle the group_empty_dirs option
  neo_opts.filesystem.group_empty_dirs = not neo_opts.filesystem.group_empty_dirs

  -- Then, reload neotree with new opts
  require('neo-tree').setup(neo_opts)

  -- Finally, reopen neotree
  vim.cmd 'Neotree reveal'
end

-- load plugin with the current opts
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>tf', toggle_flatten, desc = 'Toggle flatten dirs', silent = true },
  },
  opts = neo_opts,
}
