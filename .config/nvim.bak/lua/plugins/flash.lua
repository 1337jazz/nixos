return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  opts = {
    label = {
      rainbow = {
        enabled = true,
        -- number between 1 and 9
        shade = 9,
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
  },
}
