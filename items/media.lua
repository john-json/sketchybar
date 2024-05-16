local icons = require("icons")
local colors = require("colors")

local whitelist = {
    ["Spotify"] = true,
    ["Music"] = true
}

local media_cover =
    sbar.add(
    "item",
    {
        position = "left",
        background = {
            color = colors.transparent
        },
        label = {
            drawing = true
        },
        icon = {
            drawing = true,
            string = icons.play,
            padding_right = 0,
            color = colors.bg1,
            font = {
                size = 30
            }
        },
        drawing = true,
        updates = true,
        popup = {
            align = "center",
            horizontal = true
        }
    }
)

local media_artist =
    sbar.add(
    "item",
    {
        position = "left",
        padding_left = -13,
        drawing = true,
        width = 0,
        icon = {
            drawing = true
        },
        label = {
            width = "dynamic",
            font = {
                size = 10
            },
            color = colors.bg1,
            max_chars = 40,
            y_offset = 6
        }
    }
)

local media_title =
    sbar.add(
    "item",
    {
        position = "left",
        padding_left = -10,
        drawing = true,
        icon = {
            drawing = true
        },
        label = {
            font = {
                size = 12
            },
            y_offset = -6
        }
    }
)

sbar.add(
    "item",
    {
        position = "popup." .. media_cover.name,
        icon = {
            string = icons.media.back
        },
        label = {
            drawing = true
        },
        click_script = "nowplaying-cli previous"
    }
)
sbar.add(
    "item",
    {
        position = "popup." .. media_cover.name,
        icon = {
            string = icons.media.play_pause
        },
        label = {
            drawing = true
        },
        click_script = "nowplaying-cli togglePlayPause"
    }
)
sbar.add(
    "item",
    {
        position = "popup." .. media_cover.name,
        icon = {
            string = icons.media.forward
        },
        label = {
            drawing = true
        },
        click_script = "nowplaying-cli next"
    }
)

local interrupt = 0
local function animate_detail(detail)
    if (not detail) then
        interrupt = interrupt - 1
    end
    if interrupt > 0 and (not detail) then
        return
    end

    sbar.animate(
        "tanh",
        30,
        function()
            media_artist:set(
                {
                    label = {
                        width = "dynamic"
                    }
                }
            )
            media_title:set(
                {
                    label = {
                        width = "dynamic"
                    }
                }
            )
        end
    )
end

media_cover:subscribe(
    "media_change",
    function(env)
        if whitelist[env.INFO.app] then
            local drawing = (env.INFO.state == "playing")
            media_artist:set(
                {
                    drawing = drawing,
                    label = env.INFO.artist
                }
            )
            media_title:set(
                {
                    drawing = drawing,
                    label = env.INFO.title
                }
            )
            media_cover:set(
                {
                    drawing = drawing
                }
            )

            if drawing then
                animate_detail(true)
                interrupt = interrupt + 1
                sbar.delay(5, animate_detail)
            else
                media_cover:set(
                    {
                        popup = {
                            drawing = false
                        }
                    }
                )
            end
        end
    end
)

media_cover:subscribe(
    "mouse.entered",
    function(env)
        interrupt = interrupt + 1
        animate_detail(true)
    end
)

media_cover:subscribe(
    "mouse.exited",
    function(env)
        animate_detail(false)
    end
)

media_cover:subscribe(
    "mouse.clicked",
    function(env)
        media_cover:set(
            {
                popup = {
                    drawing = "toggle"
                }
            }
        )
    end
)

media_title:subscribe(
    "mouse.exited.global",
    function(env)
        media_cover:set(
            {
                popup = {
                    drawing = false
                }
            }
        )
    end
)
