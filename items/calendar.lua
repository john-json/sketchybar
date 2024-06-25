local settings = require("settings")
local colors = require("colors")

-- Background around the cpu item
sbar.add("item", "calendar.padding", {
    position = "right",
    width = settings.group_paddings
})

local cal =
    sbar.add(
        "item",
        {
            position = "right",
            label = {
                padding_right = 10,
                padding_left = 10,
                background = {

                    color = colors.bar.bg,
                    height = 28,
                    corner_radius = 6,
                },
                color = colors.bar.foreground_alt,
                font = {
                    style = settings.font.style_map["Bold"],
                    size = 14
                }
            },
            icon = {
                padding_left = 10,
                padding_right = 10,
                align = "laft",
                color = colors.bar.bg,
                font = {
                    style = settings.font.style_map["Regualr"],
                    size = 12
                }
            },
            update_freq = 30,
            background = {
                color = colors.bar.foreground_alt,
            },
            width = "dynamic",

        }

    )

cal:subscribe(
    { "forced", "routine", "system_woke" },
    function(env)
        cal:set(
            {
                icon = os.date("%A %d %B "),
                label = os.date("􁆸 %H:%M")
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
