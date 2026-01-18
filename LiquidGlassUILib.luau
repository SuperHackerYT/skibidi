-- LiquidGlass UI Library - Perfect Version
local LiquidGlass = {}
LiquidGlass.__index = LiquidGlass

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local TH = {
    Txt = Color3.fromRGB(235, 235, 235),
    Ttl = Color3.fromRGB(255, 255, 255),
    Bg1 = Color3.fromRGB(18, 18, 18),
    Bg2 = Color3.fromRGB(26, 26, 26),
    St0 = Color3.fromRGB(255, 255, 255),
    Btn0 = Color3.fromRGB(22, 22, 22),
    Btn1 = Color3.fromRGB(32, 32, 32),
    Btn2 = Color3.fromRGB(16, 16, 16),
    Bad0 = Color3.fromRGB(235, 70, 70),
    Ok0 = Color3.fromRGB(0, 180, 110),
    Ok1 = Color3.fromRGB(0, 210, 130),
    Ph = Color3.fromRGB(160, 160, 160),
    Accent = Color3.fromRGB(0, 150, 255),
    Line = Color3.fromRGB(70, 70, 70),
    Prog = Color3.fromRGB(255, 255, 255)
}

local function createRoundedCorners(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 22)
    corner.Parent = frame
    return corner
end

local function addGlassEffect(frame)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, TH.Bg1),
        ColorSequenceKeypoint.new(0.5, TH.Bg2),
        ColorSequenceKeypoint.new(1, TH.Bg1)
    })
    gradient.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Thickness = 1.2
    stroke.Transparency = 0.55
    stroke.Parent = frame
    
    return {gradient = gradient, stroke = stroke}
end

local function addHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), {
            BackgroundColor3 = normalColor
        }):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.08), {
            BackgroundColor3 = TH.Btn2
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = normalColor
        }):Play()
    end)
end

local function createGlassButton(parent, text, size, pos, callback)
    local button = Instance.new("TextButton")
    button.Name = "GlassButton"
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = TH.Txt
    button.BackgroundColor3 = TH.Btn0
    button.BackgroundTransparency = 0.08
    button.Size = size
    button.Position = pos
    button.AutoButtonColor = false
    button.Parent = parent
    
    createRoundedCorners(button, 12)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.78
    stroke.Thickness = 1
    stroke.Parent = button
    
    addHoverEffect(button, TH.Btn0, TH.Btn1)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

local function loadNotifications()
    local success, notifLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/NamelessAdminNotifications.lua"))()
    end)
    if success then
        return notifLib
    end
    return nil
end

local EnhancedNotifs = loadNotifications()

