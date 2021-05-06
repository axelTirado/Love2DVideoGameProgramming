player = world:newRectangleCollider(screenWidth/2, 200, 80, 80, {collision_class ="Player"})
player:setFixedRotation(true)
player.speed = 250
player.animations = Animation.idle
player.isMoving = false
player.direction = 1
player.grounded = true 

function playerUpdate(dt)
    if player.body then

        local colliders = world:queryRectangleArea(player:getX() - 40, player:getY() + 40, 80, 2, {'Platform'})
        if #colliders > 0 then
            player.grounded = true 
        else
            player.grounded = false 
        end 

        player.isMoving = false
        local px, py = player:getPosition()
        if love.keyboard.isDown('d') then
            player:setX(px + player.speed *dt)
            player.isMoving = true
            player.direction = 1
        end 
        if love.keyboard.isDown('a') then
            player:setX(px - player.speed *dt)
            player.isMoving = true
            player.direction = -1
        end 
    end 

    if player.grounded == true then
        if player.isMoving == true then
            player.animations = Animation.run
        else 
            player.animations = Animation.idle
            if love.keyboard.isDown('s') then
                player.animations = Animation.crouch
            end 
        end 
    else 
        player.animations = Animation.jump
    end 

    player.animations:update(dt)
end 

function drawPlayer()
    local px, py = player:getPosition()
    player.animations:draw(sprites.mainPlayer, px, py, nil, 3 * player.direction, 3, 25, 20)
end 