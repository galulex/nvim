return {
  'tzachar/cmp-ai',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local cmp_ai = require('cmp_ai.config')

    cmp_ai:setup({
      max_lines = 1000,
      provider = 'OpenAI',
      provider_options = {
        model = 'gpt-4',
      },
      notify = true,
      notify_callback = function(msg)
        vim.notify(msg)
      end,
      run_on_every_keystroke = true,
      ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
    })
  end
}
