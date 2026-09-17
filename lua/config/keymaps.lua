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

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit"})

-- Terminal 
vim.keymap.set("n", "<leader>tt", function()
  local dir = vim.fn.expand("%:p:h")

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.fn.termopen(vim.o.shell, { cwd = dir })
  vim.cmd("startinsert")
end, { desc = "Open floating term in current dir" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Bufferline
vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left" })
vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>bd", ":w<CR>:bd<CR>", { desc = "Save and close buffer", silent = true })

vim.keymap.set("n", "<leader>fh", "<cmd>Alpha<CR>", { desc = "Home screen" })

-- Themes 
vim.keymap.set("n", "<leader>ts", "<cmd>Theme<CR>", { desc = "Select theme" })
vim.keymap.set("n", "<leader>tn", "<cmd>ThemeNext<CR>", { desc = "Next theme" })
vim.keymap.set("n", "<leader>tp", "<cmd>ThemePrev<CR>", { desc = "Previous theme" })
