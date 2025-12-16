local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 local Window = Rayfield:CreateWindow({
     Name = "Zephyr V2",
     Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
     LoadingTitle = "Loading",
     LoadingSubtitle = "Waiting...",
     Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
  
     DisableRayfieldPrompts = false,
     DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
  
     ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Create a custom folder for your hub/game
        FileName = "Big Hub"
     },
  
     Discord = {
        Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
        Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
     },
  
     KeySystem = false, -- Set this to true to use our key system
     KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
        FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
     }
  })
Player = game.Players.LocalPlayer
Players = game.Players
CoreGui = game.CoreGui

RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
CoinCollectedEvent = game.ReplicatedStorage.Remotes.Gameplay.CoinCollected
RoundStartEvent = game.ReplicatedStorage.Remotes.Gameplay.RoundStart
RoundEndEvent = game.ReplicatedStorage.Remotes.Gameplay.RoundEndFade


ResetWhenFullBag = false

AutofarmIN = false

function returncoincontaier()
	for _, v in workspace:GetChildren() do
		if v:FindFirstChild("CoinContainer") and v:IsA("Model") then
			return v:FindFirstChild("CoinContainer")
		end
	end
	return false
end

CurrentCoinType = "SnowToken"
CoinCollectedEvent.OnClientEvent:Connect(function(cointype, current, max)
	AutofarmIN = true
	if cointype == CurrentCoinType and tonumber(current) == tonumber(max) then
		AutofarmIN = false
		if ResetWhenFullBag then
			Player.Character.Humanoid.Health = 0
		end
		if safespot then
			game.Players.LocalPlayer.Character:MoveTo(workspace.Lobby.Lobby.Spawns:GetChildren()[9].Position)
		end
	end
end)

function PcallTP(Position1,Position2,Position3)
	if Player.Character then
		if Player.Character:FindFirstChild("HumanoidRootPart") then
			Player.Character.HumanoidRootPart.Position = CFrame.new(Position1,Position2,Position3)
		end
	end
end
function rareegg(container)
	if container ~= false then
		for _, v in pairs(container:GetChildren()) do
			if v:FindFirstChild("ParticleEmitter") then
				if game.Players.LocalPlayer.Character then
					game.Players.LocalPlayer.Character:MoveTo(v.Position)
				end
			end
		end
	end
end
--[[function destroyvisual(con)
	for _, v in pairs(con:GetChildren()) do
		if v:FindFirstChild("CoinVisual") then
			v:FindFirstChild("CoinVisual"):Destroy()
		end
	end
end]]
function FindNearestCoin(container)
	local coin = nil
	local magn = math.huge
	for _, v in pairs(container:GetChildren()) do
		if v:FindFirstChild("CoinVisual") then
			if v:GetAttribute("CoinID") == CurrentCoinType and v:FindFirstChild("TouchInterest") and v:FindFirstChild("CoinVisual").ClassName == "MeshPart" then
				if Player.Character then
					if Player.Character:FindFirstChild("HumanoidRootPart") then
						if math.abs((Player.Character.HumanoidRootPart.Position - v.Position).Magnitude) < magn then
							coin = v
							magn = math.abs((Player.Character.HumanoidRootPart.Position - v.Position).Magnitude)
						end
					end
				end
			end
		end
	end
	local gg = {coin, magn}
	return gg
end

autofarmspeed = 25

spawn(function()
	while task.wait() do
		if Autofarmrare then
			rareegg(returncoincontaier())
		end
		if AutofarmStarted and AutofarmIN and Player.Character and returncoincontaier() then
			if FindNearestCoin(returncoincontaier())[1] ~= nil then
				local dds = FindNearestCoin(returncoincontaier())
				local dds1 = tostring(dds[1].Position)
				local strg = TweenService:Create(Player.Character.HumanoidRootPart, TweenInfo.new(dds[2] / autofarmspeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(dds[1].Position)})
				strg:Play()
				while dds[1]:FindFirstChild("TouchInterest") do
					task.wait()
				end
				strg:Cancel()
			end
		else
			task.wait()
		end
	end
end)

RoundStartEvent.OnClientEvent:Connect(function()
	AutofarmIN = true
end)

RoundEndEvent.OnClientEvent:Connect(function()
	AutofarmIN = false
end)
local bb = game:GetService("VirtualUser") -- Anti AFK
game:service "Players".LocalPlayer.Idled:connect(
    function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
    end
)




 local Tab1 = Window:CreateTab("Auto Farm", 4483362458)
 local Toggle1 = Tab1:CreateToggle({
        Name = "SnowToken Autofarm",
     CurrentValue = false,
     Flag = "Toggle1",
     Callback = function(Value)
         dsaidyuasudya = Value
         AutofarmStarted = Value 
         AutofarmIN = Value
         RoundStartEvent.OnClientEvent:Connect(function()
             AutofarmIN = true
         end)
         RoundEndEvent.OnClientEvent:Connect(function()
             AutofarmIN = false
         end)
     end,
 })
 local Slider = Tab1:CreateSlider({
    Name = "Auto Farm Speed",
    Range = {10, 40},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 25,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        autofarmspeed = Value
    end,
 })
 --[[local Toggle1 = Tab1:CreateToggle({
        Name = "Auto Rare Egg",
     CurrentValue = false,
     Flag = "Toggle1",
     Callback = function(Value)
         Autofarmrare = Value
     end,
 })]]
 local Toggle2 = Tab1:CreateToggle({
        Name = "Reset when full bag",
     CurrentValue = false,
     Flag = "Toggle2",
     Callback = function(Value)
         ResetWhenFullBag = Value
     end,
 })
 local Toggle4 = Tab1:CreateToggle({
        Name = "Teleport to Lobby when full bag",
     CurrentValue = false,
     Flag = "Toggle4",
     Callback = function(Value)
         safespot = Value
     end,
 })
 local Toggle3 = Tab1:CreateToggle({
        Name = "Anti AFK",
     CurrentValue = false,
     Flag = "Toggle3",
     Callback = function(Value)
     end,
 })
