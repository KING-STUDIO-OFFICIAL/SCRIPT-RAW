if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local leaderstats = player:WaitForChild("leaderstats")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")

local debugMod = false
local function log(x)
    if debugMod then print(x) end
end

local crashFns = {
    Crash = true, HardCrash = true, GPUCrash = true,
    RAMCrash = true, KillClient = true, SetFPS = true
}

local function nothing() end

local function hookTableFunctions(t)
    if rawget(t, "RegisterHitbox") then
        pcall(function() hookfunction(t.RegisterHitbox.Fire, nothing) end)
        return
    end
    for name, elem in t do
        if typeof(elem) == "function" then
            pcall(function() hookfunction(elem, nothing) end)
        elseif typeof(elem) == "table" then
            local remote = rawget(elem, "_re")
            if remote and remote.OnClientEvent then
                pcall(function()
                    for _, con in getconnections(remote.OnClientEvent) do
                        con:Disable()
                    end
                end)
            end
            pcall(function() hookfunction(elem.Fire, nothing) end)
        end
    end
end

pcall(function()
    for _, elem in getgc(true) do
        if typeof(elem) == "table" then
            if rawget(elem, "Detected") and typeof(elem.Detected) == "function" and rawget(elem, "RLocked") then
                hookfunction(elem.Detected, function(action, reason, nocrash)
                    log("Detected: Action: " .. tostring(action) .. ", Reason: " .. tostring(reason) .. ", Crashing: " .. tostring(not nocrash))
                    return true
                end)
            end
            if (rawget(elem, "ILikeToMoveItMoveIt") and rawget(elem, "CasperSlidePartTwo") and rawget(elem, "NineteenDollaFortniteGiftCard")) or rawget(elem, "RegisterHitbox") then
                hookTableFunctions(elem)
            end
        elseif typeof(elem) == "function" then
            local name = debug.info(elem, "n")
            if crashFns[name] or name == "crashPlayer" then
                hookfunction(elem, nothing)
                if name == "crashPlayer" then print("Hooked crash") end
            end
        end
    end
end)

local oldNCMT
pcall(function()
    oldNCMT = hookmetamethod(player, "__namecall", function(self, ...)
        if not checkcaller() and rawequal(getnamecallmethod(), "Kick") then
            return
        else
            return oldNCMT(self, ...)
        end
    end)
end)

local oldIMT
pcall(function()
    oldIMT = hookmetamethod(game, "__index", newcclosure(function(self, k)
        if not checkcaller() and rawequal(k, "Speed") and rawequal(oldIMT(self, "ClassName"), "AnimationTrack") then
            return 1
        end
        return oldIMT(self, k)
    end))
end)

pcall(function()
    workspace:SetAttribute("SillyTest", true)
    workspace:GetAttributeChangedSignal("SillyTest"):Connect(function()
        workspace:SetAttribute("SillyTest", true)
    end)
end)

local getgenv_func, getnamecallmethod_func, hookmetamethod_func, hookfunction_func, newcclosure_func, checkcaller_func, lower_func, gsub_func, match_func = getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, string.lower, string.gsub, string.match

