local settings = require("settings")
local colors = require("colors")
local icon = require("icons")

-- Padding item required because of bracket
sbar.add(
    "item",
    {
        position = "right",
        align = "center",
        padding_left = settings.group_paddings,
        padding_right = settings.group_paddings
    }
)

local cal =
    sbar.add(
    "item",
    {
        icon = {
            align = "center",
            color = colors.frost_blue3,
            padding_left = 15,
            font = {
                style = settings.font.style_map["SemiBold"],
                size = 12
            }
        },
        label = {
            color = colors.frost_light,
            padding_right = 5,
            width = 60,
            align = "center",
            font = {
                family = settings.font.text,
                style = settings.font.style_map["Bold"],
                size = 14
            }
        },
        position = "right",
        update_freq = 30,
        background = {
            color = colors.bg1,
            border_width = 0,
            corner_radius = 25,
            height = 30
        }
    }
)

-- Padding item required because of bracket
sbar.add(
    "item",
    {
        position = "right",
        align = "center",
        width = settings.group_paddings
    }
)

cal:subscribe(
    {"forced", "routine", "system_woke"},
    function(env)
        cal:set(
            {
                icon = os.date("%a.%d %b"),
                label = os.date("%H:%M")
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
