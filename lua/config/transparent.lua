local function set_transparent_highlights()
	local groups = {
		-- core editor
		"Normal",
		"NormalNC",
		"NormalFloat",
		"SignColumn",
		"EndOfBuffer",
		"CursorLine",
		"CursorLineNr",
		"CursorLineSign",
		"CursorColumn",
		"LineNr",
		"FoldColumn",
		"Folded",

		-- statusline / winbar / tabline
		"StatusLine",
		"StatusLineNC",
		"WinBar",
		"WinBarNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",

		-- popups / floats / borders
		"Pmenu",
		"PmenuSel",
		"PmenuSbar",
		"PmenuThumb",
		"FloatBorder",
		"FloatTitle",

		-- bufferline.nvim (if you use it)
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineBufferSelected",
		"BufferLineBufferVisible",

		-- snacks.nvim (picker/explorer/dashboard, per your setup)
		"SnacksPicker",
		"SnacksPickerBox",
		"SnacksPickerInput",
		"SnacksPickerPreview",
		"SnacksDashboardNormal",

		-- telescope.nvim (in case you also use it)
		"TelescopeNormal",
		"TelescopeBorder",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeResultsNormal",
		"TelescopePreviewNormal",

		-- which-key / notify (common extras)
		"WhichKeyFloat",
		"NotifyBackground",
	}

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("transparent_highlights", { clear = true }),
	callback = set_transparent_highlights,
})
