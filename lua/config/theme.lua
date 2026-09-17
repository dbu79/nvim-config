local M = {}
local colorschemes = require("config.colorschemes")
local koda = require("config.koda")
local config = {
	themes = colorschemes.names(),
	default = "koda",
	state_file = vim.fn.stdpath("state") .. "/theme.txt",
}

local function index_of(name)
	for i, theme in ipairs(config.themes) do
		if theme == name then
			return i
		end
	end
	return nil
end

local function set_transparent()
	local groups = {
		"Normal", "NormalNC", "NormalFloat", "SignColumn",
		"EndOfBuffer", "LineNr", "CursorLineNr", "FoldColumn",
		"MsgArea", "Pmenu", "PmenuSel", "WinSeparator", "VertSplit",
		"FloatBorder", "FloatTitle", "WinBar", "WinBarNC",

		"DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint",
		"DiagnosticSignOk", "DiagnosticSignErrorLine", "DiagnosticSignWarnLine",

		"SnacksStatusColumn", "SnacksStatusColumnFold", "SnacksStatusColumnSep",
		"SnacksNormal", "SnacksNormalNC", "SnacksBackdrop",
		"SnacksPicker", "SnacksPickerBorder", "SnacksPickerNormal",
		"SnacksPickerTitle", "SnacksPickerInputBorder", "SnacksPickerBoxBorder",
		"SnacksExplorer", "SnacksExplorerNormal", "SnacksExplorerBorder",
		"SnacksExplorerTitle", "SnacksWinBar", "SnacksWinBarNC",

		"TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal",
		"TelescopePromptBorder", "TelescopeResultsNormal", "TelescopeResultsBorder",
		"TelescopePreviewNormal", "TelescopePreviewBorder",

		"FzfLuaNormal", "FzfLuaBorder", "FzfLuaTitle",

		-- bufferline.nvim
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineBuffer", "BufferLineBufferSelected", "BufferLineBufferVisible",
		"BufferLineTab", "BufferLineTabSelected", "BufferLineTabClose",
		"BufferLineTabSeparator", "BufferLineTabSeparatorSelected",
		"BufferLineIndicatorSelected",
		"BufferLineSeparator", "BufferLineSeparatorSelected", "BufferLineSeparatorVisible",
		"BufferLineModified", "BufferLineModifiedSelected", "BufferLineModifiedVisible",
		"BufferLineCloseButton", "BufferLineCloseButtonSelected", "BufferLineCloseButtonVisible",
		"BufferLineNumbers", "BufferLineNumbersSelected", "BufferLineNumbersVisible",

		-- gitsigns.nvim
		"GitSignsAdd", "GitSignsChange", "GitSignsDelete",
		"GitSignsAddNr", "GitSignsChangeNr", "GitSignsDeleteNr",
		"GitSignsAddLn", "GitSignsChangeLn", "GitSignsDeleteLn",
		"GitSignsAddInline", "GitSignsChangeInline", "GitSignsDeleteInline",
		"GitSignsCurrentLineBlame",
	}
	for _, group in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = "none"
		vim.api.nvim_set_hl(0, group, hl)
	end
end

vim.g.transparent_enabled = true

local function toggle_transparent()
	vim.g.transparent_enabled = not vim.g.transparent_enabled
	if vim.g.transparent_enabled then
		set_transparent()
		vim.notify("Transparency: on", vim.log.levels.INFO)
	else
		vim.cmd.colorscheme(vim.g.colors_name)
		vim.notify("Transparency: off", vim.log.levels.INFO)
	end
end

local function persist(name)
	local dir = vim.fn.fnamemodify(config.state_file, ":h")
	vim.fn.mkdir(dir, "p")
	vim.fn.writefile({ name }, config.state_file)
end

local function read_persisted()
	if vim.fn.filereadable(config.state_file) == 0 then
		return nil
	end
	local lines = vim.fn.readfile(config.state_file)
	return lines[1]
end

local function apply(name, opts)
	opts = opts or {}
	if not index_of(name) then
		vim.notify(("Unknown theme: %s"):format(name), vim.log.levels.ERROR)
		return false
	end
	koda.setup(name)
	local ok, err = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify(("Failed to load theme %s: %s"):format(name, err), vim.log.levels.ERROR)
		return false
	end
	if vim.g.transparent_enabled then
		set_transparent()
	end
	if opts.persist ~= false then
		persist(name)
	end
	if opts.notify then
		vim.notify(("Theme: %s"):format(name), vim.log.levels.INFO)
	end
	return true
end

function M.names()
	return vim.deepcopy(config.themes)
end

function M.current()
	return vim.g.colors_name
end

function M.set(name, opts)
	return apply(name, opts)
end

function M.cycle(step)
	step = step or 1
	local current = M.current()
	local current_index = index_of(current) or index_of(config.default) or 1
	local next_index = ((current_index - 1 + step) % #config.themes) + 1
	return apply(config.themes[next_index], { notify = true })
end

function M.select()
	vim.ui.select(config.themes, {
		prompt = "Select theme",
		format_item = function(item)
			if item == M.current() then
				return item .. " (current)"
			end
			return item
		end,
	}, function(choice)
		if choice then
			apply(choice, { notify = true })
		end
	end)
end

function M.load()
	local name = read_persisted() or config.default
	if apply(name, { persist = false }) then
		return
	end
	if name ~= config.default then
		apply(config.default)
	end
end

function M.setup(opts)
	config = vim.tbl_deep_extend("force", config, opts or {})

	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			if vim.g.transparent_enabled then
				set_transparent()
			end
		end,
	})

	vim.api.nvim_create_user_command("Theme", function(command_opts)
		if command_opts.args == "" then
			M.select()
			return
		end
		M.set(command_opts.args, { notify = true })
	end, {
		nargs = "?",
		complete = function(arg_lead)
			return vim.tbl_filter(function(theme)
				return theme:find(arg_lead, 1, true) == 1
			end, config.themes)
		end,
		desc = "Select or set the active theme",
	})

	vim.api.nvim_create_user_command("ThemeNext", function()
		M.cycle(1)
	end, { desc = "Cycle to the next theme" })

	vim.api.nvim_create_user_command("ThemePrev", function()
		M.cycle(-1)
	end, { desc = "Cycle to the previous theme" })

	vim.keymap.set("n", "<leader>tb", toggle_transparent, { desc = "Toggle background transparency" })

	M.load()
end

return M
