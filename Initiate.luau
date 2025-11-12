--!strict
local PlaceInfo: {[string]: any} = {PlaceName = "Game", PlaceFileName = "Game"}

local NotificationMessage

do
	local GetPlaceName = loadstring(game:HttpGet("https://github.com/alyssagithub/gold/raw/main/Assets/GetPlaceName.luau"))

	if not GetPlaceName then
		NotificationMessage = "failed to get the GetPlaceName module"
	else
		PlaceInfo = GetPlaceName()
	end
end

local Function = PlaceInfo.Function

if not Function then
	Function = loadstring(game:HttpGet("https://github.com/alyssagithub/gold/raw/main/Scripts/Universal.luau"))
	NotificationMessage = "game not found, loading universal script..."
end

if not Function then
	NotificationMessage = "failed to load, try again"
end

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "gold (discord.gg/sS3tDP6FSB)",
	Text = NotificationMessage or "game found, loading script...",
	Duration = 10
})

local Success, Result = pcall(Function)

if not Success then
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "gold errored",
		Text = Result,
		Duration = 10
	})
	
	task.spawn(error, Result)
end
