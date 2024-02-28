local cmd = vim.cmd
local use = require('packer').use

use {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    -- Treesitter:
    local tree_sitter = require("nvim-treesitter.configs")

    tree_sitter.setup({
      ensure_installed = { "nix", "lua", "bash", "git_rebase", "gitcommit", "gitignore", "jq", "json", "markdown", "regex", "vim", "rust" },

      -- phpdoc is a language that is not supported on arm64.
      -- See: https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15
      ignore_install = { "phpdoc" },
      matchup = {
        enable = true
      },
      indent = {
        enable = true
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}

use {
  'preservim/vim-markdown',
  requires = {
    { 'godlygeek/tabular' }
  },
  config = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
  end
}

use 'GutenYe/json5.vim'

cmd [[
  au BufRead,BufNewFile *.scss set filetype=scss

  autocmd BufNewFile,BufRead *.hcl set filetype=hcl
  " Nomad
  autocmd BufNewFile,BufRead *.nomad set filetype=hcl
  " Terraform
  autocmd BufNewFile,BufRead *.tf     set filetype=hcl
  autocmd BufNewFile,BufRead *.tfvars set filetype=hcl
  autocmd BufNewFile,BufRead *.tpl     set filetype=hcl

  au BufEnter *.scss :syntax sync fromstart
]]

use 'pangloss/vim-javascript'
use 'MaxMEllon/vim-jsx-pretty'
use 'leafgarland/typescript-vim'
use 'ianks/vim-tsx'
use 'jxnblk/vim-mdx-js'
use 'jvirtanen/vim-hcl'
use 'towolf/vim-helm'

cmd [[
  augroup typescript_save | au!
    autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx :EslintFixAll
    autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx :w
  augroup end
]]
