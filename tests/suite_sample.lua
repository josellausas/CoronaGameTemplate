module(..., package.seeall)

local suite = {}
local helpers = require("helpers")

function suite.suite_setup()
	assert_not_nil(helpers)
end

function suite.test_sample()
	assert(true)
end

function suite.testDisplaySize()
	-- Test the screen size
	assert_equal(1136, display.contentWidth)
	assert_equal(768, display.contentHeight)
end

function suite.testScenes()
	-- Get a list of all the files inside the scenes folder:
	local files = helpers.getFilenamesFromDir("src/scenes/")
	assert_not_nil(files, "Dir \"src/scenes/\" does not exist")
	
	for i=1, #files do
		local s = files[i]
		-- Remove the extension from the filename
		local withoutExt = s:sub(1, #s - 4)
		
		local myModule = require(withoutExt)

		assert_not_nil(myModule)

		assert_function(myModule.enterScene)
		assert_function(myModule.exitScene)
		assert_function(myModule.createScene)
		assert_function(myModule.destroyScene)
		
	end
end

function suite.suite_teardown()

end

return suite
