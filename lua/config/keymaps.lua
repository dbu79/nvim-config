vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)


local function run_file()
  vim.cmd("write")

  local file = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype

  local commands = {
    python = "python3 " .. file,
    lua = "lua " .. file,
    javascript = "node " .. file,
    typescript = "npx ts-node " .. file,
    sh = "bash " .. file,
    cpp = string.format(
      "g++ -std=c++17 -Wall %s -o /tmp/%s && /tmp/%s",
      file, vim.fn.expand("%:t:r"), vim.fn.expand("%:t:r")
    ),
    c = string.format(
      "gcc -Wall %s -o /tmp/%s && /tmp/%s",
      file, vim.fn.expand("%:t:r"), vim.fn.expand("%:t:r")
    )
  }

  local cmd = commands[filetype]
  if not cmd then
    vim.notify("No run command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  vim.cmd("botright split | resize 15")
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>r", run_file, { desc = "Run current file" })

-- Bufferline
vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right" })

vim.keymap.set("n", "<leader>fh", "<cmd>Alpha<CR>", { desc = "Home screen" })
