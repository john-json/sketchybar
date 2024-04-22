local colors = require("colors")
local settings = require("settings")
local icons = require("icons")
local app_icons = require("helpers.app_icons")

local front_app = sbar.add("item", "front_app", {
    -- icon = {
    --     color = colors.bg2,
    --     padding_left = 10,
    --     font = {
    --         style = settings.font.style_map["Regular"],
    --         14.0
    --     }
    -- },
    label = {
        color = colors.grey,
        padding_right = 10,
        padding_left = 5,
        align = "center",
        font = {
            family = settings.font.text,
            size = 10
        }
    },
    position = "left",
    update_freq = 30,
    background = {
        color = colors.inactive,
        height = 20
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
