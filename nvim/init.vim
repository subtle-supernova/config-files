set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"source ~/.vimrc

call plug#begin()
Plug 'nyoom-engineering/oxocarbon.nvim', {'branch': 'main'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ziglang/zig.vim'
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'folke/neodev.nvim', {'branch': 'main'}
Plug 'mbbill/undotree'
Plug 'tpope/vim-fireplace'
Plug 'kien/rainbow_parentheses.vim'
Plug 'folke/trouble.nvim', {'branch': 'main'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'mrcjkb/rustaceanvim'

Plug 'elixir-lang/vim-elixir'
Plug 'keith/swift.vim'
Plug 'reasonml-editor/vim-reason'
Plug 'ElmCast/elm-vim'
call plug#end()

colorscheme oxocarbon

set guicursor=i:block
set noswapfile
set nobackup
set bg=light

set nocp
set mouse=
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8
scriptencoding utf-8
set list
set listchars=tab:»·,trail:·

set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set hlsearch
"set backup
"set backupdir^=~/.vim/_backup//
"set directory^=~/.vim/_temp//
set autoindent
set smartindent
set showmatch
set number
set relativenumber
set t_Co=256

" LSP config
lua <<EOF
-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

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
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
 sources = cmp.config.sources({
   { name = 'nvim_lsp' },
 }, { { name = 'buffer' }, }),
})

require('lspconfig').lua_ls.setup({})
-- require('lspconfig').rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
--  settings = {
--    ['rust-analyzer'] = {},
--  },
--}

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("go").setup({
  lsp_cfg = {
    capabilities = capabilities,
  }
})

-- remaps
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>b", vim.cmd.Buffers)
vim.keymap.set("n", "<leader>F", vim.cmd.Files)
vim.keymap.set("n", "<leader>f", function() vim.cmd.Files(vim.fn.expand("%:h")) end)
vim.keymap.set("n", "<leader>fh", function() vim.cmd.Files(os.getenv("HOME")) end)
vim.keymap.set("n", "<leader>M", vim.cmd.Maps)
-- set vim PWD to dir of current file
vim.keymap.set("n", "<leader>cd", function() vim.cmd.cd(vim.fn.expand("%:h")) end)

vim.keymap.set("n", "<leader>r", vim.cmd.Rg)
vim.keymap.set("n", "Q", vim.cmd.bd)
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)

-- opts

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

require("troublesettings")
require('treesitter')
EOF

