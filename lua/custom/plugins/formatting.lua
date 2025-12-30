return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        html = { 'prettierd' },
        css = { 'prettierd' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        json = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        astro = { 'prettier' },
        -- python = { 'ruff_format' },
      },
      formatters = {
        biome = {
          command = 'biome',
          args = {
            'format',
            '--stdin-file-path',
            '$FILENAME',
            '--fix',
          },
        },
        prettierd = {
          command = 'prettierd',
          args = {
            '$FILENAME',
          },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 5000,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_fallback = true,
        async = true,
        timeout_ms = 5000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
