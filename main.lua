--------------------------GameTemplate--------------------------------
-- Designed and developed by: Jose A. Llausas [jose@josellausas.com]
----------------------------------------------------------------------

--[[-----------------------------
	main.lua
---------------------------------
 Author: 	Jose Llausas
 Email: 	jose@zunware.com
 Created: 	May 3, 2013
 Purpose: 	Starting point for creating a new game
]]

-- adds the ./lib directory to package path.
package.path = package.path .. ";./lib/?.lua" .. ";./src/?.lua" .. ";./src/scenes/?.lua"

local ll = require("llauColors")

-- Unit Testing
local __RUN_TESTS__ = true
if 	 (__RUN_TESTS__ == true) then

	local luna = require("lunatest")

	luna.suite("tests.suite_sample")
	luna.run()
end

local storyboard = require("storyboard")
storyboard.gotoScene("templateScene")
