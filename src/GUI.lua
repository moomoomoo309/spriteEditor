require "gooi"

local properties, buttons
local editButton, helpButton
local addSprite, addSpriteOverlay, remove, detach, attach
local largeFont = love.graphics.newFont(24)

local menuBarColor = { 12, 183, 242 }
local sideBarColor = { 12, 165, 219 }
local propertiesColor = { 12, 150, 196 }

spriteAreaSize = .75

local w, h = love.graphics.getDimensions()

fileButton = gooi.newButton {
    x = 2.5,
    y = 0,
    text = "File"
}

properties = gooi.newPanel {
    x = w * (spriteAreaSize + .005),
    y = fileButton.h,
    w = w * (1 - spriteAreaSize - .01),
    h = h * .655, --.9*.7
    layout = "grid 1x1"
}

buttons = gooi.newPanel {
    x = properties.x,
    y = h * .72,
    w = properties.w,
    h = h * .27, --.3*.9
    layout = "grid 5x1"
}

editButton = gooi.newButton {
    x = fileButton.x + fileButton.w + 10,
    y = 0,
    text = "Edit"
}

helpButton = gooi.newButton {
    x = editButton.x + editButton.w + 10,
    y = 0,
    text = "Help"
}

addSprite = gooi.newButton {
    text = "Add Sprite"
}
addSprite.style.font = largeFont

addSpriteOverlay = gooi.newButton {
    text = "Add Overlay"
}
addSpriteOverlay.style.font = largeFont

remove = gooi.newButton {
    text = "Remove"
}
remove.style.font = largeFont

attach = gooi.newButton {
    text = "Attach"
}
attach.style.font = largeFont

detach = gooi.newButton {
    text = "Detach"
}
detach.style.font = largeFont

buttons:add(addSprite, addSpriteOverlay, remove, attach, detach)

local backgroundCanvas

local function drawBackground()
    if not backgroundCanvas then
        backgroundCanvas = love.graphics.newCanvas(w, h)
        love.graphics.setCanvas(backgroundCanvas)
        local oldColor = { love.graphics.getColor() }
        love.graphics.setScissor(0, fileButton.h, w * .75, h - fileButton.h)
        love.graphics.setScissor()
        love.graphics.setColor(unpack(sideBarColor))
        love.graphics.rectangle("fill", w * spriteAreaSize, 0, w * (1 - spriteAreaSize), h)
        love.graphics.setColor(unpack(menuBarColor))
        love.graphics.rectangle("fill", 0, 0, w, fileButton.h)
        love.graphics.setColor(unpack(propertiesColor))
        love.graphics.rectangle("fill", properties.x, fileButton.h + h * .0075, properties.w, properties.h)
        love.graphics.setColor(unpack(oldColor))
        love.graphics.setCanvas()
    end
    love.graphics.draw(backgroundCanvas)
end

return { drawBackground = drawBackground }