return {
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --       vim.cmd([[colorscheme tokyonight]])
    --     end,
    -- },
    { "wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-material-dark-medium]])
			--vim.o.background = 'dark'
			-- XXX: hi Normal ctermbg=NONE
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
			vim.api.nvim_set_hl(0, 'Comment', bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
			vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end
  },
--   {
-- 		'itchyny/lightline.vim',
-- 		lazy = false, -- also load at start since it's UI
-- 		config = function()
-- 			-- no need to also show mode in cmd line when we have bar
-- 			vim.o.showmode = false
-- 			vim.g.lightline = {
-- 				active = {
-- 					left = {
-- 						{ 'mode', 'paste' },
-- 						{ 'readonly', 'filename', 'modified' },
--             			{ 'gitbranch', 'readonly', 'filename', 'modified' }
-- 					},
-- 					right = {
-- 						{ 'lineinfo' },
-- 						{ 'percent' },
-- 						{ 'fileencoding', 'filetype' }
-- 					},
-- 				},
-- 				component_function = {
-- 					filename = 'LightlineFilename',
--           			gitbranch = 'FugitiveHead'
-- 				},
-- 			}
-- 			function LightlineFilenameInLua(opts)
-- 				if vim.fn.expand('%:t') == '' then
-- 					return '[No Name]'
-- 				else
-- 					return vim.fn.getreg('%')
-- 				end
-- 			end
-- 			-- https://github.com/itchyny/lightline.vim/issues/657
-- 			vim.api.nvim_exec(
-- 				[[
-- 				function! g:LightlineFilename()
-- 					return v:lua.LightlineFilenameInLua()
-- 				endfunction
-- 				]],
-- 				true
-- 			)
-- 		end
-- 	},
	{ "miikanissi/modus-themes.nvim", priority = 1000, config = function() 
		-- vim.cmd([[colorscheme modus_operandi]])
	end }
}
