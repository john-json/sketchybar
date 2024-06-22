local colors = require("colors")
local settings = require("settings")
local arrow_icon = sbar.add("item", "arrow_icon", {
    position = "center",
    label = {

        string = "􀬑",
        color = colors.bar.bg,
        font = {
            size = 14,
        }

    }
})


local front_app = sbar.add("item", "front_app", {
    position = "center",
    display = "active",
    icon = { drawing = true, string = "" },
    background = {
        color = colors.bar.bg,
    },
    label = {
        padding_left = 10,
        padding_right = 10,
        color = colors.lightgray,
        font = {
            style = settings.font.style_map["Black"],
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
