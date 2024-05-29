local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar(
    {
        topmost = "window",
        height = 30,
        color = colors.transparent,
        padding_right = 5,
        padding_left = 5,
        margin = -20,
        corner_radius = 6,
        y_offset = 6,
        shadow = true
    }
)