if not getgenv_func().ED_AntiKick then
    local cloneref = cloneref or function(...) return ... end
    local clonefunction = clonefunction or function(...) return ... end
    local LocalPlayer = cloneref(Players.LocalPlayer)
    local ClonedStarterGui = cloneref(StarterGui)
    local SetCore = clonefunction(ClonedStarterGui.SetCore)
    local FindFirstChild = clonefunction(game.FindFirstChild)
    local CompareInstances = function(Instance1, Instance2)
        return (typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance")
    end
    local CanCastToSTDString = function(...)
        return pcall(FindFirstChild, game, ...)
    end
    getgenv_func().ED_AntiKick = {
        Enabled = true,
        SendNotifications = true,
        CheckCaller = true
    }
    local OldNamecall; OldNamecall = hookmetamethod_func(game, "__namecall", newcclosure_func(function(...)
        local args = {...}
        local self = args[1]
        local method = getnamecallmethod_func()
        if ((getgenv_func().ED_AntiKick.CheckCaller and not checkcaller_func()) or true) and CompareInstances(self, LocalPlayer) and gsub_func(method, "^%l", string.upper) == "Kick" and getgenv_func().ED_AntiKick.Enabled then
            if CanCastToSTDString(args[2]) then
                if getgenv_func().ED_AntiKick.SendNotifications then
                    pcall(function()
                        SetCore(ClonedStarterGui, "SendNotification", {
                            Title = "KING Developer - Anti-Kick",
                            Text = "Successfully intercepted an attempted kick.",
                            Icon = "rbxassetid://134118410117592",
                            Duration = 2
                        })
                    end)
                end
                return
            end
        end
        return OldNamecall(...)
    end))
    local OldFunction; OldFunction = hookfunction_func(LocalPlayer.Kick, newcclosure_func(function(...)
        local args = {...}
        local self = args[1]
        if ((getgenv_func().ED_AntiKick.CheckCaller and not checkcaller_func()) or true) and CompareInstances(self, LocalPlayer) and getgenv_func().ED_AntiKick.Enabled then
            if CanCastToSTDString(args[2]) then
                if getgenv_func().ED_AntiKick.SendNotifications then
                    pcall(function()
                        SetCore(ClonedStarterGui, "SendNotification", {
                            Title = "KING Developer - Anti-Kick",
                            Text = "Successfully intercepted an attempted kick.",
                            Icon = "rbxassetid://134118410117592",
                            Duration = 2
                        })
                    end)
                end
                return
            end
        end
        return OldFunction(...)
    end))
    if getgenv_func().ED_AntiKick.SendNotifications then
        pcall(function()
            ClonedStarterGui:SetCore("SendNotification", {
                Title = "KING Developer - Anti-Kick",
                Text = "Anti-Kick script loaded!",
                Icon = "rbxassetid://134118410117592",
                Duration = 3
            })
        end)
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/KOD-STUDIO/refs/heads/main/KOD-LIBRARY.lua", true))()
local tituloTexto = "PAIN PRÍVATE || FARM"
local windowData, windowFrame = library:AddWindow(tituloTexto, {
    main_color = Color3.fromRGB(138, 0, 0),
    min_size = Vector2.new(450, 460),
    can_resize = false
})

if windowFrame then
    windowFrame.ImageColor3 = Color3.fromRGB(10, 10, 10)
    local topBar = windowFrame:FindFirstChild("Bar") or windowFrame
    local titleLabel = topBar:FindFirstChild("Title") or windowFrame:FindFirstChild("Title") or topBar:FindFirstChildWhichIsA("TextLabel", true) or windowFrame:FindFirstChildWhichIsA("TextLabel", true)
    if titleLabel then
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 22
        titleLabel.FontFace = Font.fromName("Creepster", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    end
end

local function styleGUI(obj)
    if typeof(obj) ~= "Instance" then return end
    
    if obj:IsA("TextLabel") or obj:IsA("TextButton") then
        obj.TextColor3 = Color3.fromRGB(255, 255, 255)
        obj.TextSize = 16
        if obj:IsA("TextButton") then
            obj.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            obj.BorderSizePixel = 1
            obj.BorderColor3 = Color3.fromRGB(100, 100, 100)
        end
    elseif obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
        obj.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        obj.BackgroundTransparency = 0.3
    end
    
    for _, child in ipairs(obj:GetChildren()) do
        if typeof(child) == "Instance" then
            styleGUI(child)
        end
    end
end

local mainTab = windowData:AddTab("MAIN")
local farmTab = windowData:AddTab("FARM")
local rebirthTab = windowData:AddTab("REBIRTH")
local miscTab = windowData:AddTab("MISC")
local creditTab = windowData:AddTab("CREDIT")

local function addFolder(tab, name)
    tab:AddLabel("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    local folderLabel = tab:AddLabel(name)
    folderLabel.TextSize = 26
    folderLabel.Font = Enum.Font.GothamBlack
    folderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab:AddLabel("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

local function formatNumber(num)
    if num >= 1e15 then return string.format("%.2fQ", num/1e15) end
    if num >= 1e12 then return string.format("%.2fT", num/1e12) end
    if num >= 1e9 then return string.format("%.2fB", num/1e9) end
    if num >= 1e6 then return string.format("%.2fM", num/1e6) end
    if num >= 1e3 then return string.format("%.2fK", num/1e3) end
    return string.format("%.0f", num)
end

local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then antiAFKConnection:Disconnect() end
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end
setupAntiAFK()

local function removePortals()
    for _, portal in pairs(game:GetDescendants()) do
        if portal.Name == "RobloxForwardPortals" then portal:Destroy() end
    end
    if _G.AdRemovalConnection then _G.AdRemovalConnection:Disconnect() end
    _G.AdRemovalConnection = game.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "RobloxForwardPortals" then descendant:Destroy() end
    end)
end
removePortals()

local blockedFrames = {"strengthFrame", "durabilityFrame", "agilityFrame", "evilKarmaFrame", "goodKarmaFrame"}
for _, name in ipairs(blockedFrames) do
    local frame = ReplicatedStorage:FindFirstChild(name)
    if frame and frame:IsA("GuiObject") then frame.Visible = false end
end
ReplicatedStorage.ChildAdded:Connect(function(child)
    if table.find(blockedFrames, child.Name) and child:IsA("GuiObject") then child.Visible = false end
end)

local function unequipAllPets()
    local petsFolder = player:FindFirstChild("petsFolder")
    if not petsFolder then return end
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                pcall(function()
                    ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("equipPetEvent"):FireServer("unequipPet", pet)
                end)
            end
        end
    end
end

local function equipPetsByName(petName, maxCount)
    maxCount = maxCount or 10
    unequipAllPets()
    task.wait(0.15)
    local petsFolder = player:FindFirstChild("petsFolder")
    if not petsFolder then return end
    local uniqueFolder = petsFolder:FindFirstChild("Unique")
    if not uniqueFolder then return end
    local equipped = 0
    for _, pet in pairs(uniqueFolder:GetChildren()) do
        if pet.Name == petName and equipped < maxCount then
            pcall(function()
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("equipPetEvent"):FireServer("equipPet", pet)
            end)
            equipped = equipped + 1
            task.wait(0.05)
        end
    end
end

addFolder(mainTab, "📊 TRACKERS")
local trackStrength = mainTab:AddLabel(" Strength: 0")
local trackRebirths = mainTab:AddLabel("🔄 Rebirths: 0")
local trackDurability = mainTab:AddLabel("🛡️ Durability: 0")
local trackKills = mainTab:AddLabel("💀 Kills: 0")
task.spawn(function()
    while true do
        local str = leaderstats:FindFirstChild("Strength")
        local reb = leaderstats:FindFirstChild("Rebirths")
        local dur = player:FindFirstChild("Durability")
        local kil = leaderstats:FindFirstChild("Kills")
        trackStrength.Text = "💪 Strength: " .. formatNumber(str and str.Value or 0)
        trackRebirths.Text = "🔄 Rebirths: " .. formatNumber(reb and reb.Value or 0)
        trackDurability.Text = "🛡️ Durability: " .. formatNumber(dur and dur.Value or 0)
        trackKills.Text = "💀 Kills: " .. formatNumber(kil and kil.Value or 0)
        task.wait(0.5)
    end
end)

addFolder(mainTab, "⚙️ SETTINGS")
local changeSpeedSizeRemote = ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("changeSpeedSizeRemote")
local userSize = 2
local sizeActive = false
mainTab:AddTextBox("Size", function(text)
    local value = tonumber(string.gsub(text, "%s+", ""))
    if value and value > 0 then userSize = value end
end, { placeholder = "2" })
mainTab:AddSwitch("Set Size", function(bool) sizeActive = bool end):Set(false)
task.spawn(function()
    while true do
        if sizeActive and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then changeSpeedSizeRemote:InvokeServer("changeSize", userSize) end
        end
        task.wait(0.15)
    end
end)

local userSpeed = 120
local speedActive = false
mainTab:AddTextBox("Speed", function(text)
    local value = tonumber(string.gsub(text, "%s+", ""))
    if value and value > 0 then userSpeed = value end
end, { placeholder = "120" })
mainTab:AddSwitch("Set Speed", function(bool) speedActive = bool end):Set(false)
task.spawn(function()
    while true do
        if speedActive and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then changeSpeedSizeRemote:InvokeServer("changeSpeed", userSpeed) end
        end
        task.wait(0.15)
    end
end)

addFolder(mainTab, "🛡️ IMPORTANT")
mainTab:AddSwitch("Anti Fling", function(bool)
    local char = player.Character
    if char then
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if bool then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                bodyVelocity.Parent = rootPart
            else
                local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
                if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                    existingVelocity:Destroy()
                end
            end
        end
    end
end):Set(true)

local lockRunning = false
mainTab:AddSwitch("Lock Position", function(state)
    lockRunning = state
    if lockRunning then
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local lockPosition = hrp.Position
        task.spawn(function()
            while lockRunning do
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.RotVelocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(lockPosition)
                task.wait(0.05)
            end
        end)
    end
end):Set(false)

mainTab:AddSwitch("Show Pets", function(bool)
    if player:FindFirstChild("hidePets") then player.hidePets.Value = bool end
end):Set(false)

mainTab:AddSwitch("Show Other Pets", function(bool)
    if player:FindFirstChild("showOtherPetsOn") then player.showOtherPetsOn.Value = bool end
end):Set(false)

addFolder(mainTab, " MISC")
mainTab:AddButton("Execute Anti-AFK", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/SCRIPT-RAW/refs/heads/main/Antiafk.lua"))()
end)

mainTab:AddSwitch("Infinite Jump", function(bool)
    _G.InfiniteJump = bool
    if bool then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfiniteJump then
                player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
end)

local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)

local function createAllParts()
    local numberOfParts = math.ceil(totalDistance / partSize)
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local function createPart(pos, name)
                local part = Instance.new("Part")
                part.Size = Vector3.new(partSize, 1, partSize)
                part.Position = pos
                part.Anchored = true
                part.Transparency = 1
                part.CanCollide = true
                part.Name = name
                part.Parent = workspace
                return part
            end
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,z*partSize), "Part_Side_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,z*partSize), "Part_LeftRight_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(-x*partSize,0,-z*partSize), "Part_UpLeft_"..x.."_"..z))
            table.insert(parts, createPart(startPosition + Vector3.new(x*partSize,0,-z*partSize), "Part_UpRight_"..x.."_"..z))
        end
    end
