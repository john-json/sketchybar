return {
    black = 0xff080808,
    white = 0x99ffffff,
    red = 0xffd87e7e,
    green = 0xffb1da9e,
    yellow = 0xffbfddb1,
    orange = 0xffde9d70,
    blue = 0xffb6c6d2,
    magenta = 0xffB48EAD,
    grey = 0xff545454,
    transparent = 0x00000000,
    border = 0xffe0e1e1,
    border2 = 0x3De0e1e1,
    fontColor = 0xff212121,
    hiLight = 0xff212121,
    inactive = 0xfff9f9f9,
    inactive2 = 0x66f9f9f9,
    active = 0xff919fa3,
    hover = 0xff292f31,

    bar = {
        bg = 0x03ffffff,
        border = 0xD9e0e1e1
    },
    popup = {
        bg = 0xffffffff,
        border = 0xD9e0e1e1
    },
    bg1 = 0xffdbdbdb,
    bg2 = 0xffffffff,

    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
    end
}
