local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local whitelist = {
    ["Spotify"] = true
}

local function setup_media_items()
    local media_cover =
        sbar.add(
        "item",
        {
            position = "right",
            align = "center",
            label = {
                drawing = true
            },
            icon = {
                drawing = true,
                string = "",
                color = colors.green,
                font = {
                    size = 12
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
            position = "right",
            drawing = true,
            width = 0,
            icon = {
                drawing = false
            },
            label = {
                padding_left = 10,
                width = "dynamic",
                font = {
                    size = 10
                },
                color = colors.orange,
                max_chars = 25,
                y_offset = 6
            }
        }
    )

    local media_title =
        sbar.add(
        "item",
        {
            position = "right",
            drawing = true,
            icon = {
                drawing = false
            },
            label = {
                padding_left = 10,
                color = colors.frost_light,
                max_chars = 25,
                font = {
                    size = 10
                },
                y_offset = -5
            }
        }
    )

    return media_cover, media_artist, media_title
end

local media_cover, media_artist, media_title = setup_media_items()

local media_container =
    sbar.add(
    "bracket",
    "media_container",
    {media_cover.name, media_artist.name, media_title.name},
    {
        background = {
            color = colors.bg1,
            padding_right = 20
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

return media_container
