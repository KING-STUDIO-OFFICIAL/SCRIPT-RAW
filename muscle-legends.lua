local LoaderSystem = {}
LoaderSystem.__index = LoaderSystem

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function Create(className, properties, parent)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    if parent then
        instance.Parent = parent
    end
    return instance
end

function LoaderSystem:CreateLoader(Config)
    local Title = "KOD HUB"
    local BossFarmingURL = Config.BossFarmingURL or "https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/SCRIPT-RAW/refs/heads/main/BOSS-ML-.lua"
    local MainScriptURL = Config.MainScriptURL or "https://raw.githubusercontent.com/KING-STUDIO-OFFICIAL/SCRIPT-RAW/refs/heads/main/Main-ml.lua"

    local Black       = Color3.fromRGB(10, 10, 10)
    local DarkBlack   = Color3.fromRGB(0, 0, 0)
    local Red         = Color3.fromRGB(220, 20, 20)
    local DarkRed     = Color3.fromRGB(140, 10, 10)
    local Orange      = Color3.fromRGB(255, 120, 0)
    local DeepOrange  = Color3.fromRGB(200, 80, 0)
    local NeonOrange  = Color3.fromRGB(255, 170, 40)

    local LoaderGui = Create("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Name = "LoaderGui"
    }, RunService:IsStudio() and Player.PlayerGui or 
       (gethui and gethui() or game:GetService("CoreGui")))

    local BlurBackground = Create("Frame", {
        BackgroundColor3 = DarkBlack,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Name = "BlurBackground"
    }, LoaderGui)

    local BackgroundGradient = Create("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(30, 0, 0)),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(15, 0, 0)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(40, 10, 0)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 0, 0))
        },
        Rotation = 45
    }, BlurBackground)

    local bgGradientTween = TweenService:Create(
        BackgroundGradient,
        TweenInfo.new(8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 225}
    )
    bgGradientTween:Play()

    for i = 1, 30 do
        local particleSize = math.random(1, 7)
        local particle = Create("Frame", {
            BackgroundColor3 = i <= 15 and Red or (i <= 22 and NeonOrange or Orange),
            BackgroundTransparency = math.random(70, 90) / 100,
            BorderSizePixel = 0,
            Size = UDim2.new(0, particleSize, 0, particleSize),
            Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0),
            Name = "Particle" .. i
        }, BlurBackground)

        Create("UICorner", {CornerRadius = UDim.new(1, 0)}, particle)

        if i <= 12 then
            local particleGlow = Create("Frame", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(1, 4, 1, 4),
                BackgroundColor3 = particle.BackgroundColor3,
                BackgroundTransparency = 0.9,
                BorderSizePixel = 0,
                ZIndex = particle.ZIndex - 1
            }, particle)
            Create("UICorner", {CornerRadius = UDim.new(1, 0)}, particleGlow)

            local glowTween = TweenService:Create(
                particleGlow,
                TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundTransparency = 0.95, Size = UDim2.new(1, 8, 1, 8)}
            )
            glowTween:Play()
        end

        local floatSpeed = math.random(8, 30)
        local floatTween = TweenService:Create(
            particle,
            TweenInfo.new(floatSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {
                Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0),
                BackgroundTransparency = math.random(40, 95) / 100,
                Rotation = math.random(-180, 180)
            }
        )
        floatTween:Play()
    end

    local LoaderContainer = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Black,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 340, 0, 220),
        Name = "LoaderContainer"
    }, BlurBackground)

    Create("UICorner", {CornerRadius = UDim.new(0, 18)}, LoaderContainer)

    local BorderStroke = Create("UIStroke", {
        Color = Red,
        Thickness = 2.5,
        Transparency = 0.2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }, LoaderContainer)

    local BorderGradient = Create("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.0, Red),
            ColorSequenceKeypoint.new(0.5, NeonOrange),
            ColorSequenceKeypoint.new(1.0, DeepOrange)
        },
        Rotation = 0
    }, BorderStroke)

    local borderTween = TweenService:Create(
        BorderGradient,
        TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
        {Rotation = 360}
    )
    borderTween:Play()

    for i = 1, 3 do
        local glowSize = 8 + (i * 4)
        local GlowFrame = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, glowSize, 1, glowSize),
            BackgroundColor3 = i == 1 and Red or (i == 2 and NeonOrange or Orange),
            BackgroundTransparency = 0.8 + (i * 0.05),
            BorderSizePixel = 0,
            ZIndex = LoaderContainer.ZIndex - i
        }, BlurBackground)

        Create("UICorner", {CornerRadius = UDim.new(0, 22 + (i * 2))}, GlowFrame)

        local glowTween = TweenService:Create(
            GlowFrame,
            TweenInfo.new(2 + i, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {
                BackgroundTransparency = 0.95,
                Size = UDim2.new(1, glowSize + 8, 1, glowSize + 8)
            }
        )
        glowTween:Play()
    end

    local CloseButton = Create("TextButton", {
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 22,
        BackgroundColor3 = Red,
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -35, 0, 8),
        Size = UDim2.new(0, 28, 0, 28),
        Name = "CloseButton"
    }, LoaderContainer)

    Create("UICorner", {CornerRadius = UDim.new(0, 8)}, CloseButton)

    local CloseButtonGlow = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 6, 1, 6),
        BackgroundColor3 = Red,
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
        ZIndex = CloseButton.ZIndex - 1
    }, CloseButton)
    Create("UICorner", {CornerRadius = UDim.new(0, 12)}, CloseButtonGlow)

    local closeGlowTween = TweenService:Create(
        CloseButtonGlow,
        TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {BackgroundTransparency = 0.6, Size = UDim2.new(1, 10, 1, 10)}
    )
    closeGlowTween:Play()

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            BackgroundColor3 = NeonOrange,
            Rotation = 90,
            Size = UDim2.new(0, 32, 0, 32)
        }):Play()
    end)

    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            BackgroundColor3 = Red,
            Rotation = 0,
            Size = UDim2.new(0, 28, 0, 28)
        }):Play()
    end)

    local TitleLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 32,
        TextStrokeColor3 = Red,
        TextStrokeTransparency = 0.3,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 35),
        Size = UDim2.new(0, 300, 0, 40),
        TextXAlignment = Enum.TextXAlignment.Center,
        Name = "TitleLabel"
    }, LoaderContainer)

    local TitleGradient = Create("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 60, 0)),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 110, 0)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 150, 20)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 200, 60))
        },
        Rotation = 45
    }, TitleLabel)

    local TitleShadow = Create("TextLabel", {
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 32,
        TextTransparency = 0.7,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 2, 0, 37),
        Size = UDim2.new(0, 300, 0, 40),
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = TitleLabel.ZIndex - 1,
        Name = "TitleShadow"
    }, LoaderContainer)

    for i = 1, 3 do
        local TitleGlow = Create("Frame", {
            BackgroundColor3 = i == 1 and Red or (i == 2 and NeonOrange or Orange),
            BackgroundTransparency = 0.85 + (i * 0.03),
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0, 35),
            Size = UDim2.new(0, 180 + (i * 20), 0, 35 + (i * 5)),
            ZIndex = TitleLabel.ZIndex - (i + 1),
            Name = "TitleGlow" .. i
        }, LoaderContainer)

        Create("UICorner", {CornerRadius = UDim.new(0, 15 + i)}, TitleGlow)

        local titleGlowTween = TweenService:Create(
            TitleGlow,
            TweenInfo.new(1.5 + i, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {
                BackgroundTransparency = 0.7 + (i * 0.05),
                Size = UDim2.new(0, 200 + (i * 25), 0, 40 + (i * 8))
            }
        )
        titleGlowTween:Play()
    end

    local gradientTween = TweenService:Create(
        TitleGradient,
        TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
        {Rotation = 405}
    )
    gradientTween:Play()

    local function animateTitle()
        local cursorChar = "|"
        local blinkCursor = true

        local function blinkCursorAnimation()
            while LoaderGui.Parent and blinkCursor do
                TitleLabel.Text = TitleLabel.Text:gsub("|", "") .. cursorChar
                TitleShadow.Text = TitleLabel.Text
                wait(0.5)
                if blinkCursor then
                    TitleLabel.Text = TitleLabel.Text:gsub("|", "")
                    TitleShadow.Text = TitleLabel.Text
                    wait(0.5)
                end
            end
        end

        while LoaderGui.Parent do
            blinkCursor = false

            for i = 1, #Title do
                if not LoaderGui.Parent then break end

                local currentText = string.sub(Title, 1, i)
                TitleLabel.Text = currentText
                TitleShadow.Text = currentText

                TitleLabel.TextSize = 40
                TitleShadow.TextSize = 40
                TweenService:Create(TitleLabel, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 32}):Play()
                TweenService:Create(TitleShadow, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 32}):Play()

                local flashColors = {
                    Color3.fromRGB(255, 255, 255),
                    Color3.fromRGB(255, 180, 120),
                    Color3.fromRGB(255, 120, 0)
                }
                local originalColor = TitleLabel.TextStrokeColor3
                TitleLabel.TextStrokeColor3 = flashColors[math.random(1, 3)]
                TweenService:Create(TitleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextStrokeColor3 = originalColor}):Play()

                TweenService:Create(BorderStroke, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Color = NeonOrange, Transparency = 0.1}):Play()
                TweenService:Create(BorderStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Color = Red, Transparency = 0.2}):Play()

                wait(0.1)
            end

            blinkCursor = true
            spawn(blinkCursorAnimation)
            wait(3)
            blinkCursor = false

            for i = #Title, 0, -1 do
                if not LoaderGui.Parent then break end

                local currentText = string.sub(Title, 1, i)
                TitleLabel.Text = currentText
                TitleShadow.Text = currentText

                TitleLabel.TextSize = 34
                TitleShadow.TextSize = 34
                TweenService:Create(TitleLabel, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextSize = 32}):Play()
                TweenService:Create(TitleShadow, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextSize = 32}):Play()

                TweenService:Create(TitleLabel, TweenInfo.new(0.04, Enum.EasingStyle.Quad), {TextTransparency = 0.5}):Play()
                TweenService:Create(TitleLabel, TweenInfo.new(0.04, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

                wait(0.05)
            end

            wait(1)
        end
    end

    spawn(animateTitle)

    spawn(function()
        while LoaderGui.Parent do
            wait(2)
            if not LoaderGui.Parent then break end
            local origPos = TitleLabel.Position
            TweenService:Create(TitleLabel, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = origPos + UDim2.new(0, math.random(-3, 3), 0, math.random(-3, 3))
            }):Play()
            TweenService:Create(TitleShadow, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = origPos + UDim2.new(0, 2 + math.random(-3, 3), 0, 2 + math.random(-3, 3))
            }):Play()
            wait(0.15)
            TweenService:Create(TitleLabel, TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = origPos
            }):Play()
            TweenService:Create(TitleShadow, TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Position = origPos + UDim2.new(0, 2, 0, 2)
            }):Play()
        end
    end)

    for i = 1, 25 do
        local sparkleType = i <= 10 and 1 or (i <= 18 and 2 or 3)
        local sparkleSize = sparkleType == 1 and 2 or (sparkleType == 2 and 3 or 1)
        local sparkleColor = sparkleType == 1 and Color3.fromRGB(255, 220, 180) or 
                            (sparkleType == 2 and NeonOrange or Orange)

        local sparkle = Create("Frame", {
            BackgroundColor3 = sparkleColor,
            BackgroundTransparency = 0.6,
            BorderSizePixel = 0,
            Size = UDim2.new(0, sparkleSize, 0, sparkleSize),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, math.random(-120, 120), 0, 35 + math.random(-30, 30)),
            ZIndex = TitleLabel.ZIndex + 1,
            Name = "Sparkle" .. i
        }, LoaderContainer)

        if sparkleType == 3 then
            Create("UICorner", {CornerRadius = UDim.new(0, 1)}, sparkle)
        else
            Create("UICorner", {CornerRadius = UDim.new(1, 0)}, sparkle)
        end

        local sparkleSpeed = math.random(10, 40) / 10
        local sparkleTween = TweenService:Create(
            sparkle,
            TweenInfo.new(sparkleSpeed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {
                BackgroundTransparency = 0.2,
                Size = UDim2.new(0, sparkleSize + 2, 0, sparkleSize + 2),
                Position = UDim2.new(0.5, math.random(-140, 140), 0, 35 + math.random(-35, 35)),
                Rotation = math.random(-360, 360)
            }
        )
        sparkleTween:Play()
    end

    local scanLine = Create("Frame", {
        BackgroundColor3 = NeonOrange,
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 0, 2),
        Position = UDim2.new(0, 10, 0, 0),
        ZIndex = TitleLabel.ZIndex + 2,
        Name = "ScanLine"
    }, LoaderContainer)

    Create("UICorner", {CornerRadius = UDim.new(1, 0)}, scanLine)

    spawn(function()
        while LoaderGui.Parent do
            scanLine.Position = UDim2.new(0, 10, 0, 0)
            scanLine.BackgroundTransparency = 0.85
            TweenService:Create(scanLine, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0, 10, 1, -2),
                BackgroundTransparency = 0.6
            }):Play()
            wait(2.5)
        end
    end)

    local ButtonsFrame = Create("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 90),
        Size = UDim2.new(1, -40, 0, 120),
        Name = "ButtonsFrame"
    }, LoaderContainer)

    local function createEnhancedButton(properties, parent)
        local button = Create("TextButton", properties, parent)
        Create("UICorner", {CornerRadius = UDim.new(0, 10)}, button)

        local buttonStroke = Create("UIStroke", {
            Color = NeonOrange,
            Thickness = 1.5,
            Transparency = 0.4
        }, button)

        local buttonGlow = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 4, 1, 4),
            BackgroundColor3 = properties.BackgroundColor3,
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
            ZIndex = button.ZIndex - 1
        }, button)
        Create("UICorner", {CornerRadius = UDim.new(0, 12)}, buttonGlow)

        spawn(function()
            while LoaderGui.Parent and button.Parent do
                TweenService:Create(buttonStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Color = Red, Transparency = 0.7
                }):Play()
                wait(1.5)
                if not (LoaderGui.Parent and button.Parent) then break end
                TweenService:Create(buttonStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Color = NeonOrange, Transparency = 0.4
                }):Play()
                wait(1.5)
            end
        end)

        return button, buttonGlow
    end

    local BossFarmingButton, BossFarmingGlow = createEnhancedButton({
        Font = Enum.Font.FredokaOne,
        Text = "BOSS FARMING",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        BackgroundColor3 = Red,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50),
        Name = "BossFarmingButton"
    }, ButtonsFrame)

    local MainScriptButton, MainScriptGlow = createEnhancedButton({
        Font = Enum.Font.FredokaOne,
        Text = "MAIN",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        BackgroundColor3 = DeepOrange,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(1, 0, 0, 50),
        Name = "MainScriptButton"
    }, ButtonsFrame)

    local function addEnhancedHoverEffect(button, buttonGlow, hoverColor, originalColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                BackgroundColor3 = hoverColor,
                Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 6, button.Size.Y.Scale, button.Size.Y.Offset + 3),
                TextSize = button.TextSize + 1,
                Rotation = math.random(-2, 2)
            }):Play()
            TweenService:Create(buttonGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0.7,
                Size = UDim2.new(1, 8, 1, 8)
            }):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = originalColor,
                Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 6, button.Size.Y.Scale, button.Size.Y.Offset - 3),
                TextSize = button.TextSize - 1,
                Rotation = 0
            }):Play()
            TweenService:Create(buttonGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0.9,
                Size = UDim2.new(1, 4, 1, 4)
            }):Play()
        end)

        button.MouseButton1Down:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {
                Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 8, button.Size.Y.Scale, button.Size.Y.Offset - 6)
            }):Play()
        end)

        button.MouseButton1Up:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 2, button.Size.Y.Scale, button.Size.Y.Offset)
            }):Play()
        end)
    end

    addEnhancedHoverEffect(BossFarmingButton, BossFarmingGlow, NeonOrange, Red)
    addEnhancedHoverEffect(MainScriptButton, MainScriptGlow, NeonOrange, DeepOrange)

    BossFarmingButton.Activated:Connect(function()
        script = Instance.new("LocalScript")
        script.Name = "KODRuntime"
        LoaderGui:Destroy()
        loadstring(game:HttpGet(BossFarmingURL))()
    end)

    MainScriptButton.Activated:Connect(function()
        script = Instance.new("LocalScript")
        script.Name = "KODRuntime"
        LoaderGui:Destroy()
        loadstring(game:HttpGet(MainScriptURL))()
    end)

    CloseButton.Activated:Connect(function()
        TweenService:Create(LoaderContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Rotation = 180
        }):Play()
        TweenService:Create(BlurBackground, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
        wait(0.6)
        LoaderGui:Destroy()
    end)

    LoaderContainer.Size = UDim2.new(0, 0, 0, 0)
    LoaderContainer.BackgroundTransparency = 1
    LoaderContainer.Rotation = -180

    TweenService:Create(LoaderContainer, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 340, 0, 220),
        BackgroundTransparency = 0,
        Rotation = 0
    }):Play()

    local elements = {TitleLabel, ButtonsFrame}
    for i, element in pairs(elements) do
        element.Position = element.Position + UDim2.new(0, 0, 0, 50)
        element.Rotation = math.random(-45, 45)

        TweenService:Create(element, TweenInfo.new(0.8 + (i * 0.1), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = element.Position - UDim2.new(0, 0, 0, 50),
            Rotation = 0
        }):Play()
    end

    return LoaderGui
end

LoaderSystem:CreateLoader({})

return LoaderSystem
