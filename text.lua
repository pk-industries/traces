Gfx = love.graphics
TextBox = {
    bathroomText = "THIS IS SOME BATHROOM TEXT",
    musicBoxText = "THIS IS SOME MUSIC BOX TEXT",
}
TextBox.entered = false
TextBoxImage = Gfx.newImage("pics/textBox.png")

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
    Gfx.draw(TextBoxImage, 25, 150)
    Gfx.setColor(0, 0, 0)
    Gfx.print(text, 30, 175, 0, 1, 1)
    Gfx.setColor(255, 255, 255)
end


