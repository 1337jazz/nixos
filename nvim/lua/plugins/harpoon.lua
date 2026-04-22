return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup {
      menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) / 2), -- Half width
        -- height = 10, -- Optional: adjust height too
      },
    }
  end,
  keys = {
    {
      '<leader>ha',
      function()
        require('harpoon.mark').add_file()
      end,
    },
    {
      '<leader>hh',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
    },
    {
      '<leader>hj',
      function()
        require('harpoon.ui').nav_next()
      end,
    },
    {
      '<leader>hk',
      function()
        require('harpoon.ui').nav_prev()
      end,
    },
  },
}
