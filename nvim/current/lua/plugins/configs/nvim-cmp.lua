-- reference: https://github.com/hrsh7th/nvim-cmp
local present, cmp = pcall(require, "cmp")
if not present then
  return
end
local lspkind = require("lspkind")

-- Enable compilation
-- reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = ({
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })
      }),
    },

  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<Down>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<Up>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<Esc>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = 'vsnip' }, -- For vsnip users.
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
  }),
})
