local utils = require('core.utils')
local avante = utils.require('avante')

avante.setup({
  -- add any opts here
  -- this file can contain specific instructions for your project
  instructions_file = 'avante.md',
  -- for example
  provider = 'claude',
  auto_suggestions_provider = 'claude',
  providers = {
    claude = {
      endpoint = 'https://api.anthropic.com',
      auth_type = 'max', -- Set to "max" to sign in with Claude Pro/Max subscription
      model = 'claude-sonnet-4-6',
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 4096,
      },
    },
    gemini = {
      endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
      -- not support subscription yet
      model = 'gemini-3-flash-preview',
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
  },
  behaviour = {
    auto_suggestions = true, -- Experimental stage
  },
  input = {
    provider = 'snacks', -- "native" | "dressing" | "snacks"
    provider_opts = {
      -- Snacks input configuration
      title = 'Avante Input',
      icon = ' ',
      placeholder = 'Enter your API key...',
    },
  },
})