end
task.spawn(createAllParts)

mainTab:AddSwitch("Walk on Water", function(bool)
    for _, part in ipairs(parts) do
        if part and part.Parent then part.CanCollide = bool end
    end
end):Set(true)

mainTab:AddSwitch("Spin Fortune Wheel", function(bool)
    _G.AutoSpinWheel = bool
    if bool then
        task.spawn(function()
            while _G.AutoSpinWheel do
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer("openFortuneWheel", ReplicatedStorage:FindFirstChild("fortuneWheelChances")["Fortune Wheel"])
                task.wait(1)
            end
        end)
    end
end)

local timeDropdown = mainTab:AddDropdown("Change Time", function(selection)
    if selection == "Night" then Lighting.ClockTime = 0
    elseif selection == "Day" then Lighting.ClockTime = 12
    elseif selection == "Midnight" then Lighting.ClockTime = 6 end
end)
timeDropdown:Add("Night")
timeDropdown:Add("Day")
timeDropdown:Add("Midnight")

mainTab:AddButton("Anti Lag", function()
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") then gui:Destroy() end
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    local darkSky = Instance.new("Sky")
    darkSky.Name = "DarkSky"
    for _, side in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
        darkSky[side] = "rbxassetid://0"
    end
    darkSky.Parent = Lighting
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
    Lighting.Ambient = Color3.new(0,0,0)
    Lighting.FogColor = Color3.new(0,0,0)
    Lighting.FogEnd = 100
    settings().Rendering.QualityLevel = 1
end)

addFolder(farmTab, "📊 TRACKERS")
local farmStopwatchLabel = farmTab:AddLabel("0d 0h 0m 0s - Fast Rep Inactive")
farmStopwatchLabel.TextSize = 17
farmStopwatchLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
local projectedStrengthLabel = farmTab:AddLabel("Strength Pace: 0 /Hour | 0 /Day | 0 /Week")
projectedStrengthLabel.TextSize = 17
local projectedDurabilityLabel = farmTab:AddLabel("Durability Pace: 0 /Hour | 0 /Day | 0 /Week")
projectedDurabilityLabel.TextSize = 17
local averageStrengthLabel = farmTab:AddLabel("Average Strength Pace: 0 /Hour | 0 /Day | 0 /Week")
averageStrengthLabel.TextSize = 17
local averageDurabilityLabel = farmTab:AddLabel("Average Durability Pace: 0 /Hour | 0 /Day | 0 /Week")
averageDurabilityLabel.TextSize = 17
local strengthLabel = farmTab:AddLabel("Strength: 0 | Gained: 0")
strengthLabel.TextSize = 17
local durabilityLabel = farmTab:AddLabel("Durability: 0 | Gained: 0")
durabilityLabel.TextSize = 17

local runFastRep = false
local trackingStarted = false
local startTime = 0
local pausedElapsedTime = 0
local strengthHistory = {}
local durabilityHistory = {}
local initialStrength = (leaderstats:FindFirstChild("Strength") or {Value=0}).Value
local initialDurability = (player:FindFirstChild("Durability") or {Value=0}).Value

