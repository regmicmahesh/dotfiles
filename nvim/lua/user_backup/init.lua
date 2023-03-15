 local config = {
   -- colorscheme = "catppuccin",
   options = {
     opt = {
       -- set to true or false etc.
       relativenumber = true, -- sets vim.opt.relativenumber
       number = true, -- sets vim.opt.number
       spell = false, -- sets vim.opt.spell
       signcolumn = "auto", -- sets vim.opt.signcolumn to auto
       clipboard = "",
       wrap = false, -- sets vim.opt.wrap
     },
     g = {
       mapleader = " ", -- sets vim.g.mapleader
       copilot_no_tab_map = true,
       copilot_assume_mapped = true,
       autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
       cmp_enabled = true, -- enable completion at start
       autopairs_enabled = true, -- enable autopairs at start
       diagnostics_enabled = true, -- enable diagnostics at start
       status_diagnostics_enabled = true, -- enable diagnostics in statusline
       icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
     },
   },




   
   mappings = {
     i = {
       ["<C-b>"] = { 'copilot#Accept("<CR>")', expr = true, silent=true, replace_keycodes = false }

     }
   },

   plugins = {
     {"github/copilot.vim", lazy=false},
     {
       "catppuccin/nvim",
       as = "catppuccin",
       config = function()
         require("catppuccin").setup {}
       end,
     },
     {"jose-elias-alvarez/null-ls.nvim", config = function()


       local null_ls = require "null-ls"
       null_ls.setup({

         sources = {
           null_ls.builtins.formatting.black,
           null_ls.builtins.formatting.ktlint,
           null_ls.builtins.formatting.prettier
         },
         on_attach = require("astronvim.utils.lsp").on_attach,
       })

       
     end,
   }
   },
 }


 return config
