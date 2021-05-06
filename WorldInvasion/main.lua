function love.load()

    anim8 = require 'libraries/anim8/anim8'
    cameraFile = require 'libraries/hump/camera'
    sti = require 'libraries/Simple-Tiled-Implementation/sti'
    wf = require 'libraries/windfield/windfield' 

    screenWidth = 1280
    screenHeight = 720

    love.window.setMode(screenWidth, screenHeight)

    sprites = {}
    sprites.mainPlayer = love.graphics.newImage('sprites/adventurer-Sheet.png')
    sprites.background = love.graphics.newImage('sprites/Background.png')
    sprites.Middleground = love.graphics.newImage('sprites/Middleground.png')

    local grid = anim8.newGrid(50, 37, sprites.mainPlayer:getWidth(), sprites.mainPlayer:getHeight())

    Animation = {}
    Animation.idle = anim8.newAnimation(grid('1-4',1), 0.1)
    Animation.run = anim8.newAnimation(grid('2-7',2), 0.1)
    Animation.jump = anim8.newAnimation(grid('3-7',3, '1-3',4), 0.1)
    Animation.crouch = anim8.newAnimation(grid('5-7', 1, '1-1', 2), 0.1)
    Animation.Sword = anim8.newAnimation(grid('5-7', 6), 0.1)
    Animation.Attack = anim8.newAnimation(grid('4-7', 7), 0.1)

    world = wf.newWorld(0, 800)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('Platform')
    world:addCollisionClass('Player')

    require('player')

    platform = world:newRectangleCollider(0, screenHeight - 100, screenWidth, 50, {collision_class ="Platform"})
    platform:setType('static')

end 

function love.update(dt)
    world:update(dt)
    playerUpdate(dt)
end 

function love.draw()
    love.graphics.draw(sprites.background, 0, 0, nil, screenWidth / sprites.background:getWidth(), screenHeight / sprites.background:getHeight())
    love.graphics.draw(sprites.Middleground, 0, 0, nil, screenWidth / sprites.Middleground:getWidth(), screenHeight / sprites.Middleground:getHeight())
    world:draw()
    drawPlayer()
    
end 

function love.keypressed(key)
    if love.keyboard.isDown('w') then
        if player.grounded == true then
            player:applyLinearImpulse(0, -7000)  
        end 
    end 
end 