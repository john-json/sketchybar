local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- Define SF icons for spaces
local sf_icons_active = {"􀝷", "􀝷", "􀝷", "􀝷", "􀝷", "􀝷", "􀝷", "􀝷", "􀝷", "􀝷"} -- Icons for active spaces
local sf_icons_inactive = {"􀀁", "􀍂", "􀍃", "􀍄", "􀍅", "􀍆", "􀍇", "􀍈", "􀍉", "􀍊"} -- Icons for inactive spaces

local function getSpaceIcon(space, active)
    if active then
        return sf_icons_active[space]
    else
        return sf_icons_inactive[space]
    end
end

local spaces = {}

for i = 1, 10, 1 do
    local space = sbar.add("space", "space." .. i, {
        space = i,
        icon = {
            font = {
                family = settings.font.icons
            },
            string = getSpaceIcon(i, false), -- Use inactive icon by default
            padding_left = 15,
            padding_right = 8,
            color = colors.white,
            highlight_color = colors.red
        },
        label = {
            padding_right = 20,
            color = colors.grey,
            highlight_color = colors.grey,
            font = "sketchybar-app-font:Regular:16.0",
            y_offset = -1
        },
        padding_right = 1,
        padding_left = 1,
        background = {
            color = colors.transparent,
            border_width = 0,
            height = 22,
            border_color = colors.transparent
        },
        popup = {
            background = {
                border_width = 1,
                border_color = colors.inactive
            }
        }
    })

    spaces[i] = space

    -- Single item bracket for space items to achieve double border on highlight
    local space_bracket = sbar.add("bracket", {space.name}, {
        background = {
            color = colors.transparent,
            border_color = colors.transparent,
            height = 22,
            border_width = 0
        }
    })

    -- Padding space
    sbar.add("space", "space.padding." .. i, {
        space = i,
        script = "",
        width = settings.group_paddings
    })

    local space_popup = sbar.add("item", {
        position = "popup." .. space.name,
        padding_left = 5,
        padding_right = 0,
        background = {
            drawing = true,
            image = {
                corner_radius = 9,
                scale = 0.2
            }
        }
    })

    space:subscribe("space_change", function(env)
        local selected = env.SELECTED == "true"
        local color = selected and colors.grey or colors.bg2
        space:set({
            icon = {
                string = getSpaceIcon(env.INFO.space, selected)
            }, -- Set appropriate icon based on space state
            label = {
                highlight = selected and colors.grey
            },
            background = {
                border_color = selected and colors.inactive or colors.transparent
            }
        })
        space_bracket:set({
            background = {
                border_color = selected and colors.grey or colors.bg2
            }
        })
    end)

    space:subscribe("mouse.clicked", function(env)
        if env.BUTTON == "other" then
            space_popup:set({
                background = {
                    image = "space." .. env.SID
                }
            })
            space:set({
                popup = {
                    drawing = "toggle"
                }
            })
        else
            -- Switch to the specified space using Mission Control
            os.execute('osascript -e "tell application \\"System Events\\" to keystroke \\"' .. i ..
                           '\\" using {control down, option down}"')
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
    padding_left = -3,
    padding_right = 0,
    icon = {
        padding_left = 8,
        padding_right = 9,
        color = colors.inactive,
        string = icons.switch.on
    },
    label = {
        width = 0,
        padding_left = 0,
        padding_right = 8,
        string = "Menu",
        color = colors.grey
    },
    background = {
        color = colors.with_alpha(colors.inactive, 0.0),
        border_color = colors.with_alpha(colors.bg1, 0.0)
    }
})

space_window_observer:subscribe("space_windows_change", function(env)
    local icon_line = ""
    local no_app = true
    for app, count in pairs(env.INFO.apps) do
        no_app = false
        local lookup = app_icons[app]
        local icon = ((lookup == nil) and app_icons["default"] or lookup)
        icon_line = icon_line .. " " .. icon
    end

    if (no_app) then
        icon_line = "􁋞"
    end
    sbar.animate("tanh", 10, function()
        spaces[env.INFO.space]:set({
            label = icon_line
        })
    end)
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
    local currently_on = spaces_indicator:query().icon.value == icons.switch.on
    spaces_indicator:set({
        icon = currently_on and icons.switch.off or icons.switch.on
    })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
    sbar.animate("tanh", 30, function()
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
    sbar.animate("tanh", 30, function()
        spaces_indicator:set({
            background = {
                color = {
                    alpha = 0.0
                },
                border_color = {
                    alpha = 0.0
                }
            },
            icon = {
                color = colors.inactive
            },
            label = {
                width = 0
            }
        })
    end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
    sbar.trigger("swap_menus_and_spaces")
end)
