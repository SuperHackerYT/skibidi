local LiquidGlass = {}
LiquidGlass.__index = LiquidGlass

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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
    Ph = Color3.fromRGB(160, 160, 160),
    Accent = Color3.fromRGB(0, 150, 255)
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
    mainFrame.Size = UDim2.new(0, options.Width or 500, 0, options.Height or 550)
    mainFrame.Position = UDim2.new(0.5, -(options.Width or 500)/2, 0.5, -(options.Height or 550)/2)
    mainFrame.BackgroundColor3 = TH.Bg1
    mainFrame.BackgroundTransparency = 0.65
    mainFrame.ZIndex = 10
    mainFrame.Parent = screenGui
    
    createRoundedCorners(mainFrame, 24)
    local glassEffects = addGlassEffect(mainFrame)
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundTransparency = 1
    header.ZIndex = 11
    header.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = title or "Liquid Glass UI"
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.TextSize = 22
    titleLabel.TextColor3 = TH.Ttl
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -120, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 12
    titleLabel.Parent = header
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "Close"
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 26
    closeButton.TextColor3 = TH.Txt
    closeButton.Size = UDim2.new(0, 36, 0, 36)
    closeButton.Position = UDim2.new(1, -48, 0.5, -18)
    closeButton.AnchorPoint = Vector2.new(0, 0.5)
    closeButton.BackgroundColor3 = TH.Btn0
    closeButton.BackgroundTransparency = 0.06
    closeButton.ZIndex = 12
    closeButton.Parent = header
    
    createRoundedCorners(closeButton, 12)
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
    
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -40, 1, -90)
    content.Position = UDim2.new(0, 20, 0, 70)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 6
    content.ZIndex = 11
    content.Parent = mainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 14)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 20)
    contentPadding.Parent = content
    
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.CanvasSize = UDim2.new()
    
    local window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Content = content,
        CloseButton = closeButton
    }
    
    setmetatable(window, LiquidGlass)
    
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, options.Width or 500, 0, options.Height or 550)
    }):Play()
    
    closeButton.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(glassEffects.stroke, TweenInfo.new(0.2), {
            Transparency = 1
        }):Play()
        
        task.delay(0.2, function()
            screenGui:Destroy()
        end)
    end)
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    return window
end

