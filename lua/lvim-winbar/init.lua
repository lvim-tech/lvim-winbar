local config = require("lvim-winbar.config")
local utils = require("lvim-winbar.utils")
local file_name = require("lvim-winbar.file_name")
local lsp = require("lvim-winbar.lsp")

local M = {}

local group = vim.api.nvim_create_augroup("LvimWinBar", {
    clear = true,
})

local excludes = function()
    if vim.tbl_contains(config.blacklist_ft, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return true
    end
    return false
end

local is_empty = function(s)
    return s == nil or s == ""
end

local function get_winbar()
    if excludes() then
        return
    end
    local value = file_name.get_file_name()
    if is_empty(value) then
        vim.opt_local.winbar = nil
        return
    end

    -- local names = {}
    -- for i, server in pairs(vim.lsp.buf_get_clients(0)) do
    --     table.insert(names, server.name)
    -- end
    local bufnr = vim.api.nvim_get_current_buf()
    local a = vim.lsp.get_active_clients()
    vim.notify(vim.inspect(a))

    -- local lsp_value = lsp.get_lsp()
    -- if not is_empty(lsp_value) then
    --     value = value .. " " .. lsp_value
    -- end
    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
    if not status_ok then
        return
    end
end

M.setup = function(user_config)
    if vim.fn.has("nvim-0.8") == 1 then
        if user_config ~= nil then
            utils.merge(config, user_config)
        end
        vim.api.nvim_create_autocmd(
            { "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
            {
                callback = function()
                    get_winbar()
                end,
                group = group,
            }
        )
    end
end

M.attach = function(client, bufnr)
    if not client.server_capabilities.documentSymbolProvider then
        return
    end
    -- vim.opt_local.winbar = "%{%v:lua.require'lvim-winbar.file_name'.get_file_name()%}"
    -- vim.api.nvim_create_autocmd({ "WinEnter" }, {
    --     -- command = "%{%v:lua.require'lvim-winbar.file_name'.get_file_name()%}",
    --     callback = function()
    --         vim.opt_local.winbar = "%{%v:lua.require'lvim-winbar.file_name'.get_file_name()%}"
    --         -- vim.defer_fn(function()
    --         -- vim.schedule(function()
    --         --     vim.opt_local.winbar = "%{%v:lua.require'languages.base.utils.file_name'.get_file_name()%}"
    --         -- end)
    --         -- end, 1000)
    --         -- vim.sc
    --     end,
    --     group = group,
    --     buffer = bufnr,
    -- })
    -- vim.opt_local.winbar = "%{%v:lua.require'languages.base.utils.file_name'.get_file_name()%}  %{%v:lua.require'nvim-navic'.get_location()%}"
    -- vim.opt_local.winbar = "hello"
end

return M
