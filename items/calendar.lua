local settings = require("settings")
local colors = require("colors")
local icon = require("icons")

-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

local cal = sbar.add("item", {
    icon = {
        color = colors.grey,
        padding_left = 10,
        font = {
            style = settings.font.style_map["Black"],
            size = 10
        }
    },
    label = {
        color = colors.white,
        padding_right = 10,
        width = 55,
        align = "right",
        font = {
            family = settings.font.text,
            style = settings.font.style_map["Black"],
            size = 12
        }

    },
    position = "right",
    update_freq = 30,
    padding_left = 5,
    padding_right = 5,
    background = {
        color = colors.bg1,
        border_color = colors.text_active,
        border_width = 0,
        corner_radius = 8
    }
})

-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

cal:subscribe({"forced", "routine", "system_woke"}, function(env)
    cal:set({
        icon = os.date("%a.%d "),
        label = os.date("%H:%M")
    })
end)

cal:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Calendar'")
end)
