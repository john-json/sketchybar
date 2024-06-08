local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add(
    "item",
    {
        position = "center",
        align = "center"
    }
)

local cal =
    sbar.add(
    "item",
    {
        label = {
            padding_right = 20,
            position = "center",
            color = colors.platinum,
            font = {
                style = settings.font.style_map["Bold"],
                size = 12
            }
        },
        icon = {
            padding_left = 10,
            color = colors.seezalt_smoke,
            font = {
                style = settings.font.style_map["Regular"],
                size = 12
            }
        },
        position = "center",
        update_freq = 30,
        background = {
            color = colors.bg1,
            border_width = 0
        },
        width = "dynamic"
    }
)

-- Padding item required because of bracket
sbar.add("item", {})

cal:subscribe(
    {"forced", "routine", "system_woke"},
    function(env)
        cal:set(
            {
                icon = os.date("􀒏 %A %b.%d /"),
                label = os.date(" 􀐬 %H:%M")
                -- icon = os.date("%a.%d %b. %H"),
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
