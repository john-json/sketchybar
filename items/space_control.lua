local colors = require("colors")
local settings = require("settings")
local icons = require("icons")
local app_icons = require("helpers.app_icons")

local space_control = sbar.add("item", "front_app", {
    icon = {
        color = colors.bg1,
        string = icons.MC_round,
        font = {
            size = "20",
            style = settings.font.style_map["Bold"],  }
    },
    label = {
        color = colors.bar.bg,
        align = "center",
        font = {
            family = settings.font.text,
            size = 10
        }
    },
    position = "center",
    update_freq = 30,
    background = {
        color = colors.transparent,
        
    },
    sbar.animate(
        "circ",
        25,
        function(space, env)
            local selected = env.SELECTED == "true"
            space:set(
                {
                    icon = {
                        color = {
                            string = icons.MC_round,
                            alpha = selected and 1.0 or 0.0
                        }
                    },
                    background = {
                        drawing = selected and true or false,
                        size = selected and 0.0 or 25.0,
                        color = {
                            alpha = selected and 1.0 or 0.0
                        }
                    }
                }
            )
        end
        
    )
})


