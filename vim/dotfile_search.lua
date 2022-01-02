local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< DotFiles >",
        --cwd = "$HOME/GIT/personal/dotfiles/",
        search_dirs = {
            "$HOME/GIT/personal/dotfiles",
            "$HOME/my_scripts"
        }
    })
end

return M
