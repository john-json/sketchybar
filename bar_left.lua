local colors = require("colors")
local settings = require("settings")

sbar.left_bar(
    {
        topmost = "window",
        height = 30,
        color = colors.transparent,
        padding_right = settings.paddings,
        padding_left = settings.paddings,
        margin = "",
        corner_radius = 25,
        y_offset = 6
    }
)