function LiquidGlass:CreateWindow(title, options)
    options = options or {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LiquidGlassUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    screenGui.DisplayOrder = 999999
    screenGui.Parent = game.CoreGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Size = UDim2.new(0, options.Width or 420, 0, options.Height or 500)
    mainFrame.Position = UDim2.new(0.5, -(options.Width or 420)/2, 0.5, -(options.Height or 500)/2)
    mainFrame.BackgroundColor3 = TH.Bg1
    mainFrame.BackgroundTransparency = 0.65
    mainFrame.ZIndex = 10
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    createRoundedCorners(mainFrame, 20)
    local glassEffects = addGlassEffect(mainFrame)
    
    local topLine = Instance.new("Frame")
    topLine.Name = "TopLine"
    topLine.BorderSizePixel = 0
    topLine.BackgroundColor3 = TH.Line
    topLine.BackgroundTransparency = 0.7
    topLine.Position = UDim2.new(0, 15, 0, 40)
    topLine.Size = UDim2.new(1, -30, 0, 1)
    topLine.ZIndex = 11
    topLine.Parent = mainFrame
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundTransparency = 1
    header.ZIndex = 11
    header.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = title or "Liquid Glass UI"
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = TH.Ttl
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 12
    titleLabel.Parent = header
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(0, 80, 1, 0)
    buttonContainer.Position = UDim2.new(1, -85, 0, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.ZIndex = 12
    buttonContainer.Parent = header
    
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    buttonLayout.Padding = UDim.new(0, 8)
    buttonLayout.Parent = buttonContainer
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "Minimize"
    minimizeButton.Text = "🗕"
    minimizeButton.Font = Enum.Font.Gotham
    minimizeButton.TextSize = 16
    minimizeButton.TextColor3 = TH.Txt
    minimizeButton.Size = UDim2.new(0, 32, 0, 32)
    minimizeButton.BackgroundColor3 = TH.Btn0
    minimizeButton.BackgroundTransparency = 0.08
    minimizeButton.ZIndex = 13
    minimizeButton.Parent = buttonContainer
    
    createRoundedCorners(minimizeButton, 8)
    local minStroke = Instance.new("UIStroke")
    minStroke.Color = TH.St0
    minStroke.Transparency = 0.78
    minStroke.Thickness = 1
    minStroke.Parent = minimizeButton
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "Close"
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 20
    closeButton.TextColor3 = TH.Txt
    closeButton.Size = UDim2.new(0, 32, 0, 32)
    closeButton.BackgroundColor3 = TH.Btn0
    closeButton.BackgroundTransparency = 0.08
    closeButton.ZIndex = 13
    closeButton.Parent = buttonContainer
    
    createRoundedCorners(closeButton, 8)
    local closeStroke = Instance.new("UIStroke")
    closeStroke.Color = TH.St0
    closeStroke.Transparency = 0.78
    closeStroke.Thickness = 1
    closeStroke.Parent = closeButton
    
    closeButton.MouseEnter:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Bad0
        }):Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        TweenService:Create(closeButton, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Btn0
        }):Play()
    end)
    
    minimizeButton.MouseEnter:Connect(function()
        TweenService:Create(minimizeButton, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Accent
        }):Play()
    end)
    
    minimizeButton.MouseLeave:Connect(function()
        TweenService:Create(minimizeButton, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Btn0
        }):Play()
    end)
    
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -30, 1, -85)
    content.Position = UDim2.new(0, 15, 0, 50)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 6
    content.ScrollBarImageColor3 = TH.Accent
    content.ScrollBarImageTransparency = 0.7
    content.ZIndex = 11
    content.Parent = mainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 12)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 20)
    contentPadding.PaddingLeft = UDim.new(0, 5)
    contentPadding.PaddingRight = UDim.new(0, 5)
    contentPadding.Parent = content
    
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.CanvasSize = UDim2.new()
    
    local minimizedBall = Instance.new("Frame")
    minimizedBall.Name = "MinimizedBall"
    minimizedBall.Size = UDim2.new(0, 0, 0, 0)
    minimizedBall.Position = mainFrame.Position
    minimizedBall.BackgroundColor3 = TH.Bg1
    minimizedBall.BackgroundTransparency = 0.65
    minimizedBall.ZIndex = 10
    minimizedBall.Visible = false
    minimizedBall.Parent = screenGui
    
    createRoundedCorners(minimizedBall, 30)
    local ballGlass = addGlassEffect(minimizedBall)
    
    local ballIcon = Instance.new("TextLabel")
    ballIcon.Name = "Icon"
    ballIcon.Text = "●"
    ballIcon.Font = Enum.Font.GothamSemibold
    ballIcon.TextSize = 20
    ballIcon.TextColor3 = TH.Ttl
    ballIcon.BackgroundTransparency = 1
    ballIcon.Size = UDim2.new(1, 0, 1, 0)
    ballIcon.ZIndex = 11
    ballIcon.Parent = minimizedBall
    
    local minimized = false
    
    local function toggleMinimize()
        minimized = not minimized
        
        if minimized then
            mainFrame.Visible = false
            minimizedBall.Position = mainFrame.Position
            minimizedBall.Visible = true
            minimizedBall.Size = UDim2.new(0, 0, 0, 0)
            
            TweenService:Create(minimizedBall, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 50, 0, 50)
            }):Play()
        else
            TweenService:Create(minimizedBall, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            task.delay(0.15, function()
                minimizedBall.Visible = false
                mainFrame.Visible = true
            end)
        end
    end
    
    minimizeButton.MouseButton1Click:Connect(toggleMinimize)
    
    minimizedBall.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleMinimize()
        end
    end)
    
    local window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Content = content,
        MinimizedBall = minimizedBall,
        Minimized = minimized
    }
    
    setmetatable(window, LiquidGlass)
    
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, options.Width or 420, 0, options.Height or 500)
    }):Play()
    
    closeButton.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        
        if minimizedBall.Visible then
            TweenService:Create(minimizedBall, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
        end
        
        task.delay(0.2, function()
            screenGui:Destroy()
        end)
    end)
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        minimizedBall.Position = mainFrame.Position
    end
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    minimizedBall.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = minimizedBall.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    minimizedBall.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            minimizedBall.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return window
end

