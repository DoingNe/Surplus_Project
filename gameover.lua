	-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require ( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local quitButton

function onQuitBtnRelease( event )
	native.requestExit()
end


local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "gameover", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newRect( 0, 0, 320, 480 )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( 1,1,1 )
	
	-- create/position logo/title image on upper-half of the screen
	local gameOver = display.newText( "Game Over", display.contentCenterX, display.contentCenterY-50, "pixel font-7.ttf", 60 )
	gameOver:setFillColor( 0,0,0 )
	-- create a widget button (which will loads level1.lua on release)
	quitButton = widget.newButton{
		label="QUIT",
		labelColor = { default={0}, over={0} },
		font="pixel font-7.ttf",
		default="button.png",
		over="button-over.png",
		width=154, height=40,
		onRelease = onQuitBtnRelease	-- event listener function
	}
	quitButton.x = display.contentCenterX
	quitButton.y = display.contentCenterY+100
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		
	elseif phase == "did" then
		
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene