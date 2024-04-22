local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
    updates = "when_shown",
    icon = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Bold"],
            size = 16.0
        },
        color = colors.inactive,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
        background = {
            image = {
                corner_radius = 6
            }
        }
    },
    label = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Regular"],
            size = 16.0
        },
        color = colors.fontColor,
        padding_left = settings.paddings,
        padding_right = settings.paddings
    },
    background = {
        height = 20,
        corner_radius = 6,
        border_width = 0,
        border_color = colors.border2,
        image = {
            corner_radius = 6,
            border_color = colors.white,
            border_width = 1
        }
    },
    popup = {
        background = {
            border_width = 1,
            corner_radius = 6,
            border_color = colors.popup.border,
            color = colors.popup.bg,
            shadow = {
                drawing = true
            }
        },
        blur_radius = 50
    },
    padding_left = 5,
    padding_right = 5,
    scroll_texts = true
})
