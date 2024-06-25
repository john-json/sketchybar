local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
    position = "center",
    display = "active",
    icon = { drawing = true, string = "" },
    background = {
        color = colors.bar.bg,
    },
    label = {
        padding_left = 20,
        padding_right = 20,
        color = colors.bar.foreground_alt,
        font = {
            style = settings.font.style_map["SemiBold"],
            size = 14.0,

        },
    },
    updates = true,
})

front_app:subscribe("front_app_switched", function(env)
    front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)
