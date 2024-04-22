local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("graph", "widgets.cpu", 42, {
    position = "right",
    graph = {
        color = colors.green
    },
    background = {
        height = 18,
        color = colors.inactive,
        border_color = {
            alpha = 0
        },
        drawing = true
    },
    icon = {
        string = icons.cpu,
        padding_right = 5,
        color = colors.grey
    },
    label = {
        padding_right = 10,
        string = "cpu ??%",
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Bold"],
            size = 9.0
        },
        align = "right",
        width = 10,
        y_offset = 4
    }
})

cpu:subscribe("cpu_update", function(env)
    -- Also available: env.user_load, env.sys_load
    local load = tonumber(env.total_load)
    cpu:push({load / 100.})

    local color = colors.green
    if load > 30 then
        if load < 60 then
            color = colors.grey
        elseif load < 80 then
            color = colors.active
        else
            color = colors.red
        end
    end

    cpu:set({
        graph = {
            color = colors.grey
        },
        label = "cpu " .. env.total_load .. "%"
    })
end)

cpu:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Activity Monitor'")
end)

-- Background around the cpu item
sbar.add("bracket", "widgets.cpu.bracket", {cpu.name}, {
    background = {
        color = colors.transparent,
        border_width = 0
    }
})

-- Background around the cpu item
sbar.add("item", "widgets.cpu.padding", {
    position = "right",
    width = settings.group_paddings
})
