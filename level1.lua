local composer = require( "composer" )
local scene = composer.newScene()

-----------------------------------------------------------------------------------------

local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX


local background 								--배경화면
local score
local scoreNum
local scoreText
local startText

local pla 										--플레이어
local fLife
local sLife
local tLife
local isFlife
local isSlife
local isTlife
local isTouched
local isCollision

local tanmak_CD 								--탄막
local blueTooth
local cd_bullet1
local cd_bullet2
local cd_bullet3
local cd_bullet4
local cd_bullet5
local cd_bullet6
local cd_bullet7
local cd_bullet8

-----------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------

function movePlayer( event )
	if event.x>35 then														--플레이어 이동 구현
		if event.phase == "began" then
			if event.x < pla.x+30 then
				if event.x > pla.x-30 then
					if event.y < pla.y+30 then
						if event.y > pla.y-30 then
							isTouched = true
							pla.x=event.x
							pla.y=event.y
						end
					end
				end
			end
		elseif event.phase == "moved" then 									--터치좌표로 플레이어 이동
			if isTouched then
				pla.x=event.x
				pla.y=event.y
			end
		elseif event.phase =="ended" then
			if isTouched then isTouched = false end
		end
	end
end

function tanmakCD(  )															--첫 패턴
	tanmak_CD = display.newImageRect( "CD_bomb.png", 100, 100 )				
	tanmak_CD.x = display.contentWidth+50
	tanmak_CD.y = 0
	transition.to( tanmak_CD, {x=display.contentCenterX, y = display.contentCenterY, time =1500} )
end

function tanmakBlueTooth(  )
	blueTooth = display.newImageRect("bluetooth.png", 300, 300 )
	blueTooth.x = -60
	blueTooth.y = display.contentCenterY
end

function popCD( )																--첫 패턴 후 바로 실행되는 패턴
	if tanmak_CD.x == display.contentCenterX and tanmak_CD.y == display.contentCenterY then
		tanmak_CD:removeSelf( )
		cd_bullet1 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet2 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet3 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet4 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet5 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet6 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet7 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet8 = display.newImageRect( "rithm_bullet.png", 30, 30 )
		cd_bullet1.x = display.contentCenterX
		cd_bullet2.x = display.contentCenterX
		cd_bullet3.x = display.contentCenterX
		cd_bullet4.x = display.contentCenterX
		cd_bullet5.x = display.contentCenterX
		cd_bullet6.x = display.contentCenterX
		cd_bullet7.x = display.contentCenterX
		cd_bullet8.x = display.contentCenterX
		cd_bullet1.y = display.contentCenterY
		cd_bullet2.y = display.contentCenterY
		cd_bullet3.y = display.contentCenterY
		cd_bullet4.y = display.contentCenterY
		cd_bullet5.y = display.contentCenterY
		cd_bullet6.y = display.contentCenterY
		cd_bullet7.y = display.contentCenterY
		cd_bullet8.y = display.contentCenterY
		cd_bullet1.id = "bullet1"
		cd_bullet2.id = "bullet2"
		cd_bullet3.id = "bullet3"
		cd_bullet4.id = "bullet4"
		cd_bullet5.id = "bullet5"
		cd_bullet6.id = "bullet6"
		cd_bullet7.id = "bullet7"
		cd_bullet8.id = "bullet8"
		transition.to( cd_bullet1, {y = display.contentCenterY-300, time=3000} )
		transition.to( cd_bullet2, {x = display.contentCenterX+300 , y = display.contentCenterY-300, time=3000} )
		transition.to( cd_bullet3, {x = display.contentCenterX+300, time=3000} )
		transition.to( cd_bullet4, {x = display.contentCenterX+300, y = display.contentCenterY+300, time=3000} )
		transition.to( cd_bullet5, {y = display.contentCenterY+300, time=3000} )
		transition.to( cd_bullet6, {x = display.contentCenterX-300, y = display.contentCenterY+300, time=3000} )
		transition.to( cd_bullet7, {x = display.contentCenterX-300, time=3000} )
		transition.to( cd_bullet8, {x = display.contentCenterX-300, y = display.contentCenterY-300, time=3000} )
	end
