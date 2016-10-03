-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	title = display.newText( "Beat!", display.contentCenterX, 100, nil ,45 )
	title.x=display.contentCenterX
	title.y=100	
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Let's Beat!",
		labelColor = { default={255}, over={128} },
		default="button.png",
		over="button-over.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 100


	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( playBtn )
end

function scene:show( event )
	
	
	local sceneGroup = self.view

	local phase = event.phase

	
	
	if phase == "will" then
		animeObj = display.newCircle( display.contentCenterX, display.contentCenterY, 50 )
		sceneGroup:insert( animeObj )
	elseif phase == "did" then
		function mainAnime( )
			function mainAnime1( )
				transition.to( animeObj, { time=250, xScale=1.5, yScale=1.5 } )
			end
			function mainAnime2( )
				transition.to( animeObj, { time=250, xScale=1.0, yScale=1.0 } )
			end
			timer.performWithDelay( 0, mainAnime1 )
			timer.performWithDelay( 350, mainAnime2 )
		end
		timer.performWithDelay( 600, mainAnime, 0 )
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
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
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene