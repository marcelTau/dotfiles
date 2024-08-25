local embedded_sql = vim.treesitter.parse_query("typescript", [[((template_string) @sql_string (#contains? @sql_string "INSERT" "UPDATE" "WHERE"))]])

local get_root = function (bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "typescript", {})
    local tree = parser:parse()[1]
    return tree:root()
end

local run = function (bufnr)
    local root = get_root(bufnr)

    local changes = {}

    for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
        local sql_string = embedded_sql.captures[id]
        if sql_string == "sql" then
            local range = { node:range() }
            local ind
        end
    end
end
