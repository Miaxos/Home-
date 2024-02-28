local set = vim.opt
local use = require('packer').use

local function split(pString, pPattern)
  local Table = {} -- NOTE: use {n = 0} in Lua-5.0
  local fpat = "(.-)" .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(Table, cap)
    end
    last_end = e + 1
    s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
    cap = pString:sub(last_end)
    table.insert(Table, cap)
  end
  return Table
end

-- wild menu options
set.wildmode = 'list:longest:full'
-- ignore compiled files in wild menu
set.wildignore = '*.o,*~,*.pyc'

set.completeopt = 'menuone,noselect'

vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = {
    source = false,
    prefix = '-',
  },
  float = {
    style = "minimal",
    border = "single",
    source = "always",
    focusable = true,
    header = "",
  },
  severity_sort = true,
  update_in_insert = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>N', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next)

-- if current line have diagnostics message,
-- show diagnostics message float window, otherwise
-- use the normal hover.
local hover = function()
  vim.diagnostic.open_float(nil, { scope = "cursor", focus = false })
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = hover,
})

use {
  "b0o/schemastore.nvim",

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-emoji',
  'ray-x/cmp-treesitter',
  'hrsh7th/cmp-nvim-lua',
  'petertriho/cmp-git',
  'onsails/lspkind.nvim',

  'RRethy/vim-illuminate',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  'j-hui/fidget.nvim',

  {
    'RishabhRD/lspactions',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim'
    }
  },
  {
    'mrcjkb/rustaceanvim', branch = 'master',
    ft = { 'rust' }
  },
  'williamboman/nvim-lsp-installer',
  'lukas-reineke/lsp-format.nvim',
  {
    'neovim/nvim-lspconfig',
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-lua/plenary.nvim',
      {
        'rcarriga/nvim-dap-ui',
        requires = {
          'mfussenegger/nvim-dap',
        }
      }

    },
    config = function()
      local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.3/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

      require('nvim-lsp-installer').setup {
        automatic_installation = true -- detect lsp server configured here
      } -- to be called before lspconfig
      require('lsp-format').setup {}

      require('fidget').setup {}
      local lspconfig = require("lspconfig")

      vim.g.Illuminate_delay = 50

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local handlers = {
        ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {}),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {}),
        ["textDocument/codeAction"] = require 'lspactions'.codeaction
      }

      local on_attach = function(client, bufnr)
        require('illuminate').on_attach(client)
        require('lsp-format').on_attach(client)

        local lspactions = require 'lspactions'

        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set('', '<leader>d', vim.lsp.buf.declaration, opts)
        vim.keymap.set('', '<leader>g', vim.lsp.buf.definition, opts)
        vim.keymap.set('', '<leader>t', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('', '<leader>r', vim.lsp.buf.references, opts)
        vim.keymap.set('', '<leader>i', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)

        vim.keymap.set('', '<leader>rn', lspactions.rename, opts)
        vim.keymap.set('n', '<leader>a', lspactions.code_action, opts)
        vim.keymap.set('v', '<leader>a', lspactions.range_code_action, opts)
      end

      local function fetch_env()
        local features_env = vim.env.FEATURES
        local features = {}
        if features_env == nil then
          features[1] = "default"
        else
          features = split(features_env, ",")
        end
        return features
      end

      vim.g.rustaceanvim = function() 
        return {
        server = {
          handlers = handlers,
          on_attach = on_attach,
          -- capabilities = capabilities,
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500,
          },
          ['rust-analyzer'] = {
            -- rustcSource = 'discover',
            procMacro = {
              enable = true,
            },
            experimental = {
              procAttrMacros = true,
            },
            assist = {
              importGranularity = 'module',
              importEnforceGranularity = true,
            },
            diagnostics = {
              enableExperimental = true,
            },
            updates = {
              channel = 'stable',
            },
            checkOnSave = {
              command = "check",
              -- extraArgs = {"--target-dir", "/tmp/rust-analyzer-check"}
            },
            cargo = {
              buildScripts = {
                enable = true
              }
              -- features = { "default" },
            },
            hoverActions = {
              references = true,
            },
            inlayHints = {
              chainingHints = true,
              maxLength = 40,
              parameterHints = true,
              typeHints = true,
            },
            lens = {
              enable = true,
              methodReferences = true,
              references = true,
            },
          }
        },
        tools = { -- rust-tools options
          reload_workspace_from_cargo_toml = true,
          autoSetHints = true,
          hover_with_actions = false, -- deprecated Set :RustHoverAction instead
          runnables = {
            use_telescope = true
          },
          debuggables = {
            use_telescope = true
          },
          inlay_hints = {
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            parameter_hints_prefix = "👈 ",
            show_variable_name = false,
            other_hints_prefix = "👉 ",
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            replace_builtin_hover = true,
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              { "╭", "FloatBorder" }, { "─", "FloatBorder" },
              { "╮", "FloatBorder" }, { "│", "FloatBorder" },
              { "╯", "FloatBorder" }, { "─", "FloatBorder" },
              { "╰", "FloatBorder" }, { "│", "FloatBorder" }
            },
            max_width = nil,
            max_height = nil,
            -- whether the hover action window gets automatically focused
            auto_focus = false,
          },

        },
        dap = {
            --- @class RustaceanDapAdapterConfig
            adapter = {
              ---@type string
              type = 'executable',
              ---@type string
              command = 'lldb-vscode',
              ---@type string
              name = 'rustaceanvim_lldb',
            },
        },
        -- dap = {
          -- adapter = require('rustaceanvim.dap').get_codelldb_adapter(
          --  codelldb_path, liblldb_path)
        -- }
      }
      end

      require("dapui").setup({
        layouts = {
          {
            elements = {
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "console",
            },
            size = 10,
            position = "bottom",
          },
          {
            elements = {
              "repl",
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      lspconfig.ccls.setup {
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'c++', 'h' },
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          compilationDatabaseDirectory = "build";
          index = {
            threads = 0;
          };
          clang = {
            excludeArgs = { "-frounding-math"} ;
          };
        }
      }


      lspconfig.jsonls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      }

      lspconfig.tsserver.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          completions = {
            completeFunctionCalls = true
          },
        }
      }

      lspconfig.emmet_ls.setup {
        filetypes = {
          'html',
          'typescriptreact',
          'javascriptreact',
          'css',
          'sass',
          'scss',
          'less'
        },
      }

      lspconfig.eslint.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            },
            showDocumentation = {
              enable = true
            }
          },
          codeActionOnSave = {
            enable = true,
            mode = "all"
          },
          format = true,
          run = "onType",
          validate = "on",
          workingDirectory = {
            mode = 'location'
          }
        },
        root_dir = require('lspconfig.util').find_git_ancestor,
      }

      lspconfig.rnix.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }


      lspconfig.html.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.cssls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.bashls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.dockerls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.yamlls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.vimls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.terraformls.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local lspkind = require('lspkind')

      local luasnip = require 'luasnip'
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
      luasnip.filetype_set("javascriptreact", { "javascript" })
      luasnip.filetype_set("typescript", { "javascript" })
      luasnip.filetype_set("typescriptreact", { "javascriptreact" })

      local cmp = require 'cmp'

      cmp.setup {
        sources = {
          { name = "nvim_lsp", priority = 100 },
          { name = 'luasnip', priority = 50 },
          { name = "buffer" },
          { name = "emoji" },
          { name = "path" },
          { name = "treesitter" },
          { name = 'nvim_lua' },
          { name = "crates" }
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          })
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

      }

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-previous-choice", {})
      vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-previous-choice", {})
    end
  }
}


use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
}

-- -- Load crates.nvim lazily
-- use {
--   'saecki/crates.nvim',
--   event = { "BufRead Cargo.toml" },
--   requires = { 'nvim-lua/plenary.nvim' },
--   config = function()
--     require('crates').setup()
--   end,
-- }
--
-- -- Add crates.nvim lazily
-- vim.api.nvim_create_autocmd("BufRead", {
--   group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
--   pattern = "Cargo.toml",
--   callback = function()
--     cmp.setup.buffer({ sources = { { name = "crates" } } })
--   end,
-- })
