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
                padding_right = 10,
                position = "right",
                color = colors.white,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 19
                }
            },
            icon = {
                align = "right",

                color = colors.grey,
                font = {
                    style = settings.font.style_map["Regular"],
                    size = 14
                }
            },
            position = "right",
            update_freq = 30,
            background = {
                height = 16,
                color = colors.bg2,
                border_width = 0
            },

            width = "60",

        }
    )


cal:subscribe(
    { "forced", "routine", "system_woke" },
    function(env)
        cal:set(
            {
                icon = os.date("%H"),
                label = os.date("%M ")
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
