--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:27df6e29414b7befeb35575364b4174b:a12feb5627a11ea0cd21c73acf2e24d9:160257223f33ed4db36bdcde926223d8$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- startscreen/startscreen-0
            x=1,
            y=1,
            width=400,
            height=240,

        },
        {
            -- startscreen/startscreen-1
            x=403,
            y=1,
            width=400,
            height=240,

        },
        {
            -- startscreen/startscreen-2
            x=805,
            y=1,
            width=400,
            height=240,

        },
    },

    sheetContentWidth = 1206,
    sheetContentHeight = 242
}

SheetInfo.frameIndex =
{

    ["startscreen/startscreen-0"] = 1,
    ["startscreen/startscreen-1"] = 2,
    ["startscreen/startscreen-2"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
