io.stdout:setvbuf("no")

local Lander = {}
Lander.img = love.graphics.newImage("_images_/ship.png")
Lander.x = love.graphics.getWidth() / 2
Lander.y = love.graphics.getHeight() / 2
Lander.angle = 270
Lander.vx = 0
Lander.vy = 0

local Engine = {}
Engine.img = love.graphics.newImage("_images_/engine.png")
Engine.x = Lander.x
Engine.y = Lander.y
Engine.vx= 0
Engine.vy = 0
Engine_on = false
Engine.thrust = 2

local pitch_angle = 3


function love.load()

    largeur_ecran = love.graphics.getWidth()
    hauteur_ecran = love.graphics.getHeight()
        

end

function love.update(dt)

    if love.keyboard.isDown("right") then
        Lander.angle = Lander.angle + pitch_angle
        if Lander.angle > 360 then Lander.angle = 0 end
    end

    if love.keyboard.isDown("left") then
        Lander.angle= Lander.angle - pitch_angle
        if Lander.angle < 0 then Lander.angle = 360 end
    end

    if love.keyboard.isDown("up") then
        Engine_on = true
        local angle_radian = math.rad(Lander.angle)
        local force_x = math.cos(angle_radian) * (Engine.thrust * dt)
        local force_y = math.sin(angle_radian) * (Engine.thrust * dt)
        Lander.vx = Lander.vx + force_x
        Lander.vy = Lander.vy + force_y
    else
        Engine_on = false
    end

    Lander.x = Lander.vx + Lander.x
    Lander.y = Lander.vy + Lander.y

    if Lander.x <= Lander.img:getWidth() or Lander.x >= largeur_ecran - Lander.img:getWidth() then
        Lander.vx = 0
    end

    if Lander.y <= Lander.img:getHeight() or Lander.y >= hauteur_ecran - Lander.img:getHeight() then
        Lander.vy = 0
    end

    -- création gravité
    Lander.vy = Lander.vy + (0.6 * dt)

end

function love.draw()

    love.graphics.draw(Lander.img, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Lander.img:getWidth()/2, Lander.img:getHeight()/2)

    --Affichage burn engine
    if Engine_on then
        love.graphics.draw(Engine.img, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Engine.img:getWidth()/2, Engine.img:getHeight()/2)
    end
    
    local sDebug = "Debug:"
    sDebug = sDebug.." angle = "..tostring(Lander.angle)
    sDebug = sDebug.." vitesse x = "..tostring(Lander.vx)
    sDebug = sDebug.." vitesse y = "..tostring(Lander.vy)
    love.graphics.print(sDebug, 10, 10)

end