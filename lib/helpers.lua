--[[-----------------------------
	helpers.lua
---------------------------------
 Author: 	Jose Llausas
 Email: 	jose@zunware.com
 Created: 	May 2, 2013
 Modified:  May 14. 2014
 Purpose: 	Helper Functions
 ]]


-- Modules:
local math 		 = require("math")
local storyboard = require("storyboard")
local llau 		 = require("llauColors")

-- This Module's object:
local helpers = {}

------------------------- writeFile() ------------------------------
-- in: 		filepath : the filepath to write to
--			data 	 : the Data to write
-- out: 	None
-- Purpose:	Opens a file and writes to it
function helpers.writeFile(filepath, data)
	-- Creates a handle for the directory path
	local path = system.pathForFile(filepath, system.DocumentsDirectory) -- returns nil if failed

	if path then
		-- Gets a handle for the file for writing
		local file, anError = io.open(path, "w") -- returns nil, error if failed
		
		if file then
			-- Writes the data to the file
			local inst,anError = file:write(data)

			-- Closes the file
			io.close(file)
			file = nil

			if anError then 
				print(anError) 
			end
		else
			print(anError)
		end
	else
		print("No such path: " .. filepath)
	end
end

-- runs a command and returns its output
function helpers.runCmd(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()

	if not result then 
		print('Error with cmd ' .. command) 
	end

	return result
end

-- Runs a commaand, no output
function helpers.runCmdSilent(command)
	local success = nil
	local signal  = nil
	local number  = nil

	success, signal, number = os.execute(command)

	if not success then print('Error running command') return false end

	return true
end

-- Splits text into a table separated by newlines
function helpers.splitTextToTable(str)
	t = {}
	
	-- Loops the text matching for newlines
	for line in str:gmatch("[^\r\n]+") do  
		table.insert(t, line)
	end
	
	return t
end

-- Retuns a table of filenames in a given directory
 function helpers.getFilenamesFromDir(dir)
	local filenames = {}

	-- Check if dir exists
	if helpers.runCmdSilent('cd ' .. dir) then
		-- returns filenames in a chunk of text separated by newlines
		local lsReturnData = helpers.runCmd('ls ' .. dir)
		
		-- gets a table of filenames
		filenames = helpers.splitTextToTable(lsReturnData)
	else
		print("Not a valid dir: " .. dir)
		return nil
	end

	return filenames
end

-- function string:split( inSplitPattern, outResults )

--    if not outResults then
--       outResults = { }
--    end
--    local theStart = 1
--    local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
--    while theSplitStart do
--       table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
--       theStart = theSplitEnd + 1
--       theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
--    end
--    table.insert( outResults, string.sub( self, theStart ) )
--    return outResults
-- end

------------------------- readFile() ------------------------------
-- in: 		filepath 	: the file to read
-- out: 	inputData 	: the contents of the file
-- Purpose:	Opens and reads from a file
function helpers.readFile(filepath)
	local path = system.pathForFile(filepath, system.DocumentsDirectory)
	local file = io.open(path, "r")
	local inputData = file:read("*a")
	io.close(file)
	return inputData
end

--[[ saveCurrentGame ]]
-- Purpose: Saves the current state
function helpers.saveCurrentGame(playername, estados_data)
	local path = helpers.getSaveGamePath()
	local file = io.open(path, "w")

	local lineBuffer = tostring(current_shape_index) .. "\n";
	file:write(lineBuffer)

	-- Loops and writes the estados to the file
	for i=1, #estados_data.stack do
		local stateLineBuffer = estados_data.stack[i] .. "\n"
		file:write(stateLineBuffer)
	end
	-- Done with the file.
	io.close(file)	
	file = nil;
	-- Saved game flag ON
	storyboard.savedGame = true;
end

------------------------- fileExists() ------------------------------
-- in: 		filename 	: the file to read
-- out: 	true 		: the file exists
--			false       : the file does not exist
-- Purpose:	verifies the existance of a file
helpers.fileExists = function(filename)
	local path = system.pathForFile(filename, system.DocumentsDirectory)
	local f=io.open(path,"r")
	if f~=nil then io.close(f) return true else return false end
end

------------------------- getDistance() ------------------------------
-- in: 		objA 		: an obj with x and y coords
--			objB		: an obj with x and y coords
-- out: 	dist 		: the distance between objA and objB
-- Purpose:	Returns the linear distance between two objects
helpers.getDistance = function(objA, objB)
	local dX = objB.x - objA.x;
	local dY = objB.y - objA.y;
	local distSq = (dX ^ 2) + (dY ^ 2);

	return math.sqrt(distSq);
end

------------------------- saveGame() ------------------------------
-- in: 		playername
-- out: 	None
-- Purpose:	Saves the game state to be loaded later
helpers.saveGame = function(playername)
	t.writeFile(playername, "NombreDeWey");
end

helpers.testScores = {}

helpers.testScores.name = 
{
	"Player01",
	"Player02",
	"Player03",
	"Player04",
	"Player05",
}

helpers.testScores.score = 
{
	"60",
	"70",
	"80",
	"90",
	"100",
}

helpers.saveHighScores = function(highScoresDict)

	local hs = highScoresDict

	local path = system.pathForFile("hs.txt", system.DocumentsDirectory)
	local file = io.open(path, "w")

	for i=1, #hs.name do
		print(hs.name[i])
		print(hs.score[i])
		local string = hs.name[i] .. ";" .. hs.score[i] .. ";"
		file:write(string)
		print(i)
	end


	io.close( file )
end

helpers.readHighScores = function()
	local path = system.pathForFile("hs.txt", system.DocumentsDirectory)
	local file = io.open(path, "r")
	local inputData = file:read("*a")
	io.close(file)

	local table = inputData:split(";")
	print("This has " .. #table)

	for i=1,#table do
		print(table[i])
	end

	-- for i=1,#table -1,2 do
	-- 	local stringu = table[i] .. " has " .. table[i+1]
	-- 	print(stringu)
	-- end
	return table
end

------------------------- centerX() ------------------------------
-- in: 		an image
-- out: 	None
-- Purpose:	Centers the images position on the x axis
helpers.centerX = function(image)
	--local center = display.contentWidth * 0.5;
	--local offset = image.width * 0.5;

	image.x = (display.contentWidth - image.width) * 0.5;
	
	print("centered image.x = " .. image.x)
end

------------------------- centerY() ------------------------------
-- in: 		an image
-- out: 	None
-- Purpose:	Centers the images position on the y axis
helpers.centerY = function(image)
	image.y = (display.contentHeight - image.height) * 0.5
	print("centered image.y = " .. image.y)
end

------------------------- centerImage() ------------------------------
-- in: 		an image
-- out: 	None
-- Purpose:	Centers the images position on the x and y axis
helpers.centerImage = function(image)
	t.centerX(image)
	t.centerY(image)
end
------------------------- loadGame() ------------------------------
-- in: 		playername
-- out: 	None
-- Purpose:	Loads the game state 
helpers.loadGame = function(playername)
	print("loaded game")
	data = t.readFile(playername)

	print("data loaded: " .. data)
	-- Load the data onto the storyboard.
	storyboard.playerProfile.name = data;
end

-- Returns true if device is an Android
helpers.isAndroid = function()
	return ("Android" == system.getInfo("platformName"))
end

-- Returns true if device is a Simulator
helpers.isSimulator = function()
	return ("simulator" == system.getInfo("enviroment"))
end

helpers.fade = function(image, time)
	image.alpha = 0;

	-- fade in
	transition.to(image, {time=time, delay=10, alpha=1})
	-- fade out
	transition.to(image, {time=time, delay=time+10, alpha=0})
end

helpers.centerBackground = function(background)
	background.anchorX = 0.5
	background.anchorY = 0.5
	--background:setReferencePoint(display.CenterReferencePoint)
	background.x = display.contentWidth * 0.5
	background.y = display.contentHeight * 0.5
	print("Background's position = " .. background:localToContent(0,0))
end

-----------------------------getSaveGamePath()----------------------------
-- Returns: a path to the savefile.
helpers.getSaveGamePath = function()
	return system.pathForFile("saveGame.txt", system.DocumentsDirectory)
end


-- Return the module:
return helpers
