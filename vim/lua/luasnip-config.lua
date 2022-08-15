local ls = require("luasnip")

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node -- can be returned from a dynamic node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
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
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),

        --snip({
            --trig = "x",
            --namr = "Comment",
            --dscr = "Big Comment",
        --}, fmt("local {} = require('{}')", {
            --insert(1, "default"),
            --rep(1), -- repeat what was inserted into (1)
        --})),

        snip({
            trig = "x",
            namr = "x",
            dscr = "x",
        }, {
            text("#ifdef "), insert(1, "DEFAULT_HEADER_H_"),
            text({"",
            "#define "}), rep(1),
            text({"",
            ""}), insert(0),
            text({"",
            ""}),
            text({"",
            "#endif // "}), rep(1),
        })
    },
    rust = {
        snip({
            trig = "derive",
            namr = "full derive",
            desc = "full derive template",
        }, {
            text("#[derive(Debug, Copy, Clone, PartialEq, Eq)]")
        }),

    },
})
