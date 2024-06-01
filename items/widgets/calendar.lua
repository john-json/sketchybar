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
            position = "center",
            padding_right = 5,
            color = colors.white,
            font = {
                style = settings.font.style_map["Bold"],
                size = 16
            }
        },
        icon = {
            color = colors.yellow,
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
        width = 150
    }
)

-- Padding item required because of bracket
sbar.add("item", {})

cal:subscribe(
    {"forced", "routine", "system_woke"},
    function(env)
        cal:set(
            {
                icon = os.date("%a %d.%M.  %H"),
                label = os.date("%M")
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
