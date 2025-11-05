--!strict
local GamePlaces = game:GetService("AssetService"):GetGamePlacesAsync()

local Function

local PlaceName
local PlaceFileName

while true do
	for _, PlaceInfo: {Name: string, PlaceId: number} in GamePlaces:GetCurrentPage() do
		PlaceName = PlaceInfo.Name

		PlaceFileName = PlaceName
		PlaceFileName = PlaceFileName:gsub("%b[]", "")
		PlaceFileName = PlaceFileName:gsub("[^%a]", "")

		local Success
		Success, Function = pcall(function()
			return loadstring(game:HttpGet(`https://github.com/alyssagithub/gold/raw/main/Games/{PlaceFileName}.luau`))
		end)
		
		if not Success then
			Function = nil
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
	PlaceName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	
	PlaceFileName = PlaceName
	PlaceFileName = PlaceFileName:gsub("%b[]", "")
	PlaceFileName = PlaceFileName:gsub("[^%a]", "")
end

return {PlaceName = PlaceName, PlaceFileName = PlaceFileName, Function = Function}
