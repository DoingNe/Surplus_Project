local composer = require( "composer" )
local scene = composer.newScene()

-----------------------------------------------------------------------------------------

local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

-----------------------------------------------------------------------------------------

function scene:create( event )

	local sceneGroup = self.view
	local phase = event.phase
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	local score = display.newText( "Score : ", 40, -15, nil, 15 )
	scoreNum = 0
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( 1,1,1 )
	score:setFillColor( 0,0,0 )
	local pla = display.newRect( display.contentCenterX, display.contentCenterY, 50, 50 )
	pla:setFillColor( 0,0,0 )

	function movePlayer( event )
		if event.phase == "ended" then
			transition.to( pla, {time=700, x=event.x, y=event.y} )
		end
	end
	
	function scoreIncrease(  )
		scoreNum = scoreNum + 1
	end

	function scoreDsp(  )
		scoreIncrease
		scoreText.text = "  "
		scoreText.text = scoreNum
	end

	if phase == "will" then


	elseif phase == "did" then
		scoreText = display.newText( scoreNum, 70, -15, nil, 15 )
		scoreText:setFillColor( 0,0,0 )
		timer.performWithDelay( 1000, scoreDsp, 0 )
		background:addEventListener( "touch", movePlayer )
	end
	sceneGroup:insert( background )
	sceneGroup:insert( score )
	sceneGroup:insert( scoreNum )
	sceneGroup:insert( pla )
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