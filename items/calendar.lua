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
        color = colors.grey,
        padding_right = 10,
        padding_left = 10,
        width = 80,
        align = "right",
        font = {
            family = settings.font.text,
            size = 10
        }

    },
    position = "right",
    update_freq = 30,
    padding_left = 1,
    padding_right = 1,
    background = {
        color = colors.inactive,
        border_color = colors.inactive,
        border_width = 0,
        height = 20,
        corner_radius = 6
    }
})

-- Padding item required because of bracket
sbar.add("item", {
    position = "right",
    width = settings.group_paddings
})

cal:subscribe({"forced", "routine", "system_woke"}, function(env)
    cal:set({
        icon = os.date("%a. %d."),
        label = os.date("􀐫 %H:%M")
    })
end)

cal:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Calendar'")
end)
