local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "neovim/nvim-lspconfig",
  "nyoom-engineering/oxocarbon.nvim",
  "nvim-treesitter/nvim-treesitter",
  -- {"ray-x/guihua.lua", run = 'cd lua/fzy && make'},
  "ray-x/guihua.lua", 
  "rust-lang/rust.vim",
  "ziglang/zig.vim",
  {'mrcjkb/rustaceanvim',
  version = '^4',
  lazy = false,
  ft = { 'rust '},
  },
  { "ray-x/go.nvim",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require("go").setup({
        lsp_cfg = {
          capabilities = capabilities,
        }
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            --elseif luasnip.expand_or_jumpable() then
              --luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
              -- luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
       sources = cmp.config.sources({
         { name = 'nvim_lsp' },
       }, { { name = 'buffer' }, }),
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      --require('lspconfig')['go'].setup {
      --  capabilities = capabilities
      --}
    end,
  },
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

