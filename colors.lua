return {
    black = 0xff141414,
    white = 0xffe5e5e5,
    white_transparent = 0x8faeaeae,
    red = 0xffa95c58,
    green = 0xffA3BE8C,
    yellow = 0xffa18f6c,
    orange = 0xff8e6c43,
    blue = 0xff6d8690,
    magenta = 0xffa090a1,
    grey = 0xff252525,
    transparent = 0x00000000,
    border = 0xffe0e1e1,
    fontColor = 0xffff9fa29f,
    hiLight = 0xff9fa29f,
    inactive = 0xfffb8e3f,
    active = 0xffaeaeae,
    hover = 0xff292f31,
    text_active = 0xffb9bdc1,
    shadow_blue = 0xff698ba2,
    frost_blue1 = 0xff8FBCBB,
    frost_blue2 = 0xff88C0D0,
    frost_blue3 = 0xff81A1C1,
    frost_blue4 = 0xff5E81AC,
    frost_light = 0xff9fa29f,
    seezalt_dark = 0xff45566a,
    seezalt_smoke = 0xff737c73,
    seesalt_spanishgrey = 0xff8f969e,
    platinum = 0xffe5e5e5,
    bar = {
        bg = 0xff181818,
        bg2 = 0xff232323,
        transparent = 0xBF1e1e1e,
        border = 0xD92525276
    },
    popup = {
        bg = 0x661e1e1e,
        border = 0xD9252526
    },
    bg1 = 0xff1e1e1e,
    bg2 = 0xff252526,
    with_alpha = function(color, alpha)
        if alpha > 1.0 or alpha < 0.0 then
            return color
        end
        return (color and 0x001e1e1e) or (math.floor(alpha * 255.0) < 24)
    end
}
