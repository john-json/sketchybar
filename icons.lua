local settings = require("settings")

local icons = {
    sf_symbols = {
        plus = "􀅼",
        loading = "􀖇",
        apple = "􀣺",
        line = "􀝷",
        gear = "􀍟",
        cpu = "􀫥",
        clipboard = "􀉄",
        aqi = "􀴿",
        bookmark = "􀉟",
        clock = "􀐫",
        Tornado = "􁛴",
        arrow_circle_down = "􀁱",
        pill = "􀝷",
        pill_lines = "􀝶",
        stack = "􀐋",
        stack_right = "􀧏",
        direct_current = "􀯝",
        rotate_circle = "􁱀",
        arrow_down = "􀆈",
        menu_bar2 = "􀾚",
        menu_bar = "􀞀",
        active_space = "􀝷",
        inactive_space = "􀀁",
        spaces = "􁏮",
        menu = "􁏯",

        switch = {
            on = "􁏮",
            off = "􁏯"
        },
        volume = {
            _100 = "􀊩",
            _66 = "􀊧",
            _33 = "􀊥",
            _10 = "􀊡",
            _0 = "􀊣"
        },
        battery = {
            _100 = "􀛨",
            _75 = "􀺸",
            _50 = "􀺶",
            _25 = "􀛩",
            _0 = "􀛪",
            charging = "􀢋"
        },
        wifi = {
            upload = "􀄨",
            download = "􀄩",
            connected = "􀙇",
            disconnected = "􀙈",
            router = "􁓤"
        },
        media = {
            back = "􀊊",
            forward = "􀊌",
            play_pause = "􀊈"
        }
    },

    -- Alternative NerdFont icons
    nerdfont = {
        plus = "",
        loading = "",
        apple = "",
        gear = "",
        cpu = "",
        clipboard = "Missing Icon",

        switch = {
            on = "󱨥",
            off = "󱨦"
        },
        volume = {
            _100 = "",
            _66 = "",
            _33 = "",
            _10 = "",
            _0 = ""
        },
        battery = {
            _100 = "",
            _75 = "",
            _50 = "",
            _25 = "",
            _0 = "",
            charging = ""
        },
        wifi = {
            upload = "",
            download = "",
            connected = "󰖩",
            disconnected = "󰖪",
            router = "Missing Icon"
        },
        media = {
            back = "",
            forward = "",
            play_pause = ""
        }
    }
}

if not (settings.icons == "NerdFont") then
    return icons.sf_symbols
else
    return icons.nerdfont
end

