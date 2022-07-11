local M = {}

local function update_context(for_buf)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    if navic_context_data[for_buf] == nil then
        navic_context_data[for_buf] = {}
    end
    local old_context_data = navic_context_data[for_buf]
    local new_context_data = {}

    local curr = navic_symbols[for_buf]

    if curr == nil then
        return
    end

    -- Find larger context that remained same
    for _, context in ipairs(old_context_data) do
        if
            in_range(cursor_pos, context.scope) == 0
            and curr[context.index] ~= nil
            and context.name == curr[context.index].name
            and context.kind == curr[context.index].kind
        then
            table.insert(new_context_data, curr[context.index])
            curr = curr[context.index].children
        else
            break
        end
    end

    -- Fill out context_data
    while curr ~= nil do
        local go_deeper = false
        local l = 1
        local h = #curr
        while l <= h do
            local m = bit.rshift(l + h, 1)
            local comp = in_range(cursor_pos, curr[m].scope)
            if comp == -1 then
                h = m - 1
            elseif comp == 1 then
                l = m + 1
            else
                table.insert(new_context_data, curr[m])
                curr = curr[m].children
                go_deeper = true
                break
            end
        end
        if not go_deeper then
            break
        end
    end

    navic_context_data[for_buf] = new_context_data
end

M.get_lsp = function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local bufnr = vim.api.nvim_get_current_buf()
    -- local a = vim.lsp.get_client_by_id(bufnr)
    local a = vim.lsp.codelens.get(bufnr)
    vim.notify(vim.inspect(a))
    return a
    -- return tostring(cursor_pos[1])
end

return M
