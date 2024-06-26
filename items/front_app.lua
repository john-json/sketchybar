local colors = require("colors")
local settings = require("settings")


local front_app = sbar.add("item", "front_app", {
    position = "left",
    display = "active",
    label = {
        padding_left = 10,
        padding_right = 20,
        color = colors.bar.foreground_alt,
        font = {
            style = settings.font.style_map["Semibold"],
            size = 14.0,
        },
    },
    updates = true,
})

front_app:subscribe("front_app_switched", function(env)
    front_app:set({
        label = { string = env.INFO },
    })
end)

front_app:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)
