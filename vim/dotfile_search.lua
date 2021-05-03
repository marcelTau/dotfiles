local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< DotFiles >",
        cwd = "$HOME/GIT/personal/dotfiles/",
    })
end

return M
