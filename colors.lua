return {
    black = 0xff141414,
    white = 0xffacb1b5,
    white_text = 0xffffffff,
    white_transparent = 0x8faeaeae,
    red = 0xff732313,
    green = 0xffA3BE8C,
    yellow = 0xffa18f6c,
    orange = 0xffe27a49,
    blue = 0xff6d8690,
    magenta = 0xffa090a1,
    grey = 0xff32312f,
    granit = 0xff93a3ab,
    transparent = 0x00000000,
    inactive = 0xff727272,
    active = 0xffcdcdcd,
    hover = 0xffffffff,

    seezalt = {
        spanishgrey = 0xff8f969e,
        light = 0xffacaeb1,
        dark = 0xff45566a,
        platinum = 0xffe5e5e5,
    },
    bar = {
        bg = 0xff1b1b1b,
        bg2 = 0xff232323,
        transparent = 0xBF1e1e1e,
        border = 0xD92525276
    },
    popup = {
        bg = 0xd91e1e1e,
        border = 0xD9252525
    },
    bg1 = 0xff1e1e1e,
    bg2 = 0xff7e9195,
    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color and 0x001e1e1e) or (math.floor(alpha * 255.0) < 24)
    end
}
