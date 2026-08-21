local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiAFK_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 319, 0, 120)
MainFrame.Position = UDim2.new(0.376, 0, 0.326, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 8)
TitleBarCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 130, 1, 0)
TitleLabel.Position = UDim2.new(0.02, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = ""
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.FontFace = Font.new("rbxasset://fonts/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TitleLabel.Parent = TitleBar

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Size = UDim2.new(0, 80, 1, 0)
CreditsLabel.Position = UDim2.new(0.25, 0, 0, 0)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = ""
CreditsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
CreditsLabel.TextSize = 10
CreditsLabel.TextXAlignment = Enum.TextXAlignment.Left
CreditsLabel.FontFace = TitleLabel.FontFace
CreditsLabel.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Position = UDim2.new(1, -58, 0.5, -14)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.BorderSizePixel = 0
MinimizeButton.FontFace = TitleLabel.FontFace
MinimizeButton.Parent = TitleBar
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -28, 0.5, -14)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseButton.Text = "x"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.FontFace = TitleLabel.FontFace
CloseButton.Parent = TitleBar
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local StatusCircle = Instance.new("Frame")
StatusCircle.Size = UDim2.new(0, 5, 0, 5)
StatusCircle.Position = UDim2.new(0, 75, 0, 10)
StatusCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatusCircle.BorderSizePixel = 0
StatusCircle.Parent = ContentFrame
local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = StatusCircle

TweenService:Create(StatusCircle, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.7
}):Play()

local TimeFrame = Instance.new("Frame")
TimeFrame.Size = UDim2.new(0, 90, 0, 30)
TimeFrame.Position = UDim2.new(0.056, 0, 0.25, 0)
TimeFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 21)
TimeFrame.BorderSizePixel = 0
TimeFrame.Parent = ContentFrame
local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0, 4)
TimeCorner.Parent = TimeFrame
local TimeStroke = Instance.new("UIStroke")
TimeStroke.Color = Color3.fromRGB(60, 60, 60)
TimeStroke.Parent = TimeFrame

local TimeDecor = Instance.new("Frame")
TimeDecor.Size = UDim2.new(0, 3, 0, 15)
TimeDecor.Position = UDim2.new(0.089, 0, 0.233, 0)
TimeDecor.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
TimeDecor.BorderSizePixel = 0
TimeDecor.Parent = TimeFrame

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(0, 62, 0, 30)
TimeLabel.Position = UDim2.new(0.244, 0, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "00:00:00"
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.TextSize = 14
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeLabel.FontFace = TitleLabel.FontFace
TimeLabel.Parent = TimeFrame

local PingFrame = Instance.new("Frame")
PingFrame.Size = UDim2.new(0, 90, 0, 30)
PingFrame.Position = UDim2.new(0.357, 0, 0.25, 0)
PingFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 21)
PingFrame.BorderSizePixel = 0
PingFrame.Parent = ContentFrame
local PingCorner = Instance.new("UICorner")
PingCorner.CornerRadius = UDim.new(0, 4)
PingCorner.Parent = PingFrame
local PingStroke = Instance.new("UIStroke")
PingStroke.Color = Color3.fromRGB(60, 60, 60)
PingStroke.Parent = PingFrame

local PingDecor = Instance.new("Frame")
PingDecor.Size = UDim2.new(0, 3, 0, 15)
PingDecor.Position = UDim2.new(0.089, 0, 0.233, 0)
PingDecor.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
PingDecor.BorderSizePixel = 0
PingDecor.Parent = PingFrame

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(0, 62, 0, 30)
PingLabel.Position = UDim2.new(0.244, 0, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "0ms"
PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PingLabel.TextSize = 14
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.FontFace = TitleLabel.FontFace
PingLabel.Parent = PingFrame

local FPSFrame = Instance.new("Frame")
FPSFrame.Size = UDim2.new(0, 90, 0, 30)
FPSFrame.Position = UDim2.new(0.658, 0, 0.25, 0)
FPSFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 21)
FPSFrame.BorderSizePixel = 0
FPSFrame.Parent = ContentFrame
local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 4)
FPSCorner.Parent = FPSFrame
local FPSStroke = Instance.new("UIStroke")
FPSStroke.Color = Color3.fromRGB(60, 60, 60)
FPSStroke.Parent = FPSFrame

