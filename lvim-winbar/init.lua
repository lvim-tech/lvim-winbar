local config = require("lvim-winbar.config")
local utils = require("lvim-winbar.utils")

local M = {}

local group = vim.api.nvim_create_augroup("LvimWinBar", {
    clear = true,
})

M.setup = function(user_config)
    if vim.fn.has("nvim-0.8") == 1 then
        if user_config ~= nil then
            utils.merge(config, user_config)
        end
        vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
            command = "setlocal winbar=",
            group = group,
        })
    end
end

M.attach = function(client, bufnr)
    if not client.server_capabilities.documentSymbolProvider then
        return
    end
    -- vim.opt_local.winbar = "%{%v:lua.require'languages.base.utils.file_name'.get_file_name()%}  %{%v:lua.require'nvim-navic'.get_location()%}"
    vim.opt_local.winbar = "hello"
end

return M
