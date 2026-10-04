local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local Player = Players.LocalPlayer

local MAIN_URL = "https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/SCRIPT-RAW/refs/heads/main/Main-ml.lua"
local BOSS_URL = "https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/SCRIPT-RAW/refs/heads/main/BOSS-ML-.lua"
local DISCORD_URL = "https://discord.gg/hh79adY9f2"
local HUB_TITLE = "KOD HUB"
local HUB_SUB = "Muscle Legends"

local C = {
    bg      = Color3.fromRGB(12, 12, 12),
    card    = Color3.fromRGB(22, 22, 22),
    cardHov = Color3.fromRGB(30, 30, 30),
    input   = Color3.fromRGB(18, 18, 18),
    stroke  = Color3.fromRGB(40, 40, 40),
    btn     = Color3.fromRGB(28, 28, 28),
    btnHov  = Color3.fromRGB(40, 40, 40),
    text    = Color3.fromRGB(245, 245, 245),
    muted   = Color3.fromRGB(130, 130, 130),
    accent  = Color3.fromRGB(240, 240, 240),
    success = Color3.fromRGB(120, 210, 140),
    warn    = Color3.fromRGB(240, 176, 108),
    error   = Color3.fromRGB(240, 120, 120),
    discord = Color3.fromRGB(114, 137, 218),
    glowA   = Color3.fromRGB(200, 200, 200),
    glowB   = Color3.fromRGB(30, 30, 30),
}

local IMG = {
    FONT    = "rbxassetid://12187365364",
    GLOW    = "rbxassetid://8992230677",
    LOGO    = "rbxassetid://95103720591784",
    CLOSE   = "rbxassetid://110786993356448",
    MOON    = "rbxassetid://83380517901735",
    SHADOW  = "rbxassetid://6014261993",
    KEY     = "rbxassetid://96510194465420",
    SUBMIT  = "rbxassetid://113692007244654",
    LINK    = "rbxassetid://114238209622913",
    DISCORD = "rbxassetid://127255077587058",
    GAME    = "rbxassetid://74584987850498",
}