function LiquidGlass:CreateButton(text, options)
    options = options or {}
    
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ButtonContainer"
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Size = UDim2.new(1, 0, 0, options.Height or 40)
    buttonFrame.LayoutOrder = options.LayoutOrder or 1
    buttonFrame.ZIndex = self.Content.ZIndex + 1
    buttonFrame.Parent = self.Content
    
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Text = ""
    button.BackgroundColor3 = options.Color or TH.Btn0
    button.BackgroundTransparency = 0.06
    button.Size = UDim2.new(1, 0, 1, 0)
    button.AutoButtonColor = false
    button.ZIndex = buttonFrame.ZIndex + 1
    button.Parent = buttonFrame
    
    createRoundedCorners(button, 16)
    
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
    textLabel.Size = UDim2.new(1, -24, 1, 0)
    textLabel.Position = UDim2.new(0, 12, 0, 0)
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
    textBoxFrame.Size = UDim2.new(1, 0, 0, 44)
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
    textBox.BackgroundTransparency = 0.06
    textBox.Size = UDim2.new(1, 0, 1, 0)
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = textBoxFrame.ZIndex + 1
    textBox.Parent = textBoxFrame
    
    createRoundedCorners(textBox, 16)
    
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
    
    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Text = ""
    toggle.BackgroundColor3 = default and TH.Ok0 or TH.Btn0
    toggle.BackgroundTransparency = 0.08
    toggle.Size = UDim2.new(0, 50, 0, 28)
    toggle.Position = UDim2.new(1, -10, 0.5, -14)
    toggle.AnchorPoint = Vector2.new(1, 0.5)
    toggle.AutoButtonColor = false
    toggle.ZIndex = toggleFrame.ZIndex + 1
    toggle.Parent = toggleFrame
    
    createRoundedCorners(toggle, 14)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = TH.St0
    stroke.Transparency = 0.78
    stroke.Thickness = 1
    stroke.Parent = toggle
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.BackgroundColor3 = TH.Txt
    toggleCircle.Size = UDim2.new(0, 20, 0, 20)
    toggleCircle.Position = default and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    toggleCircle.AnchorPoint = Vector2.new(default and 1 or 0, 0.5)
    toggleCircle.ZIndex = toggle.ZIndex + 1
    toggleCircle.Parent = toggle
    
    createRoundedCorners(toggleCircle, 10)
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Text = text or "Toggle"
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = TH.Txt
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = toggleFrame.ZIndex + 1
    label.Parent = toggleFrame
    
    local state = default or false
    
    local function toggleState()
        state = not state
        
        TweenService:Create(toggle, TweenInfo.new(0.15), {
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
    
    toggle.MouseButton1Click:Connect(toggleState)
    label.MouseButton1Click:Connect(toggleState)
    
    return {
        Toggle = toggle,
        Label = label,
        GetState = function() return state end,
        SetState = function(newState)
            if state ~= newState then
                toggleState()
            end
        end
    }
end

function LiquidGlass.Notify(options)
    options = options or {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LiquidGlassNotification"
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    screenGui.DisplayOrder = 999999
    screenGui.Parent = game.CoreGui
    
    local dock = options.Dock or "BottomRight"
    local position
    
    if dock == "TopRight" then
        position = UDim2.new(1, -340, 0, 20)
    elseif dock == "TopLeft" then
        position = UDim2.new(0, 20, 0, 20)
    elseif dock == "BottomLeft" then
        position = UDim2.new(0, 20, 1, -120)
    else
        position = UDim2.new(1, -340, 1, -120)
    end
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 320, 0, 0)
    notification.Position = position
    notification.BackgroundColor3 = TH.Bg1
    notification.BackgroundTransparency = 0.65
    notification.ZIndex = 100
    notification.Parent = screenGui
    
    createRoundedCorners(notification, 20)
    local glassEffects = addGlassEffect(notification)
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -24, 1, -24)
    content.Position = UDim2.new(0, 12, 0, 12)
    content.BackgroundTransparency = 1
    content.ZIndex = notification.ZIndex + 1
    content.Parent = notification
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = content
    
    local contentHeight = 24
    
    if options.Title then
        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Text = options.Title
        title.Font = Enum.Font.GothamSemibold
        title.TextSize = 18
        title.TextColor3 = TH.Ttl
        title.BackgroundTransparency = 1
        title.Size = UDim2.new(1, 0, 0, 24)
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.ZIndex = content.ZIndex + 1
        title.Parent = content
        contentHeight = contentHeight + 24
    end
    
    if options.Description then
        local desc = Instance.new("TextLabel")
        desc.Name = "Description"
        desc.Text = options.Description
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 14
        desc.TextColor3 = TH.Txt
        desc.BackgroundTransparency = 1
        desc.Size = UDim2.new(1, 0, 0, 0)
        desc.AutomaticSize = Enum.AutomaticSize.Y
        desc.TextWrapped = true
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.ZIndex = content.ZIndex + 1
        desc.Parent = content
        
        task.wait(0.05)
        contentHeight = contentHeight + desc.AbsoluteSize.Y
    end
    
    if options.Buttons then
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Name = "Buttons"
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.Size = UDim2.new(1, 0, 0, 38)
        buttonFrame.LayoutOrder = 10
        buttonFrame.ZIndex = content.ZIndex + 1
        buttonFrame.Parent = content
        contentHeight = contentHeight + 38
        
        local buttonLayout = Instance.new("UIListLayout")
        buttonLayout.FillDirection = Enum.FillDirection.Horizontal
        buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        buttonLayout.Padding = UDim.new(0, 8)
        buttonLayout.Parent = buttonFrame
        
        for i, btnInfo in ipairs(options.Buttons) do
            local btnFrame = Instance.new("Frame")
            btnFrame.Name = "BtnContainer"
            btnFrame.BackgroundTransparency = 1
            btnFrame.Size = UDim2.new(0, 80, 0, 30)
            btnFrame.ZIndex = buttonFrame.ZIndex + 1
            btnFrame.Parent = buttonFrame
            
            local btn = Instance.new("TextButton")
            btn.Name = "Button"
            btn.Text = btnInfo.Text or "Button"
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 13
            btn.TextColor3 = TH.Txt
            btn.BackgroundColor3 = btnInfo.Color or TH.Btn0
            btn.BackgroundTransparency = 0.08
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.AutoButtonColor = false
            btn.ZIndex = btnFrame.ZIndex + 1
            btn.Parent = btnFrame
            
            createRoundedCorners(btn, 12)
            
            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = TH.St0
            btnStroke.Transparency = 0.78
            btnStroke.Thickness = 1
            btnStroke.Parent = btn
            
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.12), {
                    BackgroundColor3 = btnInfo.HoverColor or TH.Btn1
                }):Play()
            end)
            
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.12), {
                    BackgroundColor3 = btnInfo.Color or TH.Btn0
                }):Play()
            end)
            
            btn.MouseButton1Click:Connect(function()
                if btnInfo.Callback then
                    btnInfo.Callback()
                end
            end)
        end
    end
    
    contentHeight = contentHeight + 48
    
    TweenService:Create(notification, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, contentHeight)
    }):Play()
    
    local duration = options.Duration or 3
    if duration > 0 then
        task.delay(duration, function()
            TweenService:Create(notification, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            
            task.delay(0.2, function()
                screenGui:Destroy()
            end)
        end)
    end
    
    return {
        Notification = notification,
        Close = function()
            TweenService:Create(notification, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            
            task.delay(0.2, function()
                screenGui:Destroy()
            end)
        end
    }
end

function LiquidGlass.QuickNotify(title, desc, duration)
    return LiquidGlass.Notify({
        Title = title,
        Description = desc,
        Duration = duration or 3
    })
end

getgenv().LiquidGlass = LiquidGlass
return LiquidGlass