-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Delete unnamed buffers when opening a new file
-- Uses a debounce mechanism to avoid conflicts with bulk buffer operations
local delete_unnamed_timer = nil
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Delete unnamed buffers when opening a new file',
  group = vim.api.nvim_create_augroup('kickstart-delete-unnamed', { clear = true }),
  callback = function()
    -- Cancel any pending timer to debounce the operation
    if delete_unnamed_timer then
      delete_unnamed_timer:stop()
      delete_unnamed_timer = nil
    end

    -- Delay execution to avoid conflicts with buffer closing operations
    delete_unnamed_timer = vim.defer_fn(function()
      -- Use pcall to prevent errors from interrupting other operations
      pcall(function()
        local buffers = vim.api.nvim_list_bufs()
        for _, buf in ipairs(buffers) do
          -- Additional guards: check if buffer is still valid and loaded
          if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == '' then
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            local is_empty = #lines == 1 and lines[1] == ''
            ---@diagnostic disable-next-line: deprecated
            local is_unmodified = not vim.api.nvim_buf_get_option(buf, 'modified')
            if is_empty and is_unmodified then
              -- Only delete if buffer is still valid (double-check)
              if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
              end
            end
          end
        end
      end)
      delete_unnamed_timer = nil
    end, 100) -- 100ms delay to allow bulk operations to complete
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      return
    end

    local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

    -- -- The following two autocommands are used to highlight references of the word under the cursor when the cursor rests there for a little while.
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })

    -- Autocommand to clear references and remove other autocommands when LSP detaches from the buffer
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = group, buffer = event.buf }
      end,
    })

    -- Keymaps that only apply to buffers with an active LSP
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: [R]e[n]ame' })
    vim.keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: Code [A]ction' })
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = event.buf, desc = 'LSP: [G]oto [R]eferences' })
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { buffer = event.buf, desc = 'LSP: [G]oto [I]mplementation' })
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { buffer = event.buf, desc = 'LSP: [G]oto [D]efinition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = 'LSP: [G]oto [D]eclaration' })
    vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, { buffer = event.buf, desc = 'LSP: [G]oto [T]ype Definition' })
  end,
})