local FONT      = Font.new(IMG.FONT, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local FONT_BOLD = Font.new(IMG.FONT, Enum.FontWeight.Bold,    Enum.FontStyle.Normal)

local FINAL_W, FINAL_H = 480, 260
local INTRO_SIZE       = 80
local INTRO_TIME       = 2.2

local function make(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local function tween(inst, time, props, style, dir)
    local t = TweenService:Create(
        inst,
        TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local function frame(parent, x, y, w, h, color, transparency)
    return make("Frame", {
        Position = UDim2.new(0, x, 0, y),
        Size = UDim2.new(0, w, 0, h),
        BackgroundColor3 = color or C.bg,
        BackgroundTransparency = transparency or 1,
        BorderSizePixel = 0,
    }, parent)
end

local function text(parent, str, x, y, w, h, size, color, align, bold)
    return make("TextLabel", {
        Position = UDim2.new(0, x, 0, y),
        Size = UDim2.new(0, w, 0, h),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = str,
        TextSize = size,
        TextColor3 = color or C.text,
        TextXAlignment = align or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        FontFace = bold and FONT_BOLD or FONT,
    }, parent)
end

local function round(parent, radius, strokeColor, strokeTransparency)
    make("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
    if strokeColor then
        make("UIStroke", {
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = strokeColor,
            Transparency = strokeTransparency or 0,
        }, parent)
    end
end

local function icon(parent, x, y, color, image, size)
    size = size or 16
    local holder = frame(parent, x, y, size, size)
    make("ImageLabel", {
        Name = "glow",
        Size = UDim2.new(1.6, 0, 1.6, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = IMG.GLOW,
        ImageColor3 = color,
        ImageTransparency = 0.9,
    }, holder)
    make("ImageLabel", {
        Name = "img",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = image,
        ImageColor3 = color,
    }, holder)
    return holder
end

local function glowDecor(parent, w, h, x, y, transparency, rotation)
    local img = make("ImageLabel", {
        Size = UDim2.new(0, w, 0, h),
        Position = UDim2.new(0, x, 0, y),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = IMG.GLOW,
        ImageColor3 = C.glowA,
        ImageTransparency = transparency,
        ScaleType = Enum.ScaleType.Stretch,
    }, parent)
    make("UIGradient", {
        Rotation = rotation,
        Color = ColorSequence.new(C.glowA, C.glowB),
    }, img)
    return img
end

local function prep(container)
    local items = {}
    local function add(inst)
        if inst:IsA("GuiObject") then
            items[#items + 1] = { inst, "BackgroundTransparency", inst.BackgroundTransparency }
            if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                items[#items + 1] = { inst, "TextTransparency", inst.TextTransparency }
            elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                items[#items + 1] = { inst, "ImageTransparency", inst.ImageTransparency }
            end
        elseif inst:IsA("UIStroke") then
            items[#items + 1] = { inst, "Transparency", inst.Transparency }
        end
    end
    add(container)
    for _, d in ipairs(container:GetDescendants()) do add(d) end
    return items
end

local function fade(items, alpha, time)
    for _, it in ipairs(items) do
        local inst, prop, orig = it[1], it[2], it[3]
        local target = 1 - (1 - orig) * alpha
        if time and time > 0 then
            tween(inst, time, { [prop] = target })
        else
            inst[prop] = target
        end
    end
end

local gui = make("ScreenGui", {
    Name = "KOD_HUB",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
}, RunService:IsStudio() and Player.PlayerGui or (gethui and gethui() or game:GetService("CoreGui")))

local main = make("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, INTRO_SIZE, 0, INTRO_SIZE),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}, gui)

local shadow = make("ImageLabel", {
    Size = UDim2.new(1, 60, 1, 60),
    Position = UDim2.new(0, -30, 0, -30),
    BackgroundTransparency = 1,
    Image = IMG.SHADOW,
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 1,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
}, main)

local canvas = make("Frame", {
    Name = "Canvas",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = C.bg,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, main)
local canvasCorner = make("UICorner", { CornerRadius = UDim.new(0, 12) }, canvas)

local borderStroke = make("UIStroke", {
    Thickness = 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = C.stroke,
    Transparency = 1,
}, canvas)

local decorGroup = make("CanvasGroup", {
    Name = "Decor",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    GroupTransparency = 1,
}, canvas)
make("UICorner", { CornerRadius = UDim.new(0, 12) }, decorGroup)

local decorBg = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, FINAL_W, 0, FINAL_H),
    BackgroundTransparency = 1,
}, decorGroup)

glowDecor(decorBg, 400, 150, 240, 270, 0.84, 270)
glowDecor(decorBg, 120, 50, -10, 250, 0.78, 90)
glowDecor(decorBg, 420, 200, 470, 10, 0.9, 90)
glowDecor(decorBg, 80, 140, 5, -5, 0.8, 90)

local intro = make("Frame", {
    Name = "Intro",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, FINAL_W, 0, FINAL_H),
    BackgroundTransparency = 1,
}, canvas)

local introLogo = make("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 62, 0, 62),
    BackgroundTransparency = 1,
    Image = IMG.LOGO,
    ImageColor3 = C.accent,
    ImageTransparency = 1,
    ScaleType = Enum.ScaleType.Fit,
}, intro)

local spinnerHolder = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 38),
    Size = UDim2.new(0, 36, 0, 36),
    BackgroundTransparency = 1,
}, intro)

local ringTrack = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 24, 0, 24),
    BackgroundTransparency = 1,
}, spinnerHolder)
make("UICorner", { CornerRadius = UDim.new(1, 0) }, ringTrack)
make("UIStroke", { Thickness = 2.5, Color = C.muted, Transparency = 0.75 }, ringTrack)

local spinner = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 24, 0, 24),
    BackgroundTransparency = 1,
}, spinnerHolder)
make("UICorner", { CornerRadius = UDim.new(1, 0) }, spinner)
local spinnerStroke = make("UIStroke", { Thickness = 2.5, Color = C.accent }, spinner)
make("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.35, 0),
        NumberSequenceKeypoint.new(0.7, 1),
        NumberSequenceKeypoint.new(1, 1),
    }),
}, spinnerStroke)

local spin = TweenService:Create(
    spinner,
    TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
    { Rotation = 360 }
)

local spinnerItems = prep(spinnerHolder)
fade(spinnerItems, 0)

local content = make("Frame", {
    Name = "Content",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, FINAL_W, 0, FINAL_H),
    BackgroundTransparency = 1,
    Visible = false,
}, canvas)

local left = frame(content, 0, 0, 272, FINAL_H)

make("ImageLabel", {
    Position = UDim2.new(0, 22, 0, 20),
    Size = UDim2.new(0, 36, 0, 32),
    BackgroundTransparency = 1,
    Image = IMG.LOGO,
    ImageColor3 = C.accent,
    ScaleType = Enum.ScaleType.Fit,
}, left)

local hubTitle = text(left, HUB_TITLE, 66, 18, 190, 24, 21, C.text, nil, true)
local hubSub   = text(left, HUB_SUB,   66, 42, 190, 14, 12, C.muted)

