local colors = require("colors")
local icons = require("icons")
local settings = require("settings")


local whitelist = {
    ["Spotify"] = true,
    ["Music"] = true
};

local function setup_media_items()
    local media_cover =
        sbar.add(
            "item",
            {
                position = "popup.",
                background = {
                    image = {
                        string = "media.artwork",
                        scale = 0.6,
                    },
                    color = colors.transparent,
                },
                align = "center",

                icon = {
                    string = "",
                    color = colors.green,

                },

                drawing = false,
                updates = true,

            }
        )
    local media_next = sbar.add(
        "item",
        {
            position = "right",
            icon = {

                string = icons.media.forward
            },
            label = {
                drawing = true
            },
            click_script = "nowplaying-cli next"
        }
    )
    local media_play = sbar.add(
        "item",
        {
            position = "right",
            icon = {
                string = icons.media.play_pause
            },
            label = {
                drawing = true
            },
            click_script = "nowplaying-cli togglePlayPause"
        }
    )
    local media_back = sbar.add(
        "item",
        {
            position = "right",
            icon = {
                string = icons.media.back
            },
            label = {
                drawing = true
            },
            click_script = "nowplaying-cli previous"
        }
    )




    local media_artist =
        sbar.add(
            "item",
            {
                position = "popup." .. media_cover.name,
                drawing = true,

                icon = {
                    drawing = false
                },
                label = {
                    style = settings.font.style_map["Bold"],
                    padding_left = 10,
                    width = "dynamic",

                    color = colors.green,


                }
            }
        )

    local media_title =
        sbar.add(
            "item",
            {
                position = "popup." .. media_cover.name,
                drawing = true,
                icon = {
                    drawing = false
                },
                label = {
                    padding_right = 10,
                    color = colors.granit.one,
                    max_chars = 15,


                }
            }
        )

    return media_cover, media_artist, media_title, media_next, media_back, media_play
end

local media_cover, media_artist, media_title, media_next, media_back, media_play = setup_media_items()


local media_container =
    sbar.add(
        "bracket",
        "media_container",
        { media_cover.name, media_back.name, media_play.name, media_next.name },
        {
            -- Padding item required because of bracket
            padding_left = 5,
            padding_right = 5,
            background = {
                color = colors.bar.bg,

            },
            icon = {
                string = "",
                color = colors.green,
                font = {
                    size = 14
                }
            },
        }
    )
sbar.add(
    "item",
    {

        position = "right",
        width = 5
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
        "elastic",
        30,
        function()
            media_play:set(
                {
                    icon = {
                        size = 18,
                        color = colors.foreground_light
                    },
                    label = {

                        width = "dynamic"
                    }
                }
            )
            media_back:set(
                {
                    icon = {
                        font = {
                            size = 12,
                        },

                        color = colors.slategray.two
                    },
                    label = {
                        width = "dynamic"
                    }
                }
            )
            media_next:set(
                {
                    icon = {
                        font = {
                            size = 12,
                        },
                        size = 10,
                        color = colors.slategray.two
                    },
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
                    position = "popup." .. media_cover.name,
                    drawing = drawing,
                    label = env.INFO.artist,
                    popup = {
                        drawing = true
                    }
                }
            )
            media_title:set(
                {
                    position = "popup." .. media_cover.name,
                    drawing = drawing,
                    label = env.INFO.title,
                    popup = {
                        drawing = true
                    }
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
                            drawing = true
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

sbar.add("item", {
    position = "popup." .. media_cover.name,
    icon = { string = icons.media.back },
    label = { drawing = false },
    click_script = "nowplaying-cli previous",
})
sbar.add("item", {
    position = "popup." .. media_cover.name,
    icon = { string = icons.media.play_pause },
    label = { drawing = false },
    click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
    position = "popup." .. media_cover.name,
    icon = { string = icons.media.forward },
    label = { drawing = false },
    click_script = "nowplaying-cli next",
})

return media_container
