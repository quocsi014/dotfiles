return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    ft = { "go" }, -- chỉ load khi mở file go cho đỡ tốn RAM
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- ===== dap-ui =====
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- ===== mason dap =====
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "delve" },
      })

      -- ===== GO adapter (delve) =====
      dap.adapters.go = function(callback, _)
        local handle
        local port = 38697
        handle = vim.loop.spawn("dlv", {
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          handle:close()
          print("dlv exited with code", code)
        end)

        -- chờ dlv mở port
        vim.defer_fn(function()
          callback({
            type = "server",
            host = "127.0.0.1",
            port = port,
          })
        end, 100)
      end

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug File",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug Package",
          request = "launch",
          program = "${fileDirname}",
        },
        {
          type = "go",
          name = "Debug Test (File)",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug Test (Package)",
          request = "launch",
          mode = "test",
          program = "${fileDirname}",
        },
        {
          type = "go",
          name = "Attach to Process",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      -- ===== Keymaps (chỉ cho Go) =====
      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

      map("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
      map("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP Conditional Breakpoint" })

      map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP UI" })
    end,
  },
}
