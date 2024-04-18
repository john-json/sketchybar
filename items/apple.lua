local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", {
    width = 5
})

local apple = sbar.add("item", {
    icon = {
        font = {
            size = 14.0
        },
        string = icons.menu_bar,
        padding_right = 0,
        padding_left = 0,
        color = colors.inactive,
        width = 20,
        hieght = 20
    },
    label = {
        drawing = false
    },
    background = {
        color = colors.transparent,
        border_color = colors.transparent,
        border_width = 0,
        hieght = 20

    },
    padding_left = 1,
    padding_right = 1,
    click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})

-- Double border for apple using a single item bracket
sbar.add("bracket", {apple.name}, {
    background = {
        color = colors.transparent,
        hieght = 20,
        border_color = colors.transparent,
        border_width = 0
    }
})

-- Padding item required because of bracket
sbar.add("item", {
    width = 7
})
