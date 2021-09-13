TextBox = {
    bathroomText = "THIS IS SOME BATHROOM TEXT",
    musicBoxText = "THIS IS SOME MUSIC BOX TEXT",
}
TextBox.entered = false
local textBoxImage = Gfx.newImage("pics/textBox.png")

function TextBox:load()
    function love.keypressed(key)
        --If we press space, then take the text box off the screen
        if key == "space" then
            TextBox.entered = false
        end
    end
end

function TextBox:update()
    function love.keypressed(key)
        --If we press space, then take the text box off the screen
        if key == "space" then
            TextBox.entered = false
        end
    end
end

function TextBox:draw(text)
    Gfx.draw(textBoxImage, 25, 150)
    Gfx.setColor(0, 0, 0)
    Gfx.print(text, 30, 175, 0, 1, 1)
    Gfx.setColor(255, 255, 255)
end


