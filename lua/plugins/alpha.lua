return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
dashboard.section.header.val = {
			[[                                                                     ]],
			[[       ███████████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      ████████████████ ███████████ ███   ███████     ]],
			[[     ████████████████ ████████████ █████ ██████████████   ]],
			[[    █████████████████████████████ █████ █████ ████ █████   ]],
			[[  ██████████████████████████████████ █████ █████ ████ █████  ]],
			[[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
			[[ ██████   ██  ███████████████   ██ █████████████████ ]],
			[[ ██████   ██  ███████████████   ██ █████████████████ ]],
		}
dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find File", ":lua Snacks.picker.files({ root = true })<CR>"),
			dashboard.button("n", " " .. " New File",  ":ene <BAR> startinsert<CR>"),
			dashboard.button("p", " " .. " Projects",  ":lua Snacks.picker.projects()<CR>"),
			dashboard.button("r", " " .. " Recents",   ":lua Snacks.picker.recent()<CR>"),
			dashboard.button("c", " " .. " Config",    ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>"),
			dashboard.button("q", " " .. " Quit", 	    ":qa<CR>")
		}

alpha.setup(dashboard.opts)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
