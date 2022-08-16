local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< DotFiles >",
        search_dirs = {
            "$HOME/git/personal/dotfiles",
            "$HOME/git/personal/dotfiles/vim/lua",
        }
    })
end

return M
