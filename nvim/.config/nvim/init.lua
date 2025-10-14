local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.cmd([[
  augroup TransparentSignColumn
    autocmd!
    autocmd WinScrolled * :highlight SignColumn ctermbg=none guibg=none
    autocmd WinScrolled * :highlight FoldColumn ctermbg=none guibg=none
  augroup END
]])

vim.env.GOPATH = os.getenv("HOME") .. "/go"
vim.env.GOMODCACHE = os.getenv("HOME") .. "/go/pkg/mod"

require("vim-options")
require("help-floating")
require("vim-helpers")
require("go-gen-mapping")
require("lazy").setup("plugins")
