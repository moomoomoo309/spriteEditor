--- A module containing functions converting a color from one format to another.
--- @module color

--- Converts HSV to RGB
--- @tparam number h The hue of the color.
--- @tparam number s The saturation of the color.
--- @tparam number v The value of the color.
--- @treturn number,number,number The r,g,b values of the new color.
local function hsv(h, s, v)
    if s <= 0 then
        return v, v, v
    end
    h, s, v = h / 256 * 6, s / 255, v / 255
    local c = v * s
    local x = (1 - math.abs((h % 2) - 1)) * c
    local m, r, g, b = (v - c), 0, 0, 0
    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    return (r + m) * 255, (g + m) * 255, (b + m) * 255
end


local function rgb(h, s, v)
    s, v = s / 255, v / 255
    h = (h * 6) % 6
    local i = math.floor(h)
    local p = 255 * v
    local q = p * (1 - s)

    if i == 0 then
        return p, q + p * s * (h - i), q
    elseif i == 1 then
        return p * (1 - s * (h - i)), p, q
    elseif i == 2 then
        return q, p, q + p * s * (h - i)
    elseif i == 3 then
        return q, p * (1 - s * (h - i)), p
    elseif i == 4 then
        return q + p * s * (h - i), q, p
    elseif i == 5 then
        return p, q, p * (1 - s * (h - i))
    end
end

return { hsv = hsv, rgb = rgb }