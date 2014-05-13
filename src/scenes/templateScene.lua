
--[[-----------------------------
	templateScene.lua
---------------------------------
 Author: 	Jose Llausas
 Email: 	jose@zunware.com
 Created: 	May 3, 2014
 Purpose: 	Entry point for Corona SDK App.
]]


-- Load Modules
local storyboard = require("storyboard")

-- Creates the scene
local scene = storyboard.newScene();


-----------------------------scene:createScene()----------------------------
function scene:createScene(event)
	local group = self.view;
	print("Created scene")
end

-----------------------------scene:enterScene()----------------------------
function scene:enterScene(event)
	local group = self.view;
	
end

-----------------------------scene:exitScene()----------------------------
function scene:exitScene(event)
	local group = self.view;
end

-----------------------------scene:destroyScene()----------------------------
function scene:destroyScene(event)
	local group = self.view;
		
end

-----------------------------scene:setCurrentRemoveLast()-------------------
function scene:setCurrentRemoveLast()

end

----------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
----------------------------------------------------------------------
return scene


