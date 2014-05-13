--[[ 
	config
	-------------
	Created date : March 20, 2013
	Created by   : jose@josellausas.com
	-------------
	Purpose		 :
		Sets the configuration for the app
--]]

application =
{
	-- dissable analytics for now:
	launchpad = false,
	
	content =
	{		
		-- graphicsCompatibility = 1, -- Graphics compatibility
		
		width = 768,				  -- Content Width
		height = 1136,
		
		--scale values: none, letterbox, zoomEven, zoomStretch
		scale = "zoomEven",
		xAlign = "center",
		yAlign = "center",
		
		--for HD/Retina phones, multiple Image selection FTW:
		imageSuffix = 
		{
			--iPhone4/ iPod4 / iPad1 / iPad2 / KindleFire HD 7 / Galaxy S3
			["@2x"] = 0.8,
			--Retina iPad, Kindle Fire HD 9, Nexus 10
			["@4x"] = 1.5,
			--Example filename:
			--MyImage.png, myImage@2x.png
		}
	}
}