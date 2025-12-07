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
		
		local function GetFromLink(Link: string): (boolean?, () -> ()?, string?)
			local Success, Result, HttpResult = pcall(function()
				local HttpResult = game:HttpGet(Link)
				return loadstring(HttpResult) :: any, HttpResult :: any
			end)
			
			if Success then
				return Result, HttpResult
			else
				return nil
			end
		end
		
		if shared.Testing then
			Function = GetFromLink(`https://github.com/alyssagithub/gold/raw/main/TestingScripts/{PlaceFileName}.luau`)
			
			local _, _, HttpResult = GetFromLink("https://github.com/alyssagithub/gold/raw/main/TestingScripts/TestingCore.luau")
			
			shared.Core = HttpResult
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
