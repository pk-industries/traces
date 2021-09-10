--TODO: The current functionality of the textbox is when you enter musicBox, the textbox appears, and you can't act
--on anything else, and you can also press space to make it disappear, which is expected functionality.
--However, after pressing space, you can't act on any other logic, the expected logic for us to be able to act on in this
--case is being able to press "down" in the MusicBox:load() function to exit the music box and load Bedroom.
--Something is exiting the logic. We never set Music Box to false anywhere here, so why is the logic exiting or getting stuck?
--Does this have to do with the love.update()? This is the first time I've used love.update(), so it could be wrong.
--You got this.

Gfx = love.graphics
TextBox = {
    test = "wow this actually works? amazing"
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

function TextBox:draw()
    Gfx.draw(TextBoxImage, 25, 150)
    Gfx.setColor(0, 0, 0)
    Gfx.print(TextBox.test, 30, 175, 0, 1, 1)
    Gfx.setColor(255, 255, 255)
end


