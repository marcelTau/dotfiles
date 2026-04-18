local palette = {
  white = "#ffffff",
  paper = "#f3f5f7",
  ink = "#000000",
  blue = "#0059d6",
  blue_soft = "#dbe9ff",
  comment = "#5f6b7a",
  doc = "#0c6b58",
  red = "#b42318",
  orange = "#b54708",
  green = "#027a48",
  cyan = "#0f766e",
  purple = "#6941c6",
  border = "#cfd8e3",
  line = "#e7edf3",
  selection = "#d7e7ff",
  cursorline = "#f5f9ff",
}

local function set(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "marcel-light"
vim.o.background = "light"

set("Normal", { fg = palette.ink, bg = palette.white })
set("NormalFloat", { fg = palette.ink, bg = palette.paper })
set("FloatBorder", { fg = palette.border, bg = palette.paper })
set("CursorLine", { bg = palette.cursorline })
set("CursorLineNr", { fg = palette.blue, bg = palette.cursorline, bold = true })
set("LineNr", { fg = palette.comment, bg = palette.white })
set("ColorColumn", { bg = palette.paper })
set("CursorColumn", { bg = palette.paper })
set("Visual", { bg = palette.selection })
set("Search", { fg = palette.ink, bg = "#fff2a8" })
set("IncSearch", { fg = palette.white, bg = palette.blue })
set("MatchParen", { fg = palette.blue, bold = true, underline = true })
set("StatusLine", { fg = palette.ink, bg = palette.paper })
set("StatusLineNC", { fg = palette.comment, bg = palette.paper })
set("VertSplit", { fg = palette.border, bg = palette.white })
set("WinSeparator", { fg = palette.border, bg = palette.white })
set("Pmenu", { fg = palette.ink, bg = palette.paper })
set("PmenuSel", { fg = palette.ink, bg = palette.selection, bold = true })
set("Folded", { fg = palette.comment, bg = palette.paper })
set("SignColumn", { fg = palette.comment, bg = palette.white })
set("DiffAdd", { fg = palette.green, bg = "#e8f7ee" })
set("DiffChange", { fg = palette.blue, bg = "#eaf2ff" })
set("DiffDelete", { fg = palette.red, bg = "#fdecec" })
set("DiffText", { fg = palette.blue, bg = palette.selection, bold = true })

set("Comment", { fg = palette.comment, italic = true })
set("SpecialComment", { fg = palette.doc, bold = true, italic = true })
set("DiagnosticUnnecessary", { fg = palette.comment, italic = true })

set("Constant", { fg = palette.red })
set("String", { fg = palette.green })
set("Character", { fg = palette.green })
set("Number", { fg = palette.orange })
set("Boolean", { fg = palette.orange, bold = true })
set("Float", { fg = palette.orange })

set("Identifier", { fg = palette.ink })
set("Function", { fg = palette.ink, bold = true })

set("Statement", { fg = palette.blue, bold = true })
set("Conditional", { fg = palette.blue, bold = true })
set("Repeat", { fg = palette.blue, bold = true })
set("Label", { fg = palette.blue, bold = true })
set("Operator", { fg = palette.ink })
set("Keyword", { fg = palette.blue, bold = true })
set("Exception", { fg = palette.blue, bold = true })

set("PreProc", { fg = palette.purple })
set("Include", { fg = palette.blue, bold = true })
set("Define", { fg = palette.purple, bold = true })
set("Macro", { fg = palette.purple, bold = true })
set("PreCondit", { fg = palette.purple })

set("Type", { fg = palette.cyan, bold = true })
set("StorageClass", { fg = palette.blue, bold = true })
set("Structure", { fg = palette.cyan, bold = true })
set("Typedef", { fg = palette.cyan, bold = true })

set("Special", { fg = palette.red })
set("SpecialChar", { fg = palette.red })
set("Delimiter", { fg = palette.red })
set("Underlined", { fg = palette.blue, underline = true })
set("Todo", { fg = palette.orange, bg = palette.blue_soft, bold = true })

set("Error", { fg = palette.red, bg = palette.white, bold = true })
set("WarningMsg", { fg = palette.orange, bg = palette.white, bold = true })

set("DiagnosticError", { fg = palette.red })
set("DiagnosticWarn", { fg = palette.orange })
set("DiagnosticInfo", { fg = palette.blue })
set("DiagnosticHint", { fg = palette.cyan })
set("DiagnosticVirtualTextError", { fg = palette.red, bg = "#fdecec", italic = true })
set("DiagnosticVirtualTextWarn", { fg = palette.orange, bg = "#fff1e8", italic = true })
set("DiagnosticVirtualTextInfo", { fg = palette.blue, bg = "#eaf2ff", italic = true })
set("DiagnosticVirtualTextHint", { fg = palette.cyan, bg = "#e7f7f5", italic = true })
set("Added", { fg = palette.green })
set("Removed", { fg = palette.red })
set("Changed", { fg = palette.blue })
set("LspInlayHint", { fg = palette.comment, bg = palette.white })
set("GitSignsAdd", { fg = palette.green, bg = palette.white })
set("GitSignsChange", { fg = palette.blue, bg = palette.white })
set("GitSignsDelete", { fg = palette.red, bg = palette.white })
set("GitSignsCurrentLineBlame", { fg = palette.comment, italic = true })

set("@comment", { link = "Comment" })
set("@comment.documentation", { fg = palette.doc, bold = true, italic = true })
set("@comment.todo", { link = "Todo" })
set("@keyword", { link = "Keyword" })
set("@keyword.function", { fg = palette.blue, bold = true })
set("@keyword.return", { link = "Keyword" })
set("@keyword.import", { link = "Include" })
set("@conditional", { link = "Conditional" })
set("@repeat", { link = "Repeat" })
set("@type", { link = "Type" })
set("@type.builtin", { fg = palette.blue, bold = true })
set("@function", { link = "Function" })
set("@function.builtin", { fg = palette.ink, bold = true })
set("@string.documentation", { fg = palette.doc, italic = true })
