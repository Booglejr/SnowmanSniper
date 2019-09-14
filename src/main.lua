
window = {}
game = {}
bgm = {}
img = {}
offsetx = {}
offsety = {}
x = {}
y = {}

snowman = {}
crosshair = {}
snowball = {}


function love.load()
	bgm[0] = love.audio.newSource("assets/bgm1.ogg","stream")
	bgm[1] = love.audio.newSource("assets/bgm1.ogg","stream")
	bgm[2] = love.audio.newSource("assets/bgm1.ogg","stream")
	wowza = love.audio.newSource("assets/wowza.ogg","static")
	splat = love.audio.newSource("assets/splat.ogg","static")
	hit = love.audio.newSource("assets/hit.ogg","static")
	score = 0
	tscore = 0
	levelnum = 0
	game.Width = 800
	game.Height = love.graphics.getHeight()
	window.Width = love.graphics.getWidth()
	--------------------------------------------------------------------Setup Snowman
	snowman.img = love.graphics.newImage("assets/snowman.png")
	snowman.ownedimg = love.graphics.newImage("assets/snowmanhit.png")
	snowman.offsetx = game.Width - snowman.img:getWidth()
	snowman.offsety = game.Height - snowman.img:getHeight()
	snowman.x = (.5 * snowman.offsetx) + ((window.Width - game.Width) * .5)
	snowman.y = .8 * snowman.offsety
	snowman.hit = false
	snowman.hitCount = 0
	--------------------------------------------------------------------Setup Background
	img[0] = love.graphics.newImage("assets/back1.png")
	offsetx[0] = game.Width - img[0]:getWidth()
	offsety[0] = game.Height - img[0]:getHeight()
	x[0] = (.5 * offsetx[0]) + ((window.Width - game.Width) * .5)
	y[0] = .5 * offsety[0]
	-------------------------------------------------------
	img[1] = love.graphics.newImage("assets/back2.png")
	offsetx[1] = game.Width - img[1]:getWidth()
	offsety[1] = game.Height - img[1]:getHeight()
	x[1] = (.5 * offsetx[1]) + ((window.Width - game.Width) * .5)
	y[1] = .75 * offsety[1]
	-------------------------------------------------------
	img[2] = love.graphics.newImage("assets/back3.png")
	offsetx[2] = game.Width - img[2]:getWidth()
	offsety[2] = game.Height - img[2]:getHeight()
	x[2] = (.5 * offsetx[2]) + ((window.Width - game.Width) * .5)
	y[2] = .5 * offsety[2]
	-------------------------------------------------------
	img[3] = love.graphics.newImage("assets/back3.png")
	offsetx[3] = game.Width - img[3]:getWidth()
	offsety[3] = game.Height - img[3]:getHeight()
	x[3] = (.5 * offsetx[3]) + ((window.Width - game.Width) * .5)
	y[3] = .5 * offsety[3]
	--------------------------------------------------------------------Setup Crosshair
	crosshair.img = love.graphics.newImage("assets/crosshair.png")
	crosshair.snowballimg = love.graphics.newImage("assets/snowball.png")
	crosshair.offsetx = game.Width - crosshair.img:getWidth()
	crosshair.offsety = game.Height - crosshair.img:getHeight()
	crosshair.x = (.5 * crosshair.offsetx) + ((window.Width - game.Width) * .5)
	crosshair.y = .75 * crosshair.offsety
	crosshair.xadjust = .5
	crosshair.xspeed = crosshair.xadjust * game.Width
	crosshair.isAlive = true
	crosshair.isAliveCount = 3
	crosshair.lastx = crosshair.x
	crosshair.displaySnowball = false
	crosshair.displaySnowballTimer = 0
	crosshair.justFiredTimer = 0
	crosshair.justFired = false
	crosshair.xmovement = "left"
	crosshair.lifeGranted = 0
	--------------------------------------------------------------------Setup Snowballs
	snowball.snowballimg1 = love.graphics.newImage("assets/snowball.png")
	snowball.snowballimg2 = love.graphics.newImage("assets/snowball.png")
	snowball.snowballimg3 = love.graphics.newImage("assets/snowball.png")
	snowball.snowballimg4 = love.graphics.newImage("assets/snowball.png")
	snowball.offsetx = game.Width - snowball.snowballimg1:getWidth()
	snowball.offsety = game.Height - snowball.snowballimg1:getHeight()
	snowball.snowballimg1x = (.025 * snowball.offsetx) + ((window.Width - game.Width) * .5)
	snowball.snowballimg1y = .025 * snowball.offsety
	snowball.snowballimg2x = (.050 * snowball.offsetx) + ((window.Width - game.Width) * .5)
	snowball.snowballimg2y = .025 * snowball.offsety
	snowball.snowballimg3x = (.075 * snowball.offsetx) + ((window.Width - game.Width) * .5)
	snowball.snowballimg3y = .025 * snowball.offsety
	snowball.snowballimg4x = (.100 * snowball.offsetx) + ((window.Width - game.Width) * .5)
	snowball.snowballimg4y = .025 * snowball.offsety

	local img = love.graphics.newImage('assets/start.jpg')
	psystem = love.graphics.newParticleSystem(img, 1)
	psystem:setParticleLifetime(5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(1)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(0, 0, 0, 0) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 0, 255, 255, 255, 255) -- Fade to transparency.
	-- Extra.
	local img2 = love.graphics.newImage('assets/snowflake.png')
	psystem2 = love.graphics.newParticleSystem(img2, 500)
	psystem2:setParticleLifetime(10, 15) -- Particles live at least 2s and at most 5s.
	psystem2:setEmissionRate(20)
	psystem2:setSizeVariation(1, 100)
	psystem2:setLinearAcceleration(-5, 0, 30, 20) -- Random movement in all directions.
	psystem2:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
