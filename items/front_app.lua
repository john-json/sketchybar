local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local front_app = sbar.add("item", "front_app", {
    icon = {
        color = colors.bg2,
        padding_left = 8,
        font = {
            style = settings.font.style_map["Black"],
            size = 14.0
        }
    },
    label = {
        color = colors.bg2,
        padding_right = 12,
        min_width = 80,
        align = "center",
        font = {
            family = settings.font.numbers
        }
    },
    position = "center",
    update_freq = 30,
    padding_left = 1,
    padding_right = 1,
    background = {
        color = colors.yellow,
        border_color = colors.border2,
        border_width = 1,
        height = 28
    }
})

front_app:subscribe("front_app_switched", function(env)
    front_app:set({
        label = {
            string = env.INFO
        }
    })
end)

front_app:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)
