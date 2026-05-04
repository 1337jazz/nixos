return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_filetypes = {
      ['copilot-chat'] = false, -- Disable Copilot for Copilot Chat
    }
  end,
}
