local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar(
    {
        topmost = "window",
        height = 32,
        color = colors.transparent,
        padding_right = 0,
        padding_left = 0,
        margin = 10,
        corner_radius = 8,
        y_offset = 4,
        shadow = true
    }
)
