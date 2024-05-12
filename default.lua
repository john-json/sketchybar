local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
    updates = "when_shown",
    icon = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Bold"],
            size = 18.0
        },
        color = colors.text_active,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
        background = {
            image = {
                corner_radius = 8
            }
        }
    },
    label = {
        font = {
            family = settings.font.text,
            style = settings.font.style_map["SemiBold"],
            size = 16.0
        },
        color = colors.fontColor,
        padding_left = settings.paddings,
        padding_right = settings.paddings
    },
    background = {
        height = 28,
        corner_radius = 8,
        border_width = 0,
        border_color = colors.border2,
        image = {
            corner_radius = 8,
            border_color = colors.black,
            border_width = 1
        }
    },
    popup = {
        background = {
            border_width = 1,
            corner_radius = 8,
            border_color = colors.popup.border,
            color = colors.popup.bg,
            shadow = {
                drawing = true
            }
        },
        blur_radius = 60
    },
    padding_left = 10,
    padding_right = 10,
    scroll_texts = true
})
