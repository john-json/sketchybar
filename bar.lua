local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
    topmost = "window",
    height = 22,
    color = colors.bar.bg,
    padding_right = 0,
    padding_left = 0,
    margin = 20,
    corner_radius = 6,
    y_offset = 6

})