function LiquidGlass:CreateButton(text, options)
    options = options or {}
    
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ButtonContainer"
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Size = UDim2.new(1, 0, 0, options.Height or 38)
    buttonFrame.LayoutOrder = options.LayoutOrder or 1
    buttonFrame.ZIndex = self.Content.ZIndex + 1
    buttonFrame.Parent = self.Content
    
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Text = ""
    button.BackgroundColor3 = options.Color or TH.Btn0
    button.BackgroundTransparency = 0.08
    button.Size = UDim2.new(1, 0, 1, 0)
    button.AutoButtonColor = false
    button.ZIndex = buttonFrame.ZIndex + 1
    button.Parent = buttonFrame
    
    createRoundedCorners(button, 14)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.78
    stroke.Thickness = 1
    stroke.Parent = button
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ButtonText"
    textLabel.Text = text or "Button"
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextColor3 = TH.Txt
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.ZIndex = button.ZIndex + 1
    textLabel.Parent = button
    
    if options.Icon then
        local icon = Instance.new("ImageLabel")
        icon.Name = "Icon"
        icon.Image = options.Icon
        icon.Size = UDim2.new(0, 22, 0, 22)
        icon.Position = UDim2.new(0, 8, 0.5, -11)
        icon.AnchorPoint = Vector2.new(0, 0.5)
        icon.BackgroundTransparency = 1
        icon.ZIndex = button.ZIndex + 1
        icon.Parent = button
        textLabel.Position = UDim2.new(0, 38, 0, 0)
        textLabel.Size = UDim2.new(1, -46, 1, 0)
    end
    
    addHoverEffect(button, button.BackgroundColor3, options.HoverColor or TH.Btn1)
    
    button.MouseButton1Click:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, -4, 1, -4)
        }):Play()
        
        task.wait(0.1)
        
        TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        
        if options.Callback then
            options.Callback()
        end
    end)
    
    return button
end

function LiquidGlass:CreateLabel(text, options)
    options = options or {}
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or ""
    label.Font = Enum.Font.Gotham
    label.TextSize = options.TextSize or 14
    label.TextColor3 = options.Color or TH.Txt
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, options.Height or 24)
    label.TextXAlignment = options.Alignment or Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.LayoutOrder = options.LayoutOrder or 1
    label.ZIndex = self.Content.ZIndex + 1
    label.Parent = self.Content
    
    return label
end

