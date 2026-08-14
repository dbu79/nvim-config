return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    scratch = { enabled = true },
    profiler = { enabled = true },
  },
  keys = {
    -- Top level
    {
      "<leader><space>",
      function() Snacks.picker.files({ root = true }) end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>,",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>.",
      function() Snacks.scratch() end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>/",
      function() Snacks.picker.grep({ root = true }) end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>:",
      function() Snacks.picker.command_history() end,
      desc = "Command History",
    },
    {
      "<leader>dps",
      function() Snacks.profiler.scratch() end,
      desc = "Profiler Scratch Buffer",
    },
    {
      "<leader>e",
      function() Snacks.explorer({ root = true }) end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>E",
      function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end,
      desc = "Explorer Snacks (cwd)",
    },

    -- Find group
    {
      "<leader>fb",
      function() Snacks.picker.buffers() end,
      desc = "Buffers",
    },
    {
      "<leader>fB",
      function() Snacks.picker.buffers({ hidden = true, unloaded = true }) end,
      desc = "Buffers (all)",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>fe",
      function() Snacks.explorer({ root = true }) end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end,
      desc = "Explorer Snacks (cwd)",
    },
    {
      "<leader>ff",
      function() Snacks.picker.files({ root = true }) end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>fF",
      function() Snacks.picker.files({ cwd = vim.fn.getcwd() }) end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fg",
      function() Snacks.picker.git_files() end,
      desc = "Find Files (git-files)",
    },
    {
      "<leader>fp",
      function() Snacks.picker.projects() end,
      desc = "Projects",
    },
  },
}