end
function love.draw(dt)
	if hasStarted == true then
		i = levelnum
		love.graphics.draw(img[i], x[i], y[i])
		if snowman.hitCount > 0 then
			love.graphics.draw(snowman.ownedimg, snowman.x, snowman.y)
		else
			love.graphics.draw(snowman.img, snowman.x, snowman.y)
		end
		if crosshair.displaySnowball == true then
			love.graphics.draw(crosshair.snowballimg, crosshair.lastx, crosshair.y)
		end
		if crosshair.isAlive then
			love.graphics.draw(crosshair.img, crosshair.x, crosshair.y)
			if crosshair.isAliveCount == 4 then
				love.graphics.draw(snowball.snowballimg1, snowball.snowballimg1x, snowball.snowballimg1y)
				love.graphics.draw(snowball.snowballimg2, snowball.snowballimg2x, snowball.snowballimg2y)
				love.graphics.draw(snowball.snowballimg3, snowball.snowballimg3x, snowball.snowballimg3y)
				love.graphics.draw(snowball.snowballimg4, snowball.snowballimg4x, snowball.snowballimg4y)
			elseif crosshair.isAliveCount == 3 then
				love.graphics.draw(snowball.snowballimg1, snowball.snowballimg1x, snowball.snowballimg1y)
				love.graphics.draw(snowball.snowballimg2, snowball.snowballimg2x, snowball.snowballimg2y)
				love.graphics.draw(snowball.snowballimg3, snowball.snowballimg3x, snowball.snowballimg3y)
			elseif crosshair.isAliveCount == 2 then
				love.graphics.draw(snowball.snowballimg1, snowball.snowballimg1x, snowball.snowballimg1y)
				love.graphics.draw(snowball.snowballimg2, snowball.snowballimg2x, snowball.snowballimg2y)
			elseif crosshair.isAliveCount == 1 then
				love.graphics.draw(snowball.snowballimg1, snowball.snowballimg1x, snowball.snowballimg1y)
			end
		else
			love.graphics.setColor(255, 0, 0)
			love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-75, love.graphics:getHeight()/2-10,0,1.5)
			love.graphics.setColor(255, 255, 255)
		end
		love.graphics.setColor(255, 0, 0)
		love.graphics.print("SCORE: " .. tostring(tscore), (.75 * game.Width) + ((window.Width - game.Width) * .5), 10,0,2)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(psystem2, love.graphics.getWidth() * -0.2, love.graphics.getHeight() * -0.1)
	else
		love.graphics.draw(psystem, love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5)
		start = love.graphics.newImage("assets/banner.png")
		startoffsetx = game.Width - start:getWidth()
		startoffsety = game.Height - start:getHeight()
		startx = (.5 * startoffsetx) + ((window.Width - game.Width) * .5)
		starty = .2 * startoffsety
		love.graphics.draw(start, startx, starty)
		love.graphics.setColor(255, 0, 0)
		love.graphics.print("Press 'Space' to begin", love.graphics:getWidth()/2-150, love.graphics:getHeight()/2-10,0,2)
		love.graphics.setColor(255, 255, 255)
	end
