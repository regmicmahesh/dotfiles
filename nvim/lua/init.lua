local lsp = vim.lsp
local handlers = lsp.handlers
local cmp = require'cmp'

vim.o.completeopt = "menuone,noselect,longest"


require'lualine'.setup{
  options = { theme = onedark }
}

 cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      --['<C-e>'] = cmp.mapping({
      --    i = cmp.mapping.abort(),
      --    c = cmp.mapping.close(),
      --  }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      })
  })


-- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --
require'lspconfig'.tsserver.setup{ capabilities = capabilities }
require'lspconfig'.pyright.setup{ capabilities = capabilities }
require'lspconfig'.terraformls.setup{ capabilities = capabilities }
require'lspconfig'.clangd.setup{ capabilities = capabilities }
require'lspconfig'.html.setup{ capabilities = capabilities }
require'lspconfig'.svelte.setup{ capabilities = capabilities }
require'lspconfig'.solang.setup{ capabilities = capabilities }
require'lspconfig'.sumneko_lua.setup{capabilities = capabilities}
