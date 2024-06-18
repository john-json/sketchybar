local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

sbar.add(
    "item",
    {

        position = "right",
        width = 800,

    }
)
sbar.add(
    "item",
    {

        position = "left",
        width = 1400,

    }
)

local spacer =
    sbar.add(
        "item",
        "spacer_container",
        {
            width = 0,
        }
    )


local left =
    sbar.add(
        "item",

        {

            position = "left",

            label = {
                width = 40,
                drawing = false,

            },
        }
    )

local right =
    sbar.add(
        "item",

        {

            position = "right",

            label = {
                width = 40,
                drawing = false,

            },
        }
    )

-- Double border for apple using a single item bracket
sbar.add("bracket", "items.widgets.spaces.bracket", { spacer.name, left.name, right.name }, {


    background = {
        margin = 100,
        position = "right",
        padding_left = 20,
        color = colors.bar.bg,
        height = 30,

        border_color = colors.grey,

    }
})