local FPSDecor = Instance.new("Frame")
FPSDecor.Size = UDim2.new(0, 3, 0, 15)
FPSDecor.Position = UDim2.new(0.089, 0, 0.233, 0)
FPSDecor.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
FPSDecor.BorderSizePixel = 0
FPSDecor.Parent = FPSFrame

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 62, 0, 30)
FPSLabel.Position = UDim2.new(0.244, 0, 0, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "0 FPS"
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.TextSize = 14
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.FontFace = TitleLabel.FontFace
FPSLabel.Parent = FPSFrame

local RestoreButton = Instance.new("ImageButton")
RestoreButton.Name = "RestoreButton"
RestoreButton.Size = UDim2.new(0, 44, 0, 44)
RestoreButton.Position = UDim2.new(0.9, 0, 0.02, 0)
RestoreButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RestoreButton.Image = "rbxassetid://87635944735789"
RestoreButton.ScaleType = Enum.ScaleType.Fit
RestoreButton.BorderSizePixel = 0
RestoreButton.Visible = false
RestoreButton.Parent = ScreenGui
local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(1, 0)
RestoreCorner.Parent = RestoreButton

local Popup = Instance.new("Frame")
Popup.Name = "Popup"
Popup.Size = UDim2.new(0, 273, 0, 121)
Popup.Position = UDim2.new(0.5, -136.5, 0.5, -60.5)
Popup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Popup.BorderSizePixel = 0
Popup.Visible = false
Popup.ZIndex = 10
Popup.Parent = ScreenGui
local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 8)
PopupCorner.Parent = Popup
local PopupStroke = Instance.new("UIStroke")
PopupStroke.Color = Color3.fromRGB(255, 255, 255)
PopupStroke.Thickness = 1
PopupStroke.Parent = Popup

local PopupTitle = Instance.new("TextLabel")
PopupTitle.Size = UDim2.new(0, 273, 0, 32)
PopupTitle.Position = UDim2.new(0, 0, -0.008, 0)
PopupTitle.BackgroundTransparency = 1
PopupTitle.Text = "Close GUI?"
PopupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupTitle.TextSize = 17
PopupTitle.FontFace = TitleLabel.FontFace
PopupTitle.Parent = Popup

local PopupDesc = Instance.new("TextLabel")
PopupDesc.Size = UDim2.new(0, 273, 0, 40)
PopupDesc.Position = UDim2.new(0, 0, 0.198, 0)
PopupDesc.BackgroundTransparency = 1
PopupDesc.Text = "Anti-AFK will continue running in the background"
PopupDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
PopupDesc.TextSize = 14
PopupDesc.TextWrapped = true
PopupDesc.FontFace = TitleLabel.FontFace
PopupDesc.Parent = Popup

local YesButton = Instance.new("TextButton")
YesButton.Size = UDim2.new(0, 90, 0, 30)
YesButton.Position = UDim2.new(0.145, 0, 0.605, 0)
YesButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
YesButton.Text = "Yes"
YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
YesButton.TextSize = 14
YesButton.BorderSizePixel = 0
YesButton.FontFace = TitleLabel.FontFace
YesButton.Parent = Popup
local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 6)
YesCorner.Parent = YesButton
local YesStroke = Instance.new("UIStroke")
YesStroke.Color = Color3.fromRGB(80, 80, 80)
YesStroke.Parent = YesButton

local NoButton = Instance.new("TextButton")
NoButton.Size = UDim2.new(0, 90, 0, 30)
NoButton.Position = UDim2.new(0.524, 0, 0.605, 0)
NoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NoButton.Text = "No"
NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoButton.TextSize = 14
NoButton.BorderSizePixel = 0
NoButton.FontFace = TitleLabel.FontFace
NoButton.Parent = Popup
local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 6)
NoCorner.Parent = NoButton
local NoStroke = Instance.new("UIStroke")
NoStroke.Color = Color3.fromRGB(80, 80, 80)
NoStroke.Parent = NoButton

VirtualUser:CaptureController()
LocalPlayer.Idled:Connect(function()
    VirtualUser:ClickButton2(Vector2.new())
end)

local startTick = tick()
task.spawn(function()
    while true do
        local elapsed = tick() - startTick
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)
        TimeLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        PingLabel.Text = tostring(math.floor(ping)) .. "ms"
        task.wait(1)
    end
end)

local frameCount = 0
local lastFpsUpdate = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFpsUpdate >= 1 then
        FPSLabel.Text = tostring(frameCount) .. " FPS"
        frameCount = 0
        lastFpsUpdate = now
    end
end)

local function typeText(label, text, delay)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(delay)
    end
end

task.spawn(function()
    while true do
        typeText(TitleLabel, "Anti-AFK", 0.08)
        task.wait(1.5)
        typeText(CreditsLabel, "by king", 0.08)
        task.wait(2)
        TitleLabel.Text = ""
        CreditsLabel.Text = ""
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        TweenService:Create(TimeLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.5}):Play()
        task.wait(0.5)
        TweenService:Create(TimeLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
        task.wait(1)
        TweenService:Create(PingLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.5}):Play()
        task.wait(0.5)
        TweenService:Create(PingLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
        task.wait(1)
        TweenService:Create(FPSLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.5}):Play()
        task.wait(0.5)
        TweenService:Create(FPSLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
        task.wait(1)
    end
end)

local dragging = false
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    RestoreButton.Visible = true
end)

RestoreButton.MouseButton1Click:Connect(function()
    RestoreButton.Visible = false
    MainFrame.Visible = true
end)

CloseButton.MouseButton1Click:Connect(function()
    Popup.Visible = true
end)

YesButton.MouseButton1Click:Connect(function()
    Popup.Visible = false
    MainFrame.Visible = false
    RestoreButton.Visible = false
end)

NoButton.MouseButton1Click:Connect(function()
    Popup.Visible = false
end)
