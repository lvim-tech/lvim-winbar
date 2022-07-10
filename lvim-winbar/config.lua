local M = {
    icons = {
        [1] = " ", -- File
        [2] = " ", -- Module
        [3] = " ", -- Namespace
        [4] = " ", -- Package
        [5] = " ", -- Class
        [6] = " ", -- Method
        [7] = " ", -- Property
        [8] = " ", -- Field
        [9] = " ", -- Constructor
        [10] = "練", -- Enum
        [11] = "練", -- Interface
        [12] = " ", -- Function
        [13] = " ", -- Variable
        [14] = " ", -- Constant
        [15] = " ", -- String
        [16] = " ", -- Number
        [17] = "◩ ", -- Boolean
        [18] = " ", -- Array
        [19] = " ", -- Object
        [20] = " ", -- Key
        [21] = "ﳠ ", -- Null
        [22] = " ", -- EnumMember
        [23] = " ", -- Struct
        [24] = " ", -- Event
        [25] = " ", -- Operator
        [26] = " ", -- TypeParameter
    },
    highlight = true,
    separator = " ➤ ",
    depth_limit = 0,
    depth_limit_indicator = "..",
}

return M
