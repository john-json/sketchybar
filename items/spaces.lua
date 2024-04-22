local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Define SF icons for spaces
local sf_icons_active = {"1", "2", "3", "􁸟", "􁸟", "􁸟", "􁸟", "􁸟", "􁸟", "􁸟"}
local sf_icons_inactive = {"􀑌", "􀑌", "􀑌", "􀑌", "􀑌", "􀑌", "􀑌", "􀑌", "􀑌", "􀑌"} -- Icons for inactive spaces

local function getSpaceIcon(space, active)
    if active then
        return sf_icons_active[space]
    else
        return sf_icons_inactive[space]
    end
end

local function animateBackground(space)
    for i = 1, 10 do
        spaces[i]:set("space", "space." .. i, {
            background = {
                color = i == space and colors.inactive or colors.transparent,
                alpha = 0.0 or 0.1
            }
        })
    end
end

local spaces = {}

for i = 1, 10, 1 do
    local space = sbar.add("space", "space." .. i, {
        position = "center",
        space = i,
        icon = {
            font = {
                family = settings.font.icons
            },
            string = getSpaceIcon(i, false), -- Use inactive icon by default
            color = colors.grey,
            highlight_color = colors.inactive
        },
        padding_right = 1,
        padding_left = 1,
        background = {
            padding_left = 10,
            padding_right = 10,
            color = colors.inactive,
            border_width = 0,
            height = 18,
            border_color = colors.inactive
        },
        popup = {
            background = {
                border_width = 0,
                border_color = colors.inactive
            }
        }
    })

    -- spaces[i] = space

    -- Single item bracket for space items to achieve double border on highlight
    local space_bracket = sbar.add("bracket", {space.name}, {
        background = {
            padding_left = 10,
            color = colors.transparent,
            height = 18,
            border_width = 0
        },
        icon = {
            string = getSpaceIcon(i, true) -- Use inactive icon by default
        }
    })

    -- -- Padding space
    -- sbar.add("space", "space.padding." .. i, {
    --     space = i,
    --     script = "",
    --     width = settings.group_paddings
    -- })

    -- local space_popup = sbar.add("item", {
    --     position = "popup." .. space.name,
    --     padding_left = 5,
    --     padding_right = 0,
    --     background = {
    --         drawing = true,
    --         image = {
    --             corner_radius = 9,
    --             scale = 0.2
    --         }
    --     }
    -- })

    space:subscribe("space_change", function(env)
        local selected = env.SELECTED == "true"
        space:set({
            label = {
                width = selected and 40,
                font = {
                    family = settings.font.text,
                    style = settings.font.style_map["Regular"],
                    size = 16.0
                },
                string = env.INFO
            },
            background = {
                padding_left = 5,
                padding_right = 5
            },

            icon = {
                color = selected and colors.inactive or colors.inactive2

            }
        })
        space_bracket:set({
            background = {
                border_color = selected and colors.inactive or colors.transparent,
                padding_left = 20,
                padding_right = 20
            }
        })

        -- Animate the icon change
        sbar.animate("sin", 20, function()
            space:set({
                background = {
                    padding_left = 10,
                    padding_right = 10,
                    drawing = true,
                    color = {
                        alpha = selected and 1.0 or 0.0
                    }
                }
            })
        end)

        -- Animate the background change
        animateBackground(env.INFO.space)
    end)

    space:subscribe("mouse.clicked", function(env)
        if env.BUTTON == "other" then
            space_popup:set({
                background = {
                    image = "space." .. env.SID
                }
            })
            space:set({
                background = {
                    color = {
                        alpha = 0.0
                    }
                },
                popup = {
                    drawing = "toggle"
                }
            })
        else
            -- Switch to the specified space using Mission Control
            os.execute('osascript -e "tell application \\"System Events\\" to keystroke \\".\\" using {control down}"')
        end
    end)

    space:subscribe("mouse.exited", function(_)
        space:set({
            popup = {
                drawing = false
            }
        })
    end)
end

local space_window_observer = sbar.add("item", {
    drawing = false,
    updates = true
})

local spaces_indicator = sbar.add("item", {
    padding_left = -0,
    padding_right = 0,
    icon = {
        position = "center",
        padding_left = 5,
        padding_right = 5,
        color = colors.grey,
        string = icons.switch.on
    },
    label = {
        width = 8,
        padding_left = 10,
        padding_right = 0,
        string = "",
        color = colors.grey
    },
    background = {
        color = colors.with_alpha(colors.inactive, 1.0),
        border_color = colors.with_alpha(colors.inactive, 0.0)
    }
})

-- space_window_observer:subscribe("space_windows_change", function(env, selected)
--     local icon_line = ""
--     local no_app = selected and false
--     for app, count in pairs(env.INFO.apps) do
--         no_app = selected and false
--         local lookup = selected and app_icons[app]
--         local icon = selected and ((lookup == nil) and selected and app_icons["default"] or lookup)
--         icon_line = selected and icon_line
--     end

--     if (no_app) then
--         icon_line = selected and " "
--     end
--     sbar.animate("space_window_observer", 20, function()
--         spaces[env.INFO]:set({
--             label = selected and icon_line
--         })
--     end)
-- end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
    local currently_on = spaces_indicator:query().icon.value == icons.switch.on
    spaces_indicator:set({
        icon = currently_on and icons.switch.off or icons.switch.on
    })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
    sbar.animate("sin", 30, function()
        spaces_indicator:set({
            background = {
                color = {
                    alpha = 1.0
                },
                border_color = {
                    alpha = 1.0
                }
            },
            icon = {
                color = colors.grey
            },
            label = {
                width = "dynamic"
            }
        })
    end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
    sbar.animate("sin", 30, function()
        spaces_indicator:set({
            background = {
                color = {
                    alpha = 1.0
                },
                border_color = {
                    alpha = 0.0
                }
            },
            icon = {
                color = colors.grey
            },
            label = {
                width = 8
            }
        })
    end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)