function LiquidGlass:CreateTextBox(placeholder, options)
    options = options or {}
    
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = "TextBoxContainer"
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Size = UDim2.new(1, 0, 0, 40)
    textBoxFrame.LayoutOrder = options.LayoutOrder or 1
    textBoxFrame.ZIndex = self.Content.ZIndex + 1
    textBoxFrame.Parent = self.Content
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Text = ""
    textBox.PlaceholderText = placeholder or "Type here..."
    textBox.PlaceholderColor3 = TH.Ph
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.TextColor3 = TH.Txt
    textBox.BackgroundColor3 = TH.Btn0
    textBox.BackgroundTransparency = 0.08
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = textBoxFrame.ZIndex + 1
    textBox.Parent = textBoxFrame
    
    createRoundedCorners(textBox, 14)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.82
    stroke.Thickness = 1
    stroke.Parent = textBox
    
    textBox.Focused:Connect(function()
        TweenService:Create(textBox, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Btn1
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.12), {
            Color = TH.Accent,
            Transparency = 0.6
        }):Play()
    end)
    
    textBox.FocusLost:Connect(function()
        TweenService:Create(textBox, TweenInfo.new(0.12), {
            BackgroundColor3 = TH.Btn0
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.12), {
            Color = TH.St0,
            Transparency = 0.82
        }):Play()
        
        if options.Callback then
            options.Callback(textBox.Text)
        end
    end)
    
    return textBox
end

function LiquidGlass:CreateToggle(text, default, options)
    options = options or {}
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "ToggleContainer"
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Size = UDim2.new(1, 0, 0, 36)
    toggleFrame.LayoutOrder = options.LayoutOrder or 1
    toggleFrame.ZIndex = self.Content.ZIndex + 1
    toggleFrame.Parent = self.Content
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or "Toggle"
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = TH.Txt
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -68, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = toggleFrame.ZIndex + 1
    label.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Text = ""
    toggleButton.BackgroundColor3 = default and TH.Ok0 or TH.Btn0
    toggleButton.BackgroundTransparency = 0.08
    toggleButton.Size = UDim2.new(0, 50, 0, 28)
    toggleButton.Position = UDim2.new(1, -10, 0.5, -14)
    toggleButton.AnchorPoint = Vector2.new(1, 0.5)
    toggleButton.AutoButtonColor = false
    toggleButton.ZIndex = toggleFrame.ZIndex + 1
    toggleButton.Parent = toggleFrame
    
    createRoundedCorners(toggleButton, 14)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.78
    stroke.Thickness = 1
    stroke.Parent = toggleButton
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.BackgroundColor3 = TH.Txt
    toggleCircle.Size = UDim2.new(0, 20, 0, 20)
    toggleCircle.Position = default and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    toggleCircle.AnchorPoint = Vector2.new(default and 1 or 0, 0.5)
    toggleCircle.ZIndex = toggleButton.ZIndex + 1
    toggleCircle.Parent = toggleButton
    
    createRoundedCorners(toggleCircle, 10)
    
    local state = default or false
    
    local function toggleState()
        state = not state
        
        TweenService:Create(toggleButton, TweenInfo.new(0.15), {
            BackgroundColor3 = state and TH.Ok0 or TH.Btn0
        }):Play()
        
        TweenService:Create(toggleCircle, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            AnchorPoint = state and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
        }):Play()
        
        if options.Callback then
            options.Callback(state)
        end
    end
    
    addHoverEffect(toggleButton, toggleButton.BackgroundColor3, state and TH.Ok1 or TH.Btn1)
    
    toggleButton.MouseButton1Click:Connect(toggleState)
    
    return {
        Toggle = toggleButton,
        Label = label,
        GetState = function() return state end,
        SetState = function(newState)
            if state ~= newState then
                toggleState()
            end
        end
    }
end