end
function love.update(dt)
	if hasStarted == true then
		psystem2:update(dt)
		if snowman.hitCount > 0 then
			snowman.hitCount = snowman.hitCount - 1
			if snowman.hitCount == 0 then
				if tscore >= 1000 and (math.random() / (tscore / 2500) ) >= .40 then
					snowman.x = (math.random() * snowman.offsetx) + ((window.Width - game.Width) * .5)
				end
				if tscore == 3500 and crosshair.lifeGranted == 0 then
					crosshair.isAliveCount = crosshair.isAliveCount + 1
					crosshair.lifeGranted = 1
				end
			end
		end
		if not crosshair.isAlive and love.keyboard.isDown('r') then
			crosshair.x = (.5 * crosshair.offsetx) + ((window.Width - game.Width) * .5)
			crosshair.y = .75 * crosshair.offsety
			love.audio.stop(bgm[levelnum])
		-- reset our game state
			levelnum = 0
			tscore = 0
			score = 0
			snowman.x = (.5 * snowman.offsetx) + ((window.Width - game.Width) * .5)
			crosshair.isAlive = true
			crosshair.isAliveCount = 3
			crosshair.xadjust = .5
			crosshair.xspeed = crosshair.xadjust * game.Width
			crosshair.lifeGranted = 0
		end
		if crosshair.xmovement == "left" and crosshair.isAlive then
			if (crosshair.x) <= (0 * game.Width + ((window.Width - game.Width)/2)) then
				crosshair.xmovement = "right"
				crosshair.xspeed = crosshair.xadjust * game.Width
			else
				crosshair.x = crosshair.x - crosshair.xspeed * dt
			end
		end
		if crosshair.xmovement == "right" and crosshair.isAlive then
			if (crosshair.x + crosshair.img:getWidth()) >= (1 * game.Width + ((window.Width - game.Width)/2)) then
				crosshair.xmovement = "left"
			else
				crosshair.x = crosshair.x + crosshair.xspeed * dt
			end
		end
		if crosshair.displaySnowball == true and crosshair.displaySnowballTimer == 0 then
			crosshair.displaySnowball = false
		elseif crosshair.displaySnowball == true then
			crosshair.displaySnowballTimer = crosshair.displaySnowballTimer - 1
		end
		if crosshair.justFired == true and crosshair.justFiredTimer == 0 then
			crosshair.justFired = false
		elseif crosshair.justFired == true then
			crosshair.justFiredTimer = crosshair.justFiredTimer - 1
		end
		if love.keyboard.isDown('space') and crosshair.justFired == false and crosshair.isAlive then
			crosshair.justFired = true
			crosshair.justFiredTimer = 15
			crosshair.lastx = crosshair.x
			crosshair.displaySnowball = true
			crosshair.displaySnowballTimer = 25
			if crosshair.x >= snowman.x and crosshair.x <= (snowman.img:getWidth()/1.35) + snowman.x then
				snowman.hit = true
			else
				crosshair.isAliveCount = crosshair.isAliveCount - 1
				love.audio.play(splat)
				if crosshair.isAliveCount == 0 then
					crosshair.isAlive = false
				end
			end
		end
		if snowman.hit == true then
			crosshair.xadjust = crosshair.xadjust + .05
			crosshair.xspeed = crosshair.xadjust * game.Width
			tscore = tscore + 100
			score = score + 100
			snowman.hitCount = 50
			snowman.hit = false
			if score == 2000 then
				love.audio.stop(bgm[levelnum])
				if levelnum ~= 3 then
					levelnum = levelnum + 1
				else
					levelnum = 0
				end
				love.audio.play(wowza)
				score = 0
			else
				love.audio.play(hit)
			end
		end
		love.audio.play(bgm[levelnum])
	else
		psystem:update(dt)
		if love.keyboard.isDown('space') then
			hasStarted = true
			crosshair.justFired = true
			crosshair.justFiredTimer = 15
			crosshair.lastx = crosshair.x
		end
	end
end
