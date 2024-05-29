local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add(
    "item",
    {
        position = "right",
        align = "center"
    }
)

local cal =
    sbar.add(
    "item",
    {
        label = {
            position = "right",
            align = "center",
            color = colors.frost_light,
            padding_left = 0,
            padding_right = 10,
            font = {
                style = settings.font.style_map["Bold"],
                size = 14
            }
        },
        icon = {
            align = "center",
            color = colors.frost_blue1,
            padding_left = 10,
            font = {
                style = settings.font.style_map["Regular"],
                size = 12
            }
        },
        position = "right",
        update_freq = 30,
        background = {
            align = "center",
            padding_left = 0,
            color = colors.bg1,
            border_width = 0
        },
        width = 150
    }
)

-- Padding item required because of bracket
sbar.add(
    "item",
    {
        position = "right",
        align = "center"
    }
)

cal:subscribe(
    {"forced", "routine", "system_woke"},
    function(env)
        cal:set(
            {
                icon = os.date("%a.%d %b.  %H"),
                label = os.date("%M")
            }
        )
    end
)

cal:subscribe(
    "mouse.clicked",
    function(env)
        sbar.exec("open -a 'Calendar'")
    end
)
