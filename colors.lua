return {
    black = 0xff121212,
    white = 0xffffffff,
    red = 0xffbf616a,
    green = 0xffA3BE8C,
    yellow = 0xffEBCB8B,
    orange = 0xffD08770,
    blue = 0xff4988ca,
    magenta = 0xffB48EAD,
    grey = 0xffb2b2b2,
    transparent = 0x00000000,
    border = 0xffe0e1e1,
    border2 = 0x3De0e1e1,
    fontColor = 0xffc4c4c4,
    hiLight = 0xff212121,
    inactive = 0xfffb8e3f,
    active = 0xff919fa3,
    hover = 0xff292f31,
    text_active = 0xffb9bdc1,
    shadow_blue = 0xff698ba2,
    frost_blue1 = 0xff8FBCBB,
    frost_blue2 = 0xff88C0D0,
    frost_blue3 = 0xff81A1C1,
    frost_blue4 = 0xff5E81AC,
    frost_light = 0xffECEFF4,
    bar = {
        bg = 0xff1e1e1e,
        bg2 = 0xff252526,
        transparent = 0x4dffffff,
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