text(left, "Script", 22, 78, 228, 14, 11, C.muted)

local function makeScriptButton(y, label, image, isPrimary)
    local btn = make("TextButton", {
        Position = UDim2.new(0, 22, 0, y),
        Size = UDim2.new(0, 228, 0, 46),
        BackgroundColor3 = isPrimary and C.btn or C.card,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, left)
    round(btn, 9, C.stroke)

    local ic = icon(btn, 14, 15, isPrimary and C.accent or C.muted, image, 16)

    local titleLbl = text(btn, label, 40, 8, 178, 16, 13, C.text, nil, true)
    local subLbl   = text(btn, "Tap to load", 40, 24, 178, 14, 11, C.muted)

    local function setHover(on)
        tween(btn, 0.2, { BackgroundColor3 = on and C.btnHov or (isPrimary and C.btn or C.card) })
        tween(titleLbl, 0.2, { TextColor3 = on and C.accent or C.text })
    end

    btn.MouseEnter:Connect(function() setHover(true) end)
    btn.MouseLeave:Connect(function() setHover(false) end)

    btn.MouseButton1Down:Connect(function()
        tween(btn, 0.1, { Size = UDim2.new(0, 220, 0, 42), Position = UDim2.new(0, 26, 0, y + 2) })
    end)
    btn.MouseButton1Up:Connect(function()
        tween(btn, 0.15, { Size = UDim2.new(0, 228, 0, 46), Position = UDim2.new(0, 22, 0, y) }, Enum.EasingStyle.Back)
    end)

    return btn
end

local mainBtn = makeScriptButton(96,  "MAIN",         IMG.SUBMIT, true)
local bossBtn = makeScriptButton(148, "BOSS FARMING", IMG.KEY,    false)

local avatar = make("ImageLabel", {
    Position = UDim2.new(0, 22, 0, 210),
    Size = UDim2.new(0, 34, 0, 34),
    BackgroundColor3 = C.input,
    BorderSizePixel = 0,
    Image = Player and ("rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150") or "",
    ScaleType = Enum.ScaleType.Crop,
}, left)
round(avatar, 17, C.stroke)

text(left, "Welcome back,", 66, 210, 184, 14, 11, C.muted)
local welcomeName = text(left, ((Player and Player.DisplayName) or "User") .. "!", 66, 224, 184, 18, 14, C.text, nil, true)
welcomeName.TextTruncate = Enum.TextTruncate.AtEnd

frame(content, 272, 20, 1, FINAL_H - 40, C.stroke, 0)

local right = frame(content, 273, 0, 207, FINAL_H)

text(right, "Detected game", 20, 24, 167, 14, 11, C.muted)

local gameCard = frame(right, 20, 42, 167, 54, C.card, 0)
round(gameCard, 9, C.stroke)

local gameImg = make("ImageLabel", {
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(0, 34, 0, 34),
    BackgroundColor3 = C.input,
    BorderSizePixel = 0,
    Image = IMG.GAME,
    ScaleType = Enum.ScaleType.Stretch,
}, gameCard)
round(gameImg, 7, C.stroke)

local gameName = text(gameCard, "Loading...", 54, 10, 104, 15, 12, C.text, nil, true)
gameName.TextTruncate = Enum.TextTruncate.AtEnd
local gameStatus = text(gameCard, "Checking...", 54, 27, 104, 14, 11, C.muted)

text(right, "Executor", 20, 112, 80, 14, 11, C.muted)
local executorLbl = text(right, "Detecting...", 96, 112, 91, 14, 11, C.text, Enum.TextXAlignment.Right)
executorLbl.TextTruncate = Enum.TextTruncate.AtEnd

text(right, "Status", 20, 132, 80, 14, 11, C.muted)
local statusLbl = text(right, "Ready", 96, 132, 91, 14, 11, C.success, Enum.TextXAlignment.Right)

frame(right, 20, 156, 167, 1, C.stroke, 0)

local function featureRow(y, label)
    local row = frame(right, 20, y, 167, 22)
    local dot = frame(row, 0, 8, 6, 6, C.accent, 0)
    make("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
    text(row, label, 14, 0, 150, 22, 11, C.muted)
    return row
end

featureRow(164, "Auto farm boss")
featureRow(184, "Auto sell / upgrade")

local discordBtn = make("TextButton", {
    Position = UDim2.new(0, 20, 0, 210),
    Size = UDim2.new(0, 167, 0, 40),
    BackgroundColor3 = C.card,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "",
}, right)
round(discordBtn, 9, C.stroke)

icon(discordBtn, 12, 12, C.discord, IMG.DISCORD, 16)

local discordTitle = text(discordBtn, "Join our Discord", 36, 6, 122, 15, 12, C.text, nil, true)
local discordSub   = text(discordBtn, "discord.gg/hh79adY9f2", 36, 22, 122, 13, 10, C.muted)
discordSub.TextTruncate = Enum.TextTruncate.AtEnd

local closeBtn = make("TextButton", {
    Name = "CloseButton",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -12, 0, 12),
    Size = UDim2.new(0, 26, 0, 26),
    BackgroundColor3 = C.card,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "",
    ZIndex = 5,
}, content)
make("UICorner", { CornerRadius = UDim.new(0, 7) }, closeBtn)

local closeIcon = make("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 12, 0, 12),
    BackgroundTransparency = 1,
    Image = IMG.CLOSE,
    ImageColor3 = C.muted,
    ZIndex = 6,
}, closeBtn)