function LiquidGlass:CreateSlider(text, min, max, default, options)
    options = options or {}
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderContainer"
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.LayoutOrder = options.LayoutOrder or 1
    sliderFrame.ZIndex = self.Content.ZIndex + 1
    sliderFrame.Parent = self.Content
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or "Slider"
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = TH.Txt
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -60, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = sliderFrame.ZIndex + 1
    label.Parent = sliderFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Text = tostring(default or min)
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.TextSize = 14
    valueLabel.TextColor3 = TH.Accent
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = sliderFrame.ZIndex + 1
    valueLabel.Parent = sliderFrame
    
    local track = Instance.new("Frame")
    track.Name = "Track"
    track.BackgroundColor3 = TH.Btn0
    track.BackgroundTransparency = 0.08
    track.Size = UDim2.new(1, 0, 0, 6)
    track.Position = UDim2.new(0, 0, 0, 30)
    track.ZIndex = sliderFrame.ZIndex + 1
    track.Parent = sliderFrame
    
    createRoundedCorners(track, 3)
    
    local trackStroke = Instance.new("UIStroke")
    trackStroke.Color = TH.St0
    trackStroke.Transparency = 0.78
    trackStroke.Thickness = 1
    trackStroke.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.BackgroundColor3 = TH.Accent
    fill.BackgroundTransparency = 0.12
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.ZIndex = track.ZIndex + 1
    fill.Parent = track
    
    createRoundedCorners(fill, 3)
    
    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.BackgroundColor3 = TH.Txt
    thumb.Size = UDim2.new(0, 20, 0, 20)
    thumb.Position = UDim2.new(fill.Size.X.Scale, -10, 0.5, -10)
    thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    thumb.ZIndex = fill.ZIndex + 2
    thumb.Parent = track
    
    createRoundedCorners(thumb, 10)
    
    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = TH.St0
    thumbStroke.Thickness = 1.5
    thumbStroke.Transparency = 0.3
    thumbStroke.Parent = thumb
    
    local value = default or min
    local dragging = false
    
    local function setValue(newValue)
        value = math.clamp(newValue, min, max)
        local percent = (value - min) / (max - min)
        
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, -10, 0.5, -10)
        valueLabel.Text = options.Precise and string.format("%.1f", value) or tostring(math.floor(value))
        
        if options.Callback then
            options.Callback(value)
        end
    end
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            
            local relativeX = input.Position.X - track.AbsolutePosition.X
            local percent = math.clamp(relativeX / track.AbsoluteSize.X, 0, 1)
            local newValue = min + percent * (max - min)
            
            setValue(newValue)
        end
    end)
    
    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    track.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relativeX = input.Position.X - track.AbsolutePosition.X
            local percent = math.clamp(relativeX / track.AbsoluteSize.X, 0, 1)
            local newValue = min + percent * (max - min)
            
            setValue(newValue)
        end
    end)
    
    setValue(default or min)
    
    return {
        Track = track,
        Thumb = thumb,
        GetValue = function() return value end,
        SetValue = setValue
    }
end

