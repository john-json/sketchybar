local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar(
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
