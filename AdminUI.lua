local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local AdminGUI = Instance.new("ScreenGui")
AdminGUI.Name = "AdminGlassBar"
AdminGUI.ResetOnSpawn = false
AdminGUI.DisplayOrder = 999

local MainFrame = Instance.new("Frame")
MainFrame.Name = "GlassFrame"
MainFrame.Size = UDim2.new(0.35, 0, 0, 400)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 20)
Corner.Parent = MainFrame

local GlassBorder = Instance.new("UIStroke")
GlassBorder.Color = Color3.fromRGB(255, 255, 255)
GlassBorder.Transparency = 0.8
GlassBorder.Thickness = 2
GlassBorder.Parent = MainFrame

local GlassEffect = Instance.new("Frame")
GlassEffect.Size = UDim2.new(1, 0, 1, 0)
GlassEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlassEffect.BackgroundTransparency = 0.95
GlassEffect.BorderSizePixel = 0

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 150))
}
UIGradient.Transparency = NumberSequence.new(0.85)
UIGradient.Rotation = 120
UIGradient.Parent = GlassEffect

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.BackgroundTransparency = 0.4
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 20)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ADMIN COMMAND BAR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.BackgroundTransparency = 0.3
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

local CloseGlow = Instance.new("UIStroke")
CloseGlow.Color = Color3.fromRGB(255, 150, 150)
CloseGlow.Transparency = 0.5
CloseGlow.Thickness = 2
CloseGlow.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
MinimizeButton.BackgroundTransparency = 0.3
MinimizeButton.Text = "–"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

local MinimizeGlow = Instance.new("UIStroke")
MinimizeGlow.Color = Color3.fromRGB(255, 220, 100)
MinimizeGlow.Transparency = 0.5
MinimizeGlow.Thickness = 2
MinimizeGlow.Parent = MinimizeButton

local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, -30, 0, 50)
InputContainer.Position = UDim2.new(0, 15, 0, 55)
InputContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
InputContainer.BackgroundTransparency = 0.4
InputContainer.BorderSizePixel = 0

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 15)
InputCorner.Parent = InputContainer

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -20, 1, -20)
InputBox.Position = UDim2.new(0, 10, 0, 10)
InputBox.BackgroundTransparency = 1
InputBox.Text = ""
InputBox.PlaceholderText = "Type command here..."
InputBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 220)
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 16
InputBox.Font = Enum.Font.Gotham
InputBox.ClearTextOnFocus = false

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0.4, 0, 0, 45)
ExecuteButton.Position = UDim2.new(0.3, 0, 0, 120)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ExecuteButton.BackgroundTransparency = 0.2
ExecuteButton.Text = "EXECUTE"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 18
ExecuteButton.Font = Enum.Font.GothamBold

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 12)
ExecuteCorner.Parent = ExecuteButton

local ExecuteGlow = Instance.new("UIStroke")
ExecuteGlow.Color = Color3.fromRGB(120, 160, 255)
ExecuteGlow.Transparency = 0.4
ExecuteGlow.Thickness = 2
ExecuteGlow.Parent = ExecuteButton

local OutputContainer = Instance.new("Frame")
OutputContainer.Size = UDim2.new(1, -30, 0, 200)
OutputContainer.Position = UDim2.new(0, 15, 0, 180)
OutputContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
OutputContainer.BackgroundTransparency = 0.5
OutputContainer.BorderSizePixel = 0

local OutputCorner = Instance.new("UICorner")
OutputCorner.CornerRadius = UDim.new(0, 15)
OutputCorner.Parent = OutputContainer

local OutputBox = Instance.new("TextLabel")
OutputBox.Size = UDim2.new(1, -20, 1, -20)
OutputBox.Position = UDim2.new(0, 10, 0, 10)
OutputBox.BackgroundTransparency = 1
OutputBox.Text = "Welcome to Sky Admin\nType commands and click EXECUTE"
OutputBox.TextColor3 = Color3.fromRGB(220, 220, 255)
OutputBox.TextSize = 14
OutputBox.Font = Enum.Font.Gotham
OutputBox.TextXAlignment = Enum.TextXAlignment.Left
OutputBox.TextYAlignment = Enum.TextYAlignment.Top
OutputBox.TextWrapped = true

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(1, -70, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ToggleButton.BackgroundTransparency = 0.3


local isOpenImage = "rbxassetid://82795327169782"

local isClosedImage = "rbxassetid://82795327169782"


ToggleButton.Image = isOpenImage  


local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleGlow = Instance.new("UIStroke")
ToggleGlow.Color = Color3.fromRGB(120, 160, 255)
ToggleGlow.Transparency = 0.5
ToggleGlow.Thickness = 2
ToggleGlow.Parent = ToggleButton

ToggleButton.ScaleType = Enum.ScaleType.Fit  
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 80, 180)  

GlassEffect.Parent = MainFrame
TopBar.Parent = MainFrame
Title.Parent = TopBar
CloseButton.Parent = TopBar
MinimizeButton.Parent = TopBar
InputContainer.Parent = MainFrame
InputBox.Parent = InputContainer
ExecuteButton.Parent = MainFrame
OutputContainer.Parent = MainFrame
OutputBox.Parent = OutputContainer
ToggleButton.Parent = AdminGUI
MainFrame.Parent = AdminGUI
AdminGUI.Parent = player:WaitForChild("PlayerGui")

local function buttonHover(button)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
              
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = button == CloseButton and 0.3 or 0.2,
              
        })
        tween:Play()
    end)
end

buttonHover(CloseButton)
buttonHover(MinimizeButton)
buttonHover(ExecuteButton)
buttonHover(ToggleButton)

local function addOutput(text, color)
    if not color then color = Color3.fromRGB(220, 220, 255) end
    
    local time = os.date("%H:%M:%S")
    local newText = "[" .. time .. "] " .. text
    
    if string.find(OutputBox.Text, "Welcome to") then
        OutputBox.Text = newText
    else
        OutputBox.Text = OutputBox.Text .. "\n" .. newText
    end
    
    OutputBox.TextColor3 = color
end

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        ExecuteButton.MouseButton1Click:Fire()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    AdminGUI:Destroy()
    print("Admin Glass Bar closed")
end)

local minimized = false
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0.35, 0, 0, 40)

MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = minimizedSize
        })
        tween:Play()
        MinimizeButton.Text = "+"
        
        InputContainer.Visible = false
        ExecuteButton.Visible = false
        OutputContainer.Visible = false
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = originalSize
        })
        tween:Play()
        MinimizeButton.Text = "–"
        
        InputContainer.Visible = true
        ExecuteButton.Visible = true
        OutputContainer.Visible = true
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        ToggleButton.Image = isOpenImage
        addOutput("Glass Bar opened", Color3.fromRGB(100, 200, 255))
    else
        ToggleButton.Image = isClosedImage
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F3 then
        ToggleButton.MouseButton1Click:Fire()
    end
end)

addOutput("Sky Admin loaded! Press F3 to hide/show on pc", Color3.fromRGB(100, 200, 255))