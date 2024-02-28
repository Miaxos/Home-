local use = require('packer').use

use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    {
      "rouge8/neotest-rust", branch = 'main'
    },
    "folke/which-key.nvim",
    {
      'stevearc/overseer.nvim',
      config = function() require('overseer').setup() end
    }
  },
  config = function()
    local nt = require("neotest")
    local wk = require("which-key")

    nt.setup({
      adapters = {
        require("neotest-rust")
      },
      benchmark = {
        enabled = true
      },
      consumers = {
        overseer = require("neotest.consumers.overseer"),
      },
      overseer = {
        enabled = true,
        -- When this is true (the default), it will replace all neotest.run.* commands
        force_default = true,
      },
      default_strategy = "integrated",
      diagnostic = {
        enabled = true
      },
      discovery = {
        concurrent = 0,
        enabled = true
      },
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {}
      },
      highlights = {
        adapter_name = "NeotestAdapterName",
        border = "NeotestBorder",
        dir = "NeotestDir",
        expand_marker = "NeotestExpandMarker",
        failed = "NeotestFailed",
        file = "NeotestFile",
        focused = "NeotestFocused",
        indent = "NeotestIndent",
        marked = "NeotestMarked",
        namespace = "NeotestNamespace",
        passed = "NeotestPassed",
        running = "NeotestRunning",
        select_win = "NeotestWinSelect",
        skipped = "NeotestSkipped",
        target = "NeotestTarget",
        test = "NeotestTest",
        unknown = "NeotestUnknown"
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "🔴",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "🟢",
        running = "🟡",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "🟣",
        unknown = "❓"
      },
      jump = {
        enabled = true
      },
      log_level = 3,
      output = {
        enabled = true,
        open_on_run = "short"
      },
      projects = {},
      run = {
        enabled = true
      },
      running = {
        concurrent = true
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = false
      },
      strategies = {
        integrated = {
          height = 40,
          width = 120
        }
      },
      summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t"
        }
      }
    })

    wk.register({
      name = "Run Tests",
      n = {
        nt.run.run,
        "Nearest test",
        noremap = true,
      },
      l = {
        nt.run.run_last,
        "Last",
        noremap = true,
      },
      a = {
        function()
          nt.run.run(vim.fn.getcwd())
        end,
        "All",
        noremap = true,
      },
      o = {
        nt.output.open,
        "Show output",
        noremap = true,
      },
      f = {
        function()
          nt.run.run(vim.fn.expand("%"))
        end,
        "All in file",
        noremap = true,
      },
      d = {
        function()
          nt.run.run({ strategy = "dap" })
        end,
        "Debug test",
        noremap = true,
      },
      s = {
        nt.summary.toggle,
        "Test summary",
        noremap = true,
      },
      x = {
        nt.run.stop,
        "Stop Test",
        noremap = true,
      },
    },
      {
        prefix = "t",
      })
  end
}
