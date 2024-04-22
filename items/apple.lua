local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", {
    width = 15
})

local apple = sbar.add("item", {
    icon = {
        font = {
            size = 14.0
        },
        string = icons.apple,
        padding_right = 10,
        padding_left = 8,
        color = colors.grey,
        height = 18
    },
    label = {
        drawing = false
    },
    background = {
        color = colors.inactive,
        border_color = colors.transparent,
        border_width = 0,
        height = 18

    },
    padding_left = 5,
    padding_right = 5,
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})

-- Double border for apple using a single item bracket
sbar.add("bracket", {apple.name}, {
    background = {
        color = colors.transparent,
        height = 18,
        border_color = colors.transparent,
        border_width = 0
    }
})

