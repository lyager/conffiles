-- Colors
local colorscheme = "solarized8_flat"
vim.opt.termguicolors = true
vim.cmd("syntax enable")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
