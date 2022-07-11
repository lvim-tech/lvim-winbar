local M = {}

local function isempty(s)
    return s == nil or s == ""
end

-- local hl_group_1 = "FileTextColor"
-- vim.api.nvim_set_hl(0, hl_group_1, { fg = "ff0000", bg = "00ffff", bold = true })

M.get_file_name = function()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    if not isempty(filename) then
        local file_icon, file_icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        local hl_group = "FileIconColor" .. extension
        vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
        if isempty(file_icon) then
            file_icon = ""
            file_icon_color = ""
        end
        return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%* %#LvimWinBarFileText#" .. filename .. "%*"
    end
end

return M
