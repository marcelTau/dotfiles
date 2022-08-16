local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node -- can be returned from a dynamic node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local dyn = ls.dynamic_node
local types = require("luasnip.util.types")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- KEYMAPS
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", opts)
keymap("i", "<c-l>", "<cmd>lua require'luasnip'.change_choice(1)<CR>", opts)

-- DEFALUT CONFIG
ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
}


local date = function() return {os.date('%Y-%m-%d')} end
keymap("n", "<leader><leader>g", "<cmd>source ~/.config/nvim/lua/luasnip-config.lua<CR>", opts)
ls.add_snippets(nil, {
    all = {
        s({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            f(date, {}),
        }),
    },
    cmake = {
        s("cmakeinit", fmt([[
cmake_minimum_required(VERSION {})
project({})
set(CMAKE_CXX_STANDARD 20)
        ]], { c(1, { t("3.22.1"), t("")}), i(2) })),
    },
    cpp = {
        s({
            trig = "header",
            namr = "header",
            dscr = "header",
        }, {
            t("#ifdef "), i(1, "DEFAULT_HEADER_H_"),
            t({"",
            "#define "}), rep(1),
            t({"",
            ""}), i(0),
            t({"",
            ""}),
            t({"",
            "#endif // "}), rep(1),
        })
    },
    rust = {
        s("ils", fmt([[if let Some({}) = {}]], { i(1), i(0) })),
        s({
            trig = "derive",
            namr = "full derive",
            desc = "full derive template",
        }, {
            t("#[derive(Debug, Copy, Clone, PartialEq, Eq)]")
        }),

    },
})
