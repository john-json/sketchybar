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
            position = "right",

            label = {
                padding_right = 10,
                position = "left",
                color = colors.dimgray.one,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 14
                }
            },
            icon = {
                padding_left = 10,
                align = "laft",
                color = colors.dimgray.two,
                font = {
                    style = settings.font.style_map["SemiBold"],
                    size = 12

                }
            },

            update_freq = 30,
            background = {

                color = colors.bg1,
                border_width = 0
            },

            width = "dynamic",

        }
    )


cal:subscribe(
    { "forced", "routine", "system_woke" },
    function(env)
        cal:set(
            {
                icon = os.date("%a.%d 􀥤 %H"),
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