local contentItems = prep(content)
fade(contentItems, 0)

local notifyHolder = make("Frame", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -16, 1, -16),
    Size = UDim2.new(0, 300, 1, -32),
    BackgroundTransparency = 1,
    ZIndex = 20,
}, gui)
make("UIListLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    Padding = UDim.new(0, 8),
}, notifyHolder)

local notifIndex = 0
local function notify(title, message, kind, duration)
    duration = duration or 3.5
    kind = kind or "info"
    local color = (kind == "success" and C.success) or (kind == "warn" and C.warn) or (kind == "error" and C.error) or C.accent

    notifIndex += 1
    local wrapper = make("Frame", {
        LayoutOrder = notifIndex,
        Size = UDim2.new(0, 300, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, notifyHolder)

    local toast = make("TextButton", {
        Position = UDim2.new(0, 40, 0, 0),
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = C.card,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, wrapper)
    round(toast, 10, C.stroke)

    local bar = frame(toast, 8, 10, 3, 40, color, 0)
    round(bar, 2)

    local t = text(toast, title, 22, 11, 260, 16, 13, C.text, nil, true)
    t.TextTruncate = Enum.TextTruncate.AtEnd
    local m = text(toast, message, 22, 29, 260, 15, 11, C.muted)
    m.TextTruncate = Enum.TextTruncate.AtEnd

    local trackW = 240
    local track = frame(toast, 22, 50, trackW, 2, C.stroke, 0.4)
    round(track, 1)
    local fill = frame(track, 0, 0, trackW, 2, color, 0)
    round(fill, 1)

    local items = prep(toast)
    fade(items, 0)
    tween(wrapper, 0.3, { Size = UDim2.new(0, 300, 0, 60) }, Enum.EasingStyle.Quint)
    tween(toast, 0.4, { Position = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Quint)
    fade(items, 1, 0.3)

    local elapsed = 0
    local conn
    conn = RunService.Heartbeat:Connect(function(dt)
        elapsed += dt
        local frac = math.clamp(1 - elapsed / duration, 0, 1)
        fill.Size = UDim2.new(frac, 0, 0, 2)
        if elapsed >= duration then
            conn:Disconnect()
        end
    end)

    task.delay(duration, function()
        tween(toast, 0.3, { Position = UDim2.new(0, 40, 0, 0) }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        fade(items, 0, 0.3)
        tween(wrapper, 0.3, { Size = UDim2.new(0, 300, 0, 0) }, Enum.EasingStyle.Quint)
        task.wait(0.35)
        wrapper:Destroy()
    end)
end

local function detectExecutor()
    local ok, name = pcall(function()
        if identifyexecutor then return identifyexecutor() end
        if getexecutorname then return getexecutorname() end
    end)
    if ok and name and tostring(name) ~= "" then return tostring(name) end
    return "Unknown"
end
executorLbl.Text = detectExecutor()

task.spawn(function()
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    gameName.Text = (ok and type(info) == "table" and info.Name) or "Unknown game"
    if game.GameId ~= 0 then
        gameImg.Image = "rbxthumb://type=GameIcon&id=" .. game.GameId .. "&w=150&h=150"
    end
    gameStatus.Text = "Detected"
    gameStatus.TextColor3 = C.success
end)

local state = { ready = false, closing = false }

local function runScript(url, label)
    if state.closing then return end
    state.ready = false

    statusLbl.Text = "Loading..."
    statusLbl.TextColor3 = C.warn

    notify("Loading " .. label, "Please wait...", "info", 2)

    fade(contentItems, 0, 0.25)
    task.wait(0.25)
    content.Visible = false
    spinnerHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    spin:Play()
    fade(spinnerItems, 1, 0.3)
    task.wait(0.3)

    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)

    fade(spinnerItems, 0, 0.25)
    task.wait(0.25)
    spin:Cancel()

    if not ok or not result or #result == 0 then
        statusLbl.Text = "Failed"
        statusLbl.TextColor3 = C.error
        notify("Couldn't load", "Check your connection or the script URL.", "error", 5)
        content.Visible = true
        fade(contentItems, 1, 0.35)
        state.ready = true
        return
    end

    statusLbl.Text = "Running"
    statusLbl.TextColor3 = C.success
    notify(label .. " loaded", "Executing now.", "success", 2.5)

    task.wait(0.6)

    gui:Destroy()

    local fn, compileErr = loadstring(result)
    if not fn then
        warn("KOD HUB compile error: " .. tostring(compileErr))
        return
    end
    pcall(fn)
end

mainBtn.MouseButton1Click:Connect(function()
    if state.ready then runScript(MAIN_URL, "MAIN") end
end)
bossBtn.MouseButton1Click:Connect(function()
    if state.ready then runScript(BOSS_URL, "BOSS FARMING") end
end)

discordBtn.MouseEnter:Connect(function()
    tween(discordBtn, 0.2, { BackgroundColor3 = C.btnHov })
    tween(discordTitle, 0.2, { TextColor3 = C.discord })
end)
discordBtn.MouseLeave:Connect(function()
    tween(discordBtn, 0.2, { BackgroundColor3 = C.card })
    tween(discordTitle, 0.2, { TextColor3 = C.text })
end)
discordBtn.MouseButton1Click:Connect(function()
    local fn = setclipboard or toclipboard
    if fn then
        pcall(fn, DISCORD_URL)
        notify("Discord copied", "The invite link is in your clipboard.", "success", 3)
    else
        notify("Discord invite", DISCORD_URL, "info", 5)
    end
end)

closeBtn.MouseEnter:Connect(function()
    tween(closeBtn, 0.15, { BackgroundTransparency = 0 })
    closeIcon.ImageColor3 = C.text
end)
closeBtn.MouseLeave:Connect(function()
    tween(closeBtn, 0.15, { BackgroundTransparency = 1 })
    closeIcon.ImageColor3 = C.muted
end)

closeBtn.MouseButton1Click:Connect(function()
    if state.closing then return end
    state.closing = true
    state.ready = false

    tween(canvas, 0.3, { BackgroundTransparency = 1 })
    fade(contentItems, 0, 0.3)
    tween(decorGroup, 0.3, { GroupTransparency = 1 })
    tween(borderStroke, 0.3, { Transparency = 1 })
    tween(shadow, 0.3, { ImageTransparency = 1 })
    task.wait(0.35)
    gui:Destroy()
end)

local function snap()
    local size = gui.AbsoluteSize
    main.Position = UDim2.new(0, math.floor(size.X / 2), 0, math.floor(size.Y / 2))
end
snap()
gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(snap)

task.spawn(function()
    main.Size = UDim2.new(0, INTRO_SIZE - 20, 0, INTRO_SIZE - 20)
    tween(main, 0.6, { Size = UDim2.new(0, INTRO_SIZE, 0, INTRO_SIZE) }, Enum.EasingStyle.Quint)
    tween(canvas, 0.5, { BackgroundTransparency = 0 })
    tween(decorGroup, 0.5, { GroupTransparency = 0 })
    tween(introLogo, 0.5, { ImageTransparency = 0 })
    tween(borderStroke, 0.5, { Transparency = 0.55 })
    tween(shadow, 0.5, { ImageTransparency = 0.6 })

    task.wait(INTRO_TIME * 0.55)

    tween(borderStroke, 0.7, { Transparency = 1 })
    tween(main, 0.85, { Size = UDim2.new(0, FINAL_W, 0, FINAL_H) }, Enum.EasingStyle.Quint)
    tween(introLogo, 0.7, { Position = UDim2.new(0.5, 0, 0.5, -30) }, Enum.EasingStyle.Quint)

    task.wait(0.4)
    spin:Play()
    fade(spinnerItems, 1, 0.4)

    task.wait(INTRO_TIME * 0.45)

    fade(spinnerItems, 0, 0.3)
    tween(introLogo, 0.3, { ImageTransparency = 1 })
    task.wait(0.25)
    spin:Cancel()

    content.Visible = true
    fade(contentItems, 1, 0.45)
    task.wait(0.35)

    state.ready = true
end)

task.spawn(function()
    task.wait(0.6)
    notify(HUB_TITLE, "Welcome! Choose a script to begin.", "info", 4)
end)
