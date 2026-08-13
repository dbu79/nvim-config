return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      dashboard = {
        enabled = true,
      },

      picker = {
        enabled = true,
      },

      notifier = {
        enabled = true,
      },

      input = {
        enabled = true,
      },

      indent = {
        enabled = true,
      },

      scope = {
        enabled = true,
      },

      words = {
        enabled = true,
      },

      quickfile = {
        enabled = true,
      },

      bigfile = {
        enabled = true,
      },

      scroll = {
        enabled = true,
      },

      statuscolumn = {
        enabled = true,
      },
    },

    keys = {
      -- Files
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },

      -- Grep
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },

      -- Buffers
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },

      -- Recent files
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },

      -- Directories
      {
        "<leader>fd",
        function()
          Snacks.picker.directories()
        end,
        desc = "Directories",
      },

      -- Projects
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },

      -- Git
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },

      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },

      -- Help
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help",
      },

      -- Commands
      {
        "<leader>fc",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },

      -- Keymaps
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },

      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Go to Definition",
      },

      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        desc = "References",
      },

      {
        "<leader>fs",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
    },
  },
}
