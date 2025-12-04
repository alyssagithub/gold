--!strict
local GamePlaces = game:GetService("AssetService"):GetGamePlacesAsync()

local Function

local PlaceName
local PlaceFileName

local function SetPlace(Name: string)
	PlaceName = Name

	PlaceFileName = PlaceName:gsub("%b[]", "")
	PlaceFileName = PlaceFileName:gsub("[^%a]", "")
end

while true do
	for _, PlaceInfo: {Name: string, PlaceId: number} in GamePlaces:GetCurrentPage() do
		SetPlace(PlaceInfo.Name)
		
		local function GetFromLink(Link: string)
			local Success, Result = pcall(function()
				return loadstring(game:HttpGet(Link)) :: any
			end)
			
			if Success then
				return Result
			else
				return nil
			end
		end
		
		if shared.Testing then
			Function = GetFromLink(`https://github.com/alyssagithub/gold/raw/main/TestingScripts/{PlaceFileName}.luau`)
			
			shared.Core = game:HttpGet("https://github.com/alyssagithub/gold/raw/main/TestingScripts/TestingCore.luau")
		end
		
		if not Function then
			Function = GetFromLink(`https://github.com/alyssagithub/gold/raw/main/Scripts/{PlaceFileName}.luau`)
		end

		if Function then
			break
		end
	end

	if GamePlaces.IsFinished or Function then
		break
	end

	GamePlaces:AdvanceToNextPageAsync()
end

if not Function then
	SetPlace(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
end

return {PlaceName = PlaceName, PlaceFileName = PlaceFileName, Function = Function}