function LiquidGlass:CreateDropdown(text, optionsList, default, options)
    options = options or {}
    
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = "DropdownContainer"
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    dropdownFrame.LayoutOrder = options.LayoutOrder or 1
    dropdownFrame.ZIndex = self.Content.ZIndex + 1
    dropdownFrame.Parent = self.Content
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or "Dropdown"
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = TH.Txt
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = dropdownFrame.ZIndex + 1
    label.Parent = dropdownFrame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Name = "Dropdown"
    dropdown.Text = default or "Select..."
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.TextColor3 = TH.Txt
    dropdown.BackgroundColor3 = TH.Btn0
    dropdown.BackgroundTransparency = 0.08
    dropdown.Size = UDim2.new(1, 0, 0, 40)
    dropdown.Position = UDim2.new(0, 0, 0, 20)
    dropdown.AutoButtonColor = false
    dropdown.TextXAlignment = Enum.TextXAlignment.Left
    dropdown.ZIndex = dropdownFrame.ZIndex + 1
    dropdown.Parent = dropdownFrame
    
    createRoundedCorners(dropdown, 14)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.78
    stroke.Thickness = 1
    stroke.Parent = dropdown
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 14)
    padding.PaddingRight = UDim.new(0, 40)
    padding.Parent = dropdown
    
    local dropdownOpen = false
    local dropdownMenu = nil
    
    local function toggleDropdown()
        dropdownOpen = not dropdownOpen
        
        if dropdownOpen then
            dropdownMenu = Instance.new("Frame")
            dropdownMenu.Name = "DropdownMenu"
            dropdownMenu.BackgroundColor3 = TH.Bg1
            dropdownMenu.BackgroundTransparency = 0.08
            dropdownMenu.Size = UDim2.new(1, 0, 0, 0)
            dropdownMenu.AutomaticSize = Enum.AutomaticSize.Y
            dropdownMenu.Position = UDim2.new(0, 0, 1, 4)
            dropdownMenu.ZIndex = dropdown.ZIndex + 10
            dropdownMenu.ClipsDescendants = true
            dropdownMenu.Parent = dropdownFrame
            
            createRoundedCorners(dropdownMenu, 14)
            
            local menuStroke = Instance.new("UIStroke")
            menuStroke.Color = TH.St0
            menuStroke.Transparency = 0.7
            menuStroke.Thickness = 1
            menuStroke.Parent = dropdownMenu
            
            local menuLayout = Instance.new("UIListLayout")
            menuLayout.Padding = UDim.new(0, 2)
            menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
            menuLayout.Parent = dropdownMenu
            
            local menuPadding = Instance.new("UIPadding")
            menuPadding.PaddingTop = UDim.new(0, 8)
            menuPadding.PaddingBottom = UDim.new(0, 8)
            menuPadding.PaddingLeft = UDim.new(0, 8)
            menuPadding.PaddingRight = UDim.new(0, 8)
            menuPadding.Parent = dropdownMenu
            
            for i, option in ipairs(optionsList) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = "Option_" .. i
                optionButton.Text = option
                optionButton.Font = Enum.Font.Gotham
                optionButton.TextSize = 14
                optionButton.TextColor3 = TH.Txt
                optionButton.BackgroundColor3 = TH.Btn0
                optionButton.BackgroundTransparency = 0.08
                optionButton.Size = UDim2.new(1, 0, 0, 34)
                optionButton.AutoButtonColor = false
                optionButton.ZIndex = dropdownMenu.ZIndex + 1
                optionButton.Parent = dropdownMenu
                
                createRoundedCorners(optionButton, 10)
                
                local optionStroke = Instance.new("UIStroke")
                optionStroke.Color = TH.St0
                optionStroke.Transparency = 0.82
                optionStroke.Thickness = 1
                optionStroke.Parent = optionButton
                
                addHoverEffect(optionButton, TH.Btn0, TH.Btn1)
                
                optionButton.MouseButton1Click:Connect(function()
                    dropdown.Text = option
                    dropdownOpen = false
                    
                    TweenService:Create(dropdownMenu, TweenInfo.new(0.16), {
                        Size = UDim2.new(1, 0, 0, 0)
                    }):Play()
                    
                    task.delay(0.16, function()
                        if dropdownMenu then
                            dropdownMenu:Destroy()
                        end
                    end)
                    
                    if options.Callback then
                        options.Callback(option)
                    end
                end)
            end
            
            dropdownMenu.Size = UDim2.new(1, 0, 0, 0)
            TweenService:Create(dropdownMenu, TweenInfo.new(0.16), {
                Size = UDim2.new(1, 0, 0, math.min(#optionsList * 38, 200))
            }):Play()
        else
            if dropdownMenu then
                TweenService:Create(dropdownMenu, TweenInfo.new(0.16), {
                    Size = UDim2.new(1, 0, 0, 0)
                }):Play()
                
                task.delay(0.16, function()
                    if dropdownMenu then
                        dropdownMenu:Destroy()
                    end
                end)
            end
        end
    end
    
    addHoverEffect(dropdown, TH.Btn0, TH.Btn1)
    
    dropdown.MouseButton1Click:Connect(function()
        toggleDropdown()
    end)
    
    return {
        Dropdown = dropdown,
        SetOptions = function(newOptions)
            optionsList = newOptions
        end,
        SetSelected = function(text)
            dropdown.Text = text
        end
    }
end

getgenv().LiquidGlass = LiquidGlass

return LiquidGlass