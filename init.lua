require("config.keymaps")
require("config.lazy")
require("config.theme").setup()
require("config.options")
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.fn.system("kitty @ set-spacing padding=0")
-- 	end
-- })
-- vim.api.nvim_create_autocmd("VimLeave", {
-- 	callback = function()
-- 		vim.fn.system("kitty @ set-spacing padding=0")
-- 	end
-- })