task.spawn(function()
    local lastCalcTime = tick()
    while true do
        local currentTime = tick()
        local currentStrength = (leaderstats:FindFirstChild("Strength") or {Value=0}).Value
        local currentDurability = (player:FindFirstChild("Durability") or {Value=0}).Value
        strengthLabel.Text = "Strength: " .. formatNumber(currentStrength) .. " | Gained: " .. formatNumber(currentStrength - initialStrength)
        durabilityLabel.Text = "Durability: " .. formatNumber(currentDurability) .. " | Gained: " .. formatNumber(currentDurability - initialDurability)
        
        if runFastRep then
            if not trackingStarted then
                trackingStarted = true
                startTime = currentTime
                strengthHistory = {}
                durabilityHistory = {}
            end
            
            local elapsedTime = pausedElapsedTime + (currentTime - startTime)
            local days = math.floor(elapsedTime / (24 * 3600))
            local hours = math.floor((elapsedTime % (24 * 3600)) / 3600)
            local minutes = math.floor((elapsedTime % 3600) / 60)
            local seconds = math.floor(elapsedTime % 60)
            
            farmStopwatchLabel.Text = string.format("%dd %dh %dm %ds - Fast Rep Running", days, hours, minutes, seconds)
            farmStopwatchLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
            
            table.insert(strengthHistory, {time = currentTime, value = currentStrength})
            table.insert(durabilityHistory, {time = currentTime, value = currentDurability})
            
            while #strengthHistory > 0 and currentTime - strengthHistory[1].time > 10 do table.remove(strengthHistory, 1) end
            while #durabilityHistory > 0 and currentTime - durabilityHistory[1].time > 10 do table.remove(durabilityHistory, 1) end
            
            if currentTime - lastCalcTime >= 10 then
                lastCalcTime = currentTime
                if #strengthHistory >= 2 then
                    local strengthDelta = strengthHistory[#strengthHistory].value - strengthHistory[1].value
                    local strengthPerSecond = strengthDelta / 10
                    projectedStrengthLabel.Text = string.format("Strength Pace: %s/Hour | %s/Day | %s/Week", formatNumber(strengthPerSecond*3600), formatNumber(strengthPerSecond*86400), formatNumber(strengthPerSecond*604800))
                end
                if #durabilityHistory >= 2 then
                    local durabilityDelta = durabilityHistory[#durabilityHistory].value - durabilityHistory[1].value
                    local durabilityPerSecond = durabilityDelta / 10
                    projectedDurabilityLabel.Text = string.format("Durability Pace: %s/Hour | %s/Day | %s/Week", formatNumber(durabilityPerSecond*3600), formatNumber(durabilityPerSecond*86400), formatNumber(durabilityPerSecond*604800))
                end
                
                local totalElapsed = pausedElapsedTime + (currentTime - startTime)
                if totalElapsed > 0 then
                    local avgStrengthPerSecond = (currentStrength - initialStrength) / totalElapsed
                    averageStrengthLabel.Text = "Average Strength Pace: " .. formatNumber(avgStrengthPerSecond*3600) .. "/Hour | " .. formatNumber(avgStrengthPerSecond*86400) .. "/Day | " .. formatNumber(avgStrengthPerSecond*604800) .. "/Week"
                    local avgDurabilityPerSecond = (currentDurability - initialDurability) / totalElapsed
                    averageDurabilityLabel.Text = "Average Durability Pace: " .. formatNumber(avgDurabilityPerSecond*3600) .. "/Hour | " .. formatNumber(avgDurabilityPerSecond*86400) .. "/Day | " .. formatNumber(avgDurabilityPerSecond*604800) .. "/Week"
                end
            end
        else
            if trackingStarted then
                trackingStarted = false
                pausedElapsedTime = pausedElapsedTime + (currentTime - startTime)
                farmStopwatchLabel.Text = string.format("%dd %dh %dm %ds - Fast Rep Stopped", math.floor(pausedElapsedTime / (24 * 3600)), math.floor((pausedElapsedTime % (24 * 3600)) / 3600), math.floor((pausedElapsedTime % 3600) / 60), math.floor(pausedElapsedTime % 60))
                farmStopwatchLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
                projectedStrengthLabel.Text = "Strength Pace: 0 /Hour | 0 /Day | 0 /Week"
                projectedDurabilityLabel.Text = "Durability Pace: 0 /Hour | 0 /Day | 0 /Week"
                averageStrengthLabel.Text = "Average Strength Pace: 0 /Hour | 0 /Day | 0 /Week"
                averageDurabilityLabel.Text = "Average Durability Pace: 0 /Hour | 0 /Day | 0 /Week"
                strengthHistory = {}
                durabilityHistory = {}
            end
        end
        task.wait(0.05)
    end
end)

addFolder(farmTab, " FAST FARM")
local repsPerTick = 1
local pingControl = true
local networkStats = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
local function getCurrentPing()
    return networkStats:GetValue()
end
local function getAdaptiveSpeed(ping)
    if ping < 80 then return 500
    elseif ping < 150 then return 300
    elseif ping < 250 then return 100
    else return 50 end
end

farmTab:AddTextBox("Rep Speed", function(value)
    local num = tonumber(value)
    if num and num > 0 then repsPerTick = math.floor(num) end
end, { placeholder = "1" })

farmTab:AddSwitch("Controlled Speed", function(bool)
    pingControl = bool
end):Set(true)

local function fastRepLoop()
    local lastPingUpdate = tick()
    local currentPing = getCurrentPing()
    while runFastRep do
        if tick() - lastPingUpdate > 0.5 then
            currentPing = getCurrentPing()
            lastPingUpdate = tick()
        end
        local repsToFire = pingControl and getAdaptiveSpeed(currentPing) or repsPerTick
        local delayBetweenBatches = math.clamp(currentPing / 2500, 0.001, 0.1)
        for repCount = 1, math.min(repsToFire, repsPerTick) do
            muscleEvent:FireServer("rep")
            if repCount % 500 == 0 then task.wait(0) end
        end
        task.wait(delayBetweenBatches)
    end
end

farmTab:AddSwitch("Fast Rep", function(state)
    if state and not runFastRep then
        runFastRep = true
        task.spawn(fastRepLoop)
    elseif not state and runFastRep then
        runFastRep = false
    end
end)

farmTab:AddLabel("For me, 20-40 works the best")
farmTab:AddLabel("Try Around!")

local function activateProteinEgg()
    local tool = player.Character:FindFirstChild("Protein Egg") or player.Backpack:FindFirstChild("Protein Egg")
    if tool then muscleEvent:FireServer("proteinEgg", tool) end
end

local autoEggRunning = false
farmTab:AddSwitch("Auto Egg", function(state)
    autoEggRunning = state
    if state then activateProteinEgg() end
end):Set(false)

task.spawn(function()
    while true do
        if autoEggRunning then activateProteinEgg(); task.wait(0.25) else task.wait(1) end
    end
end)

local function activateShake()
    local tool = player.Character:FindFirstChild("Tropical Shake") or player.Backpack:FindFirstChild("Tropical Shake")
    if tool then muscleEvent:FireServer("tropicalShake", tool) end
end

local autoShakeRunning = false
farmTab:AddSwitch("Auto Shake", function(state)
    autoShakeRunning = state
    if state then activateShake() end
end):Set(false)

task.spawn(function()
    while true do
        if autoShakeRunning then activateShake(); task.wait(900) else task.wait(1) end
    end
end)

addFolder(farmTab, "🚜 AUTO FARM")
local SelectedTool = nil
local AutoFarm = false

local toolDropdown = farmTab:AddDropdown("Select Tool", function(selection) SelectedTool = selection end)
toolDropdown:Add("Weight")
toolDropdown:Add("Pushups")
toolDropdown:Add("Situps")
toolDropdown:Add("Handstands")
toolDropdown:Add("Fast Punch")
toolDropdown:Add("Stomp")
toolDropdown:Add("Ground Slam")

farmTab:AddSwitch("Start Auto Farm", function(enabled)
    AutoFarm = enabled
    if enabled then
        task.spawn(function()
            while AutoFarm do
                if SelectedTool == "Weight" or SelectedTool == "Pushups" or SelectedTool == "Situps" or SelectedTool == "Handstands" then
                    local tool = player.Backpack:FindFirstChild(SelectedTool)
                    if tool and not player.Character:FindFirstChild(SelectedTool) then player.Character.Humanoid:EquipTool(tool) end
                    muscleEvent:FireServer("rep")
                elseif SelectedTool == "Fast Punch" then
                    local punch = player.Backpack:FindFirstChild("Punch")
                    if punch then punch.Parent = player.Character end
                    muscleEvent:FireServer("punch", "rightHand"); muscleEvent:FireServer("punch", "leftHand")
                elseif SelectedTool == "Stomp" or SelectedTool == "Ground Slam" then
                    local tool = player.Backpack:FindFirstChild(SelectedTool)
                    if tool then tool.Parent = player.Character end
                    muscleEvent:FireServer(SelectedTool == "Stomp" and "stomp" or "slam")
                end
                task.wait()
            end
        end)
    end
end)

local rockData = {
    ["Tiny Rock"] = 0,
    ["Starter Island"] = 100,
    ["Punching Rock"] = 1000,
    ["Golden Rock"] = 5000,
    ["Frost Rock"] = 150000,
    ["Mythical Rock"] = 400000,
    ["Eternal Rock"] = 750000,
    ["Legend Rock"] = 1000000,
    ["Muscle King Rock"] = 5000000,
    ["Jungle Rock"] = 10000000
}
local selectedRock = nil

local rockDropdown = farmTab:AddDropdown("Select Rock", function(selection) selectedRock = selection end)
rockDropdown:Add("Tiny Rock")
rockDropdown:Add("Starter Island")
rockDropdown:Add("Punching Rock")
rockDropdown:Add("Golden Rock")
rockDropdown:Add("Frost Rock")
rockDropdown:Add("Mythical Rock")
rockDropdown:Add("Eternal Rock")
rockDropdown:Add("Legend Rock")
rockDropdown:Add("Muscle King Rock")
rockDropdown:Add("Jungle Rock")

farmTab:AddSwitch("Auto Rock", function(enabled)
    if enabled and selectedRock then
        task.spawn(function()
            local requiredDurability = rockData[selectedRock]
            while enabled do
                task.wait()
                if (player:FindFirstChild("Durability") or {Value=0}).Value >= requiredDurability then
                    for _, v in pairs(workspace:FindFirstChild("machinesFolder") and workspace.machinesFolder:GetDescendants() or {}) do
                        if v.Name == "neededDurability" and v.Value == requiredDurability and player.Character:FindFirstChild("LeftHand") and player.Character:FindFirstChild("RightHand") then
                            local rock = v.Parent:FindFirstChild("Rock")
                            if rock then
                                firetouchinterest(rock, player.Character.RightHand, 0)
                                firetouchinterest(rock, player.Character.RightHand, 1)
                                firetouchinterest(rock, player.Character.LeftHand, 0)
                                firetouchinterest(rock, player.Character.LeftHand, 1)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

addFolder(rebirthTab, "📊 TRACKERS")
local isRunningV1 = false
local isRunningV2 = false
local startTimeReb = 0
local totalElapsedReb = 0
local initialRebirths = rebirthsStat.Value
local serverLabel = rebirthTab:AddLabel("Time:")
serverLabel.TextSize = 20
local timeLabel = rebirthTab:AddLabel("0d 0h 0m 0s - Inactive")
local paceLabel = rebirthTab:AddLabel("Pace: 0 / Hour | 0 / Day | 0 / Week")
local averagePaceLabel = rebirthTab:AddLabel("Average Pace: 0 / Hour | 0 / Day | 0 / Week")
paceLabel.TextSize = 17
averagePaceLabel.TextSize = 17
timeLabel.TextSize = 17
timeLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
local rebirthsStatsLabel = rebirthTab:AddLabel("Rebirths: "..formatNumber(rebirthsStat.Value).." | Gained: 0")
rebirthsStatsLabel.TextSize = 17
local lastRebirthTime = tick()
local lastRebirthValue = rebirthsStat.Value
local paceHistoryHour = {}
local paceHistoryDay = {}
local paceHistoryWeek = {}
local maxHistoryLength = 20
local rebirthCount = 0

local function updateRebirthsLabel()
    local gained = rebirthsStat.Value - initialRebirths
    rebirthsStatsLabel.Text = string.format("Rebirths: %s | Gained: %s", formatNumber(rebirthsStat.Value), formatNumber(gained))
end

local function updateUI(forceUpdate)
    local currentTime = tick()
    local elapsed = (isRunningV1 or isRunningV2) and (currentTime - startTimeReb + totalElapsedReb) or totalElapsedReb
    local days = math.floor(elapsed / 86400)
    local hours = math.floor((elapsed % 86400) / 3600)
    local minutes = math.floor((elapsed % 3600) / 60)
    local seconds = math.floor(elapsed % 60)
    local status = "Paused"
    if isRunningV1 then status = "Fast Reb V1 Running"
    elseif isRunningV2 then status = "Fast Reb V2 Running (x2 Rebirths + 20% Rep Speed)" end
    timeLabel.Text = string.format("%dd %dh %dm %ds - %s", days, hours, minutes, seconds, status)
    timeLabel.TextColor3 = (isRunningV1 or isRunningV2) and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end

local function calculatePaceOnRebirth()
    rebirthCount = rebirthCount + 1
    if rebirthCount < 2 then
        lastRebirthTime = tick()
        lastRebirthValue = rebirthsStat.Value
        return
    end
    local now = tick()
    local gained = rebirthsStat.Value - lastRebirthValue
    if gained > 0 then
        local avgTimePerRebirth = (now - lastRebirthTime) / gained
        local paceHour = 3600 / avgTimePerRebirth
        local paceDay = 86400 / avgTimePerRebirth
        local paceWeek = 604800 / avgTimePerRebirth
        paceLabel.Text = string.format("Pace: %s / Hour | %s / Day | %s / Week", formatNumber(paceHour), formatNumber(paceDay), formatNumber(paceWeek))
        table.insert(paceHistoryHour, paceHour)
        table.insert(paceHistoryDay, paceDay)
        table.insert(paceHistoryWeek, paceWeek)
        if #paceHistoryHour > maxHistoryLength then
            table.remove(paceHistoryHour, 1)
            table.remove(paceHistoryDay, 1)
            table.remove(paceHistoryWeek, 1)
        end
        local function average(tbl)
            local sum = 0
            for _, v in ipairs(tbl) do sum = sum + v end
            return #tbl > 0 and (sum / #tbl) or 0
        end
        local avgHour = average(paceHistoryHour)
        local avgDay = average(paceHistoryDay)
        local avgWeek = average(paceHistoryWeek)
        averagePaceLabel.Text = string.format("Average Pace: %s / Hour | %s / Day | %s / Week", formatNumber(avgHour), formatNumber(avgDay), formatNumber(avgWeek))
        lastRebirthTime = now
        lastRebirthValue = rebirthsStat.Value
    end
end

rebirthsStat:GetPropertyChangedSignal("Value"):Connect(function()
    calculatePaceOnRebirth()
    updateRebirthsLabel()
end)

task.spawn(function()
    while true do
        updateUI(false)
        task.wait(0.1)
    end
end)

-- FAST REBIRTH V1: Swift Samurai + Tribal Overlord
local function doRebirthV1(farmPet, rebirthPet, maxPetCount)
    maxPetCount = maxPetCount or 10
    local rebirths = rebirthsStat.Value
    local strengthTarget = 5000 + (rebirths * 2550)
    equipPetsByName(farmPet, maxPetCount)
    task.wait(0.3)
    while isRunningV1 and player.leaderstats.Strength.Value < strengthTarget do
        local reps = player.MembershipType == Enum.MembershipType.Premium and 8 or 14
        for _ = 1, reps do muscleEvent:FireServer("rep") end
        task.wait(0.02)
    end
    if isRunningV1 and player.leaderstats.Strength.Value >= strengthTarget then
        equipPetsByName(rebirthPet, maxPetCount)
        task.wait(0.3)
        local before = rebirthsStat.Value
        repeat
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(0.05)
        until rebirthsStat.Value > before or not isRunningV1
    end
end

-- FAST REBIRTH V2: Omega Overloo (+20% Rep Speed) + Titanium Hydra (x2 Rebirths)
local function doRebirthV2(farmPet, rebirthPet, maxPetCount)
    maxPetCount = maxPetCount or 10
    local rebirths = rebirthsStat.Value
    -- Omega Overloo da +20% velocidad de rep, así que necesitamos menos reps
    local strengthTarget = 5000 + (rebirths * 2550)
    equipPetsByName(farmPet, maxPetCount)
    task.wait(0.3)
    while isRunningV2 and player.leaderstats.Strength.Value < strengthTarget do
        -- Con +20% rep speed, hacemos menos reps pero más rápido
        local reps = player.MembershipType == Enum.MembershipType.Premium and 6 or 11
        for _ = 1, reps do muscleEvent:FireServer("rep") end
        task.wait(0.015) -- Ligeramente más rápido
    end
    if isRunningV2 and player.leaderstats.Strength.Value >= strengthTarget then
        -- Titanium Hydra da x2 rebirths, así que el remote cuenta como 2
        equipPetsByName(rebirthPet, maxPetCount)
        task.wait(0.3)
        local before = rebirthsStat.Value
        repeat
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(0.05)
        until rebirthsStat.Value > before or not isRunningV2
    end
end

local function fastRebirthLoopV1()
    while isRunningV1 do
        doRebirthV1("Swift Samurai", "Tribal Overlord", 10)
        task.wait(0.5)
    end
end

local function fastRebirthLoopV2()
    while isRunningV2 do
        doRebirthV2("Omega Overloo", "Titanium Hydra", 10)
        task.wait(0.5)
    end
end

addFolder(rebirthTab, "⚡ FAST REBIRTH V1")
rebirthTab:AddLabel("Pets: Swift Samurai + Tribal Overlord (7-10)")
rebirthTab:AddSwitch("Fast Rebirth V1", function(state)
    if state then
        if isRunningV2 then
            isRunningV2 = false
            task.wait(0.3)
        end
        isRunningV1 = true
        startTimeReb = tick()
        task.spawn(fastRebirthLoopV1)
    else
        isRunningV1 = false
        totalElapsedReb = totalElapsedReb + (tick() - startTimeReb)
        updateUI(true)
    end
end)

addFolder(rebirthTab, "⚡ FAST REBIRTH V2 (ULTRA TITANS)")
rebirthTab:AddLabel("Pets: Omega Overloo (+20% Rep Speed) + Titanium Hydra (x2 Rebirths)")
rebirthTab:AddLabel("¡Bonus: x2 Renacimientos + Velocidad de Rep aumentada!")
rebirthTab:AddSwitch("Fast Rebirth V2", function(state)
    if state then
        if isRunningV1 then
            isRunningV1 = false
            task.wait(0.3)
        end
        isRunningV2 = true
        startTimeReb = tick()
        task.spawn(fastRebirthLoopV2)
    else
        isRunningV2 = false
        totalElapsedReb = totalElapsedReb + (tick() - startTimeReb)
        updateUI(true)
    end
end)

addFolder(rebirthTab, " QUICK EQUIP PETS")
rebirthTab:AddButton("Equip Swift Samurai (7-10)", function() equipPetsByName("Swift Samurai", 10) end)
rebirthTab:AddButton("Equip Tribal Overlord (7-10)", function() equipPetsByName("Tribal Overlord", 10) end)
rebirthTab:AddButton("Equip Omega Overloo (7-10)", function() equipPetsByName("Omega Overloo", 10) end)
rebirthTab:AddButton("Equip Titanium Hydra (7-10)", function() equipPetsByName("Titanium Hydra", 10) end)
rebirthTab:AddButton("Unequip All Pets", function() unequipAllPets() end)

addFolder(rebirthTab, "🔄 AUTO REBIRTH")
local targetRebirths = 0
local isAutoRebirthing = false

rebirthTab:AddTextBox("Set Rebirth Target", function(text)
    local val = tonumber(text)
    if val and val >= 0 then targetRebirths = val end
end, { placeholder = "0" })

rebirthTab:AddSwitch("Auto Rebirth", function(enabled)
    if enabled then
        if targetRebirths > 0 and rebirthsStat.Value < targetRebirths then
            isAutoRebirthing = true
            task.spawn(function()
                while isAutoRebirthing and rebirthsStat.Value < targetRebirths do
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    task.wait(0.05)
                end
                isAutoRebirthing = false
            end)
        end
    else
        isAutoRebirthing = false
    end
end)

addFolder(rebirthTab, "🧩 MISC")
rebirthTab:AddSwitch("Set Size 1", function(bool)
    if bool then
        task.spawn(function()
            while bool do
                changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                task.wait(0.01)
            end
        end)
    end
end)

local lockRunningReb = false
rebirthTab:AddSwitch("Lock Position", function(state)
    lockRunningReb = state
    if lockRunningReb then
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local lockPosition = hrp.Position
        task.spawn(function()
            while lockRunningReb do
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.RotVelocity = Vector3.new(0, 0, 0)
                hrp.CFrame = CFrame.new(lockPosition)
                task.wait(0.05)
            end
        end)
    end
end)

rebirthTab:AddSwitch("Auto Shake", function(state)
    if state then
        task.spawn(function()
            while state do
                activateShake()
                task.wait(450)
            end
        end)
    end
end)

rebirthTab:AddSwitch("Spin Fortune Wheel", function(bool)
    _G.AutoSpinWheel = bool
    if bool then
        task.spawn(function()
            while _G.AutoSpinWheel do
                ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer("openFortuneWheel", ReplicatedStorage:FindFirstChild("fortuneWheelChances")["Fortune Wheel"])
                task.wait(1)
            end
        end)
    end
end)

rebirthTab:AddButton("Anti Lag", function()
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") then gui:Destroy() end
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    local darkSky = Instance.new("Sky")
    darkSky.Name = "DarkSky"
    for _, side in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
        darkSky[side] = "rbxassetid://0"
    end
    darkSky.Parent = Lighting
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
    Lighting.Ambient = Color3.new(0,0,0)
    Lighting.FogColor = Color3.new(0,0,0)
    Lighting.FogEnd = 100
    task.spawn(function()
        while true do
            task.wait(5)
            if not Lighting:FindFirstChild("DarkSky") then darkSky:Clone().Parent = Lighting end
            Lighting.Brightness = 0
            Lighting.ClockTime = 0
            Lighting.OutdoorAmbient = Color3.new(0,0,0)
            Lighting.Ambient = Color3.new(0,0,0)
            Lighting.FogColor = Color3.new(0,0,0)
            Lighting.FogEnd = 100
        end
    end)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            obj:Destroy()
        end
    end
    settings().Rendering.QualityLevel = 1
end)

addFolder(miscTab, "🌍 TELEPORTS")
local function teleport(x, y, z)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end

local function teleportAndPressE(x, y, z)
    teleport(x, y, z)
    task.wait(0.2)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local miscIslandDropdown = miscTab:AddDropdown("Teleport to Island", function(selection)
    if selection == "Tiny Island" then teleport(-37.1, 9.2, 1919)
    elseif selection == "Main Island" then teleport(16.07, 9.08, 133.8)
    elseif selection == "Beach" then teleport(-8, 9, -169.2)
    elseif selection == "Industrial Gym" then teleport(-5164, 61, 4908)
    elseif selection == "Muscle King Gym" then teleport(-8665.4, 17.21, -5792.9)
    elseif selection == "Jungle Gym" then teleport(-8543, 6.8, 2400)
    elseif selection == "Legends Gym" then teleport(4516, 991.5, -3856)
    elseif selection == "Infernal Gym" then teleport(-6759, 7.36, -1284)
    elseif selection == "Mythical Gym" then teleport(2250, 7.37, 1073.2)
    elseif selection == "Frost Gym" then teleport(-2623, 7.36, -409)
    end
end)
miscIslandDropdown:Add("Tiny Island")
miscIslandDropdown:Add("Main Island")
miscIslandDropdown:Add("Beach")
miscIslandDropdown:Add("Industrial Gym")
miscIslandDropdown:Add("Muscle King Gym")
miscIslandDropdown:Add("Jungle Gym")
miscIslandDropdown:Add("Legends Gym")
miscIslandDropdown:Add("Infernal Gym")
miscIslandDropdown:Add("Mythical Gym")
miscIslandDropdown:Add("Frost Gym")

miscTab:AddButton("Jungle Lift", function() teleportAndPressE(-8642.396484375, 6.7980651855, 2086.1030273) end)
miscTab:AddButton("Jungle Squat", function() teleportAndPressE(-8371.43359375, 6.79806327, 2858.88525390) end)
miscTab:AddButton("Jungle Bar", function() teleportAndPressE(-8173, 64, 1898) end)
miscTab:AddButton("Industrial Squat", function() teleportAndPressE(-5217, 94, 5418) end)
miscTab:AddButton("Industrial Bar", function() teleportAndPressE(-5493, 88, 4644) end)

addFolder(miscTab, "🎒 INVENTORY")
local eggDevourRunning = false
miscTab:AddSwitch("Auto Eat All", function(state)
    eggDevourRunning = state
    if state then task.spawn(function() while eggDevourRunning do activateProteinEgg(); task.wait(0.25) end end) end
end):Set(false)

miscTab:AddSwitch("Auto Egg 30m", function(state)
    if state then
        task.spawn(function()
            while state do
                activateProteinEgg()
                task.wait(1800)
            end
        end)
    end
end)

miscTab:AddSwitch("Auto Egg 60m", function(state)
    if state then
        task.spawn(function()
            while state do
                activateProteinEgg()
                task.wait(3600)
            end
        end)
    end
end)

local eatEverythingRunning = false
local itemList = {"Tropical Shake", "Energy Shake", "Protein Bar", "TOUGH Bar", "Protein Shake", "ULTRA Shake", "Energy Bar"}
local function formatEventName(itemName)
    local parts = {}
    for word in itemName:gmatch("%S+") do table.insert(parts, word:lower()) end
    for i = 2, #parts do parts[i] = parts[i]:sub(1,1):upper() .. parts[i]:sub(2) end
    return table.concat(parts)
end

miscTab:AddSwitch("Eat Everything", function(state)
    eatEverythingRunning = state
    if state then task.spawn(function() while eatEverythingRunning do
        local shuffled = {}
        for _, item in ipairs(itemList) do table.insert(shuffled, item) end
        for i = #shuffled, 2, -1 do local j = math.random(i); shuffled[i], shuffled[j] = shuffled[j], shuffled[i] end
        for i = 1, math.min(4, #shuffled) do
            local tool = player.Character:FindFirstChild(shuffled[i]) or player.Backpack:FindFirstChild(shuffled[i])
            if tool then muscleEvent:FireServer(formatEventName(shuffled[i]), tool) end
        end
        task.wait(0.5)
    end end) end
end):Set(false)

addFolder(miscTab, "️ PROTECTION")
miscTab:AddSwitch("Anti Kick", function(bool)
    if getgenv().ED_AntiKick then
        getgenv().ED_AntiKick.Enabled = bool
    end
end):Set(true)

addFolder(miscTab, "🚀 OPTIMIZATION")
miscTab:AddButton("Full Optimization", function()
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") then gui:Destroy() end
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    local darkSky = Instance.new("Sky")
    darkSky.Name = "DarkSky"
    for _, side in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
        darkSky[side] = "rbxassetid://0"
    end
    darkSky.Parent = Lighting
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
    Lighting.Ambient = Color3.new(0,0,0)
    Lighting.FogColor = Color3.new(0,0,0)
    Lighting.FogEnd = 100
    task.spawn(function()
        while true do
            task.wait(5)
            if not Lighting:FindFirstChild("DarkSky") then darkSky:Clone().Parent = Lighting end
            Lighting.Brightness = 0
            Lighting.ClockTime = 0
            Lighting.OutdoorAmbient = Color3.new(0,0,0)
            Lighting.Ambient = Color3.new(0,0,0)
            Lighting.FogColor = Color3.new(0,0,0)
            Lighting.FogEnd = 100
        end
    end)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            obj:Destroy()
        end
    end
    settings().Rendering.QualityLevel = 1
end)

local c1 = creditTab:AddLabel("PAIN PRÍVATE || FARM")
local c2 = creditTab:AddLabel("PAIN PRÍVATE FARM")
local c3 = creditTab:AddLabel("BY KING")
local c4 = creditTab:AddLabel("SCRIPT OWNER")
local c5 = creditTab:AddLabel("PAIN")
local c6 = creditTab:AddLabel("VERSION 2.0")

local nuevosCreditos = {c1, c2, c3, c4, c5, c6}
task.spawn(function()
    task.wait(0.2)
    for i, objetoUI in pairs(nuevosCreditos) do
        if objetoUI then
            local textLabel = objetoUI:IsA("TextLabel") and objetoUI or objetoUI:FindFirstChildWhichIsA("TextLabel", true)
            if textLabel then
                textLabel.TextXAlignment = Enum.TextXAlignment.Center
                textLabel.FontFace = Font.new("rbxassetid://12187372382", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                if i == 1 then textLabel.TextSize = 30; textLabel.TextColor3 = Color3.fromRGB(180, 0, 0)
                elseif i == 2 then textLabel.TextSize = 26; textLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
                elseif i == 3 then textLabel.TextSize = 24; textLabel.TextColor3 = Color3.fromRGB(220, 0, 0)
                elseif i == 4 then textLabel.TextSize = 20; textLabel.TextColor3 = Color3.fromRGB(230, 0, 0)
                elseif i == 5 then textLabel.TextSize = 28; textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                elseif i == 6 then textLabel.TextSize = 18; textLabel.TextColor3 = Color3.fromRGB(150, 0, 0)
                end
            end
        end
    end
end)

task.spawn(function()
    task.wait(0.5)
    for _, tab in ipairs({mainTab, farmTab, rebirthTab, miscTab, creditTab}) do
        styleGUI(tab)
    end
end)

mainTab:Show()