end

function fLifeRemove(  )
	print("first life removed")
end

function sLifeRemove(  )
	print("second life removed")
end

function tLifeRemove(  )
	print("third life removed")
	composer.gotoScene( "gameover" )
end

function collisionJudge( event )												--충돌하면 true 반환
	if event.phase == "began" then
		if event.other.id == "back1" then
			isCollision = false
		else
			isCollision = true
			if isFlife then
				fLife:removeSelf( )
				fLife = nil
				isFlife = false
				timer.performWithDelay( 3000, fLifeRemove )
			elseif isSlife then
				sLife:removeSelf( )
				sLife = nil
				isSlife = false
				timer.performWithDelay( 3000, sLifeRemove )
			elseif isTlife then
				tLife:removeSelf( )
				tLife = nil
				isTlife = false
				timer.performWithDelay( 3000, tLifeRemove )
			end
		end
	end
end

function notEscape(  )															--플레이어가 일정 범위 밖으로 나가지 않게 하기
	if pla.x < 35 then
		pla.x = 35
	end
	if pla.x > 285 then
		pla.x = 285
	end
	if pla.y < 50 then
		pla.y = 50
	end
	if pla.y > 485 then
		pla.y = 485
	end
end

function scoreIncrease(  )														--점수 증가
	scoreNum = scoreNum + 1
end

function scoreDsp(  )															--점수값 갱신
	scoreIncrease(  )
	scoreText.text = ""
	scoreText.text = scoreNum
end

-----------------------------------------------------------------------------------------

function scene:create( event )	
	local sceneGroup = self.view
	local phase = event.phase
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.id = "back1"	
	score = display.newText( "Score : ", 40, -15, "pixel font-7.ttf", 15 )							
	scoreNum = 0																					
	scoreText = display.newText( "", 80, -15, "pixel font-7.ttf", 15 )								
	scoreText:setFillColor( 0,0,0 )
	startText = display.newText( "GAME START", display.contentCenterX, display.contentCenterY-20, "pixel font-7.ttf", 45 )
	startText:setFillColor( 0,0,0 )
	transition.to( startText, {time=1000, alpha = 0} )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( 1,1,1 )
	score:setFillColor( 0,0,0 )
	pla = display.newImageRect( "player_static1.png", 50, 50 )										
	pla.x = display.contentCenterX
	pla.y = display.contentCenterY
	fLife = display.newImageRect( "life.png", 30, 20 )												
	sLife = display.newImageRect( "life.png", 30, 20 )											
	tLife = display.newImageRect( "life.png", 30, 20 )		
	fLife.x = 160
	sLife.x = 220
	tLife.x = 280
	fLife.y = -15
	sLife.y = -15
	tLife.y = -15
	isFlife = true
	isSlife = true
	isTlife = true
	isTouched = false		
	fLife:setFillColor( 1,0,0 )
	sLife:setFillColor( 1,0,0 )
	tLife:setFillColor( 1,0,0 )

	if phase == "will" then

	elseif phase == "did" then
		tanmakCD( )
		tanmakBlueTooth( )
		transition.to( blueTooth, {x = 800, time = 2000} )
		timer.performWithDelay( 1000, scoreIncrease, 0 )									
		timer.performWithDelay( 100, scoreDsp, 0 )													
		background:addEventListener( "touch", movePlayer )				
		Runtime:addEventListener( "enterFrame", notEscape )
		Runtime:addEventListener("enterFrame", popCD)
		pla:addEventListener( "collision", collisionJudge )	
	end
	sceneGroup:insert( background )
	sceneGroup:insert( score )
	sceneGroup:insert( scoreText )
	sceneGroup:insert( pla )
	sceneGroup:insert( fLife )
	sceneGroup:insert( sLife )
	sceneGroup:insert( tLife )
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then

	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
end

-----------------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene