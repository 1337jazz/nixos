return {
  'numToStr/Comment.nvim',
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      padding = true,
      ignore = '^$',
      mappings = {
        basic = true,
        extra = false,
        extended = false,
      },
      toggler = {
        line = '<leader>/',
        block = 'gbc',
      },
      opleader = {
        line = '<leader>/',
      },
    }
  end,
}
