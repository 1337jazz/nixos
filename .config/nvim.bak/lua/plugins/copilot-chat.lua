return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'claude-sonnet-4',
      auto_insert_mode = false,

      chat_autocomplete = false,
      mappings = {
        reset = {
          normal = '',
          insert = '',
          callback = nil,
        },
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<CR>', desc = 'Open Copilot Chat', mode = 'n' },
      { '<leader>cc', '<cmd>CopilotChat<CR>', desc = 'Open Copilot Chat', mode = 'v' },
    },
  },
}
