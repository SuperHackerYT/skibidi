local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2

local NOCLIP = false
local noclipConnection

local INFJUMP_ENABLED = false
local infJumpConnection

local GODMODE_ENABLED = false
local godmodeConnection

local SPEED_ENABLED = false
local originalWalkSpeed = 16

local JUMPSET_ENABLED = false
local originalJumpPower = 50

local GRAVITY_ENABLED = false
local originalGravity = 196.2

local FROZEN_ENABLED = false
local freezeConnection

local lastPosition = nil

local teleportTool = nil

local ESP_ENABLED = false
local espObjects = {}
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP_Folder"
espFolder.Parent = workspace

local XRAY_ENABLED = false
local originalTransparencies = {}

local FULLBRIGHT_ENABLED = false
local originalBrightness
local originalAmbient
local originalOutdoorAmbient

local FOG_ENABLED = false
local originalFogEnd

local SPIN_ENABLED = false
local spinConnection

local DANCE_ENABLED = false
local danceAnimation

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local LP = Players.LocalPlayer

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
Title.Text = "Sky Admin"
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
MinimizeButton.Text = "-"
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
OutputContainer.ClipsDescendants = true

local OutputCorner = Instance.new("UICorner")
OutputCorner.CornerRadius = UDim.new(0, 15)
OutputCorner.Parent = OutputContainer

local OutputText = Instance.new("TextLabel")
OutputText.Name = "OutputText"
OutputText.Size = UDim2.new(1, -20, 1, -20)
OutputText.Position = UDim2.new(0, 10, 0, 10)
OutputText.BackgroundTransparency = 1
OutputText.Text = "Welcome to Sky Admin\nType commands and click EXECUTE"
OutputText.TextColor3 = Color3.fromRGB(220, 220, 255)
OutputText.TextSize = 14
OutputText.Font = Enum.Font.Gotham
OutputText.TextXAlignment = Enum.TextXAlignment.Left
OutputText.TextYAlignment = Enum.TextYAlignment.Top
OutputText.TextWrapped = true
OutputText.Parent = OutputContainer

local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(1, -70, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ToggleButton.BackgroundTransparency = 0.3

local isOpenImage = "http://www.roblox.com/asset/?id=82795327169782"
local isClosedImage = "http://www.roblox.com/asset/?id=82795327169782"

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

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        ExecuteButton.MouseButton1Click:Fire()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    AdminGUI:Destroy()
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
    else
        ToggleButton.Image = isClosedImage
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F3 then
        ToggleButton.MouseButton1Click:Fire()
    end
end)

-- Fixed addOutput function
local function addOutput(text, color)
    if not color then color = Color3.fromRGB(220, 220, 255) end
    
    local time = os.date("%H:%M:%S")
    local newText = "[" .. time .. "] " .. text
    
    if string.find(OutputText.Text, "Welcome to") then
        OutputText.Text = newText
    else
        OutputText.Text = OutputText.Text .. "\n" .. newText
    end
    
    OutputText.TextColor3 = color
end

addOutput("Sky Admin loaded! Press F3 to hide/show on pc", Color3.fromRGB(100, 200, 255))

local function sFLY()
    repeat task.wait() until LP and LP.Character and LP.Character:WaitForChild("HumanoidRootPart") and LP.Character:FindFirstChildOfClass("Humanoid")
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect(); flyKeyUp:Disconnect() end

    local T = LP.Character:WaitForChild("HumanoidRootPart")
    local CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
    local lCONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}
    local SPEED = flySpeed

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro', T)
        local BV = Instance.new('BodyVelocity', T)
        BG.P = 9e4
        BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        BG.CFrame = T.CFrame
        BV.MaxForce = Vector3.new(9e9,9e9,9e9)
        BV.Velocity = Vector3.new(0,0,0)

        task.spawn(function()
            while FLYING do
                task.wait()
                if not flyToggle and LP.Character:FindFirstChildOfClass('Humanoid') then
                    LP.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = flySpeed
                else
                    SPEED = 0
                end
                if SPEED ~= 0 then
                    BV.Velocity = ((workspace.CurrentCamera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) +
                                  ((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,0).p) -
                                  workspace.CurrentCamera.CFrame.p)) * SPEED
                    lCONTROL = {F=CONTROL.F,B=CONTROL.B,L=CONTROL.L,R=CONTROL.R}
                else
                    BV.Velocity = Vector3.new(0,0,0)
                end
                BG.CFrame = workspace.CurrentCamera.CFrame
            end
            BG:Destroy()
            BV:Destroy()
            if LP.Character:FindFirstChildOfClass('Humanoid') then
                LP.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            end
        end)
    end

    flyKeyDown = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY=="W" then CONTROL.F=flySpeed
            elseif KEY=="S" then CONTROL.B=-flySpeed
            elseif KEY=="A" then CONTROL.L=-flySpeed
            elseif KEY=="D" then CONTROL.R=flySpeed
            elseif KEY=="E" then CONTROL.Q=flySpeed*2
            elseif KEY=="Q" then CONTROL.E=-flySpeed*2 end
        end
    end)

    flyKeyUp = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local KEY = input.KeyCode.Name
            if KEY=="W" then CONTROL.F=0
            elseif KEY=="S" then CONTROL.B=0
            elseif KEY=="A" then CONTROL.L=0
            elseif KEY=="D" then CONTROL.R=0
            elseif KEY=="E" then CONTROL.Q=0
            elseif KEY=="Q" then CONTROL.E=0 end
        end
    end)

    FLY()
end

local function NOFLY()
    FLYING = false
    if flyKeyDown then flyKeyDown:Disconnect() end
    if flyKeyUp then flyKeyUp:Disconnect() end
    if mfly1 then mfly1:Disconnect() end
    if mfly2 then mfly2:Disconnect() end
    if LP.Character:FindFirstChildOfClass('Humanoid') then
        LP.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
end

local function MobileFly()
    NOFLY()
    FLYING = true
    local root = LP.Character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    local controlModule = require(LP.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    local v3inf = Vector3.new(9e9,9e9,9e9)
    local v3none = Vector3.new(0,0,0)

    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "BodyVelocity"
    bv.MaxForce = v3none
    bv.Velocity = v3none

    local bg = Instance.new("BodyGyro", root)
    bg.Name = "BodyGyro"
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly2 = RunService.RenderStepped:Connect(function()
        root = LP.Character:WaitForChild("HumanoidRootPart")
        camera = workspace.CurrentCamera
        if LP.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild("BodyVelocity") and root:FindFirstChild("BodyGyro") then
            local humanoid = LP.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = root:FindFirstChild("BodyVelocity")
            local GyroHandler = root:FindFirstChild("BodyGyro")
            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            humanoid.PlatformStand = true
            GyroHandler.CFrame = camera.CFrame
            VelocityHandler.Velocity = v3none
            local direction = controlModule:GetMoveVector()
            VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * (flySpeed*50))
            VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * (flySpeed*50))
        end
    end)
end

local function UnMobileFly()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if root then
        if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
        if root:FindFirstChild("BodyGyro") then root.BodyGyro:Destroy() end
    end
end

ExecuteButton.MouseButton1Click:Connect(function()
    local cmd = InputBox.Text:lower()
    
    -- TEST COMMAND - ALWAYS WORK
    if cmd == "test123" then
        OutputText.Text = "TEST COMMAND WORKING!\nIf you see this, commands work."
        OutputText.TextColor3 = Color3.fromRGB(255, 255, 255)
        InputBox.Text = ""
        return
    end
    
    if cmd:match("^fly") then
        local speed = cmd:match("^fly%s+(%d+)$") or cmd:match("^fly%s+(%d+%.%d+)$")
        
        if speed then
            flySpeed = tonumber(speed)
            addOutput("Fly enabled with speed: " .. speed, Color3.fromRGB(100, 149, 237))
        else
            if cmd == "fly" then
                flySpeed = 1
                addOutput("Fly enabled with default speed: 1", Color3.fromRGB(100, 255, 100))
            else
                addOutput("Usage: fly [speed] or just fly", Color3.fromRGB(255, 255, 100))
                InputBox.Text = ""
                return
            end
        end
        
        if game:GetService("UserInputService").TouchEnabled then
            MobileFly()
        else
            sFLY()
        end
        
    elseif cmd == "unfly" then
        addOutput("Fly disabled!", Color3.fromRGB(100, 149, 237))
        UnMobileFly()
        NOFLY()
        
    elseif cmd == "noclip" then
        if NOCLIP then
            addOutput("Noclip is already enabled!", Color3.fromRGB(255, 255, 100))
            InputBox.Text = ""
            return
        end
        
        NOCLIP = true
        addOutput("Noclip enabled!", Color3.fromRGB(100, 149, 237))
        
        local character = LP.Character
        if not character then
            addOutput("Error: No character found!", Color3.fromRGB(100, 149, 237))
            InputBox.Text = ""
            return
        end
        
        local function noclipParts()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
        
        noclipParts()
        
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not NOCLIP or not character or not character.Parent then
                if noclipConnection then
                    noclipConnection:Disconnect()
                end
                return
            end
            
            character = LP.Character
            if character then
                noclipParts()
            end
        end)
        
    elseif cmd == "clip" then
        if not NOCLIP then
            addOutput("Noclip is not enabled!", Color3.fromRGB(100, 149, 237))
            InputBox.Text = ""
            return
        end
        
        NOCLIP = false
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        local character = LP.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        addOutput("Noclip disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "infinitejump" or cmd == "infjump" then
        if INFJUMP_ENABLED then
            addOutput("Infinite jump is already enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        INFJUMP_ENABLED = true
        addOutput("Infinite jump enabled! (Space bar)", Color3.fromRGB(100, 149, 237))
        
        if infJumpConnection then
            infJumpConnection:Disconnect()
        end
        
        infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if INFJUMP_ENABLED and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
                LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
        
    elseif cmd == "uninfinitejump" or cmd == "uninfjump" then
        if not INFJUMP_ENABLED then
            addOutput("Infinite jump is not enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        INFJUMP_ENABLED = false
        
        if infJumpConnection then
            infJumpConnection:Disconnect()
            infJumpConnection = nil
        end
        
        addOutput("Infinite jump disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "godmode" or cmd == "noparttouch" then
        if GODMODE_ENABLED then
            addOutput("God mode is already enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        GODMODE_ENABLED = true
        addOutput("God mode enabled! (No part collision)", Color3.fromRGB(100, 149, 237))
        
        local function setupGodMode()
            local character = LP.Character
            if not character then return end
            
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            character.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false
                end
            end)
        end
        
        setupGodMode()
        
        godmodeConnection = LP.CharacterAdded:Connect(function(character)
            if GODMODE_ENABLED then
                character:WaitForChild("HumanoidRootPart")
                setupGodMode()
            end
        end)
        
    elseif cmd == "ungodmode" or cmd == "parttouch" then
        if not GODMODE_ENABLED then
            addOutput("God mode is not enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        GODMODE_ENABLED = false
        
        if godmodeConnection then
            godmodeConnection:Disconnect()
            godmodeConnection = nil
        end
        
        local character = LP.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        addOutput("God mode disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd:match("^speed") then
        local speedValue = cmd:match("^speed%s+(%d+)$") or cmd:match("^speed%s+(%d+%.%d+)$")
        
        if speedValue then
            speedValue = tonumber(speedValue)
            if speedValue < 0 then
                addOutput("Speed cannot be negative!", Color3.fromRGB(255, 100, 100))
                InputBox.Text = ""
                return
            end
            
            SPEED_ENABLED = true
            local character = LP.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedValue
                addOutput("Walk speed set to: " .. speedValue, Color3.fromRGB(100, 149, 237))
            else
                addOutput("Error: No character or humanoid found!", Color3.fromRGB(255, 100, 100))
            end
            
        elseif cmd == "speed" then
            if SPEED_ENABLED then
                SPEED_ENABLED = false
                local character = LP.Character
                if character and character:FindFirstChildOfClass("Humanoid") then
                    character:FindFirstChildOfClass("Humanoid").WalkSpeed = originalWalkSpeed
                    addOutput("Walk speed reset to default: " .. originalWalkSpeed, Color3.fromRGB(100, 149, 237))
                end
            else
                addOutput("Usage: speed [value] (e.g., speed 50)", Color3.fromRGB(173, 216, 230))
            end
            
        else
            addOutput("Usage: speed [value] (e.g., speed 50)", Color3.fromRGB(173, 216, 230))
        end
        
    elseif cmd:match("^jumppower") or cmd:match("^jp") then
        local jumpValue = cmd:match("^jumppower%s+(%d+)$") or 
                         cmd:match("^jumppower%s+(%d+%.%d+)$") or
                         cmd:match("^jp%s+(%d+)$") or
                         cmd:match("^jp%s+(%d+%.%d+)$")
        
        if jumpValue then
            jumpValue = tonumber(jumpValue)
            if jumpValue < 0 then
                addOutput("Jump power cannot be negative!", Color3.fromRGB(255, 100, 100))
                InputBox.Text = ""
                return
            end
            
            JUMPSET_ENABLED = true
            local character = LP.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                character:FindFirstChildOfClass("Humanoid").JumpPower = jumpValue
                addOutput("Jump power set to: " .. jumpValue, Color3.fromRGB(100, 149, 237))
            else
                addOutput("Error: No character or humanoid found!", Color3.fromRGB(255, 100, 100))
            end
            
        elseif cmd == "jumppower" or cmd == "jp" then
            if JUMPSET_ENABLED then
                JUMPSET_ENABLED = false
                local character = LP.Character
                if character and character:FindFirstChildOfClass("Humanoid") then
                    character:FindFirstChildOfClass("Humanoid").JumpPower = originalJumpPower
                    addOutput("Jump power reset to default: " .. originalJumpPower, Color3.fromRGB(100, 149, 237))
                end
            else
                addOutput("Usage: jumppower [value] or jp [value] (e.g., jp 100)", Color3.fromRGB(173, 216, 230))
            end
            
        else
            addOutput("Usage: jumppower [value] or jp [value] (e.g., jp 100)", Color3.fromRGB(173, 216, 230))
        end
        
    elseif cmd:match("^gravity") then
        local gravityValue = cmd:match("^gravity%s+(%d+)$") or cmd:match("^gravity%s+(%d+%.%d+)$")
        
        if gravityValue then
            gravityValue = tonumber(gravityValue)
            if gravityValue < 0 then
                addOutput("Gravity cannot be negative!", Color3.fromRGB(255, 100, 100))
                InputBox.Text = ""
                return
            end
            
            GRAVITY_ENABLED = true
            workspace.Gravity = gravityValue
            addOutput("Gravity set to: " .. gravityValue, Color3.fromRGB(100, 149, 237))
            
        elseif cmd == "gravity" then
            if GRAVITY_ENABLED then
                GRAVITY_ENABLED = false
                workspace.Gravity = originalGravity
                addOutput("Gravity reset to default: " .. originalGravity, Color3.fromRGB(100, 149, 237))
            else
                addOutput("Usage: gravity [value] (e.g., gravity 50)", Color3.fromRGB(173, 216, 230))
            end
            
        else
            addOutput("Usage: gravity [value] (e.g., gravity 50)", Color3.fromRGB(173, 216, 230))
        end
        
    elseif cmd == "sit" then
        local character = LP.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid").Sit = true
            addOutput("Forced to sit", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: No character or humanoid found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "stand" then
        local character = LP.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid").Sit = false
            addOutput("Forced to stand", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: No character or humanoid found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "freeze" then
        if FROZEN_ENABLED then
            addOutput("Already frozen!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        FROZEN_ENABLED = true
        local character = LP.Character
        
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
            
            freezeConnection = character.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true
                end
            end)
            
            addOutput("Character frozen!", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: No character found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "thaw" or cmd == "unfreeze" then
        if not FROZEN_ENABLED then
            addOutput("Not frozen!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        FROZEN_ENABLED = false
        
        if freezeConnection then
            freezeConnection:Disconnect()
            freezeConnection = nil
        end
        
        local character = LP.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
            
            addOutput("Character unfrozen!", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: No character found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "reset" then
        local character = LP.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid").Health = 0
            addOutput("Character reset!", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: No character or humanoid found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd:match("^goto") then
        local playerName = cmd:match("^goto%s+(.+)$")
        
        if not playerName then
            addOutput("Usage: goto [player name]", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        local targetPlayer = nil
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr.Name:lower():find(playerName:lower(), 1, true) or 
               plr.DisplayName:lower():find(playerName:lower(), 1, true) then
                targetPlayer = plr
                break
            end
        end
        
        if not targetPlayer then
            addOutput("Player '" .. playerName .. "' not found!", Color3.fromRGB(255, 100, 100))
            InputBox.Text = ""
            return
        end
        
        local character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            lastPosition = character.HumanoidRootPart.Position
        end
        
        local targetChar = targetPlayer.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            character = LP.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                addOutput("Teleported to " .. targetPlayer.Name, Color3.fromRGB(100, 149, 237))
            else
                addOutput("Error: Your character not found!", Color3.fromRGB(255, 100, 100))
            end
        else
            addOutput("Error: Target player has no character!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd:match("^tpto") then
        local x, y, z = cmd:match("^tpto%s+(%-?%d+%.?%d*)%s+(%-?%d+%.?%d*)%s+(%-?%d+%.?%d*)$")
        
        if not x then
            x, y, z = cmd:match("^tpto%s+(%-?%d+)%s+(%-?%d+)%s+(%-?%d+)$")
        end
        
        if not x then
            addOutput("Usage: tpto [X] [Y] [Z] (e.g., tpto 100 10 100)", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        x = tonumber(x)
        y = tonumber(y)
        z = tonumber(z)
        
        local character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            lastPosition = character.HumanoidRootPart.Position
        end
        
        character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x, y, z))
            addOutput("Teleported to (" .. x .. ", " .. y .. ", " .. z .. ")", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: Character not found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "spawn" then
        local spawnLocation = nil
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("spawn") or obj.Name:lower():find("start") then
                if obj:IsA("Part") or obj:IsA("SpawnLocation") then
                    spawnLocation = obj.Position + Vector3.new(0, 5, 0) 
                    break
                end
            end
        end
        
        if not spawnLocation then
            for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    if plr.Character.HumanoidRootPart.Position.Y < 100 then
                        spawnLocation = plr.Character.HumanoidRootPart.Position
                        break
                    end
                end
            end
        end
        
        local character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            lastPosition = character.HumanoidRootPart.Position
        end
        
        character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if spawnLocation then
                character.HumanoidRootPart.CFrame = CFrame.new(spawnLocation)
                addOutput("Teleported to spawn", Color3.fromRGB(100, 149, 237))
            else
                character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
                addOutput("Teleported to default spawn (0, 5, 0)", Color3.fromRGB(100, 149, 237))
            end
        else
            addOutput("Error: Character not found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "back" then
        if not lastPosition then
            addOutput("No previous position stored!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        local character = LP.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(lastPosition)
            addOutput("Returned to previous position", Color3.fromRGB(100, 149, 237))
            lastPosition = nil 
        else
            addOutput("Error: Character not found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "tptool" then
        if teleportTool and teleportTool.Parent then
            addOutput("Teleport tool already exists in your backpack!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        local tool = Instance.new("Tool")
        tool.Name = "Teleport Tool"
        tool.ToolTip = "Click to teleport (PC) or tap (Mobile)"
        
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 1, 1)
        handle.BrickColor = BrickColor.new("Bright blue")
        handle.Material = Enum.Material.Neon
        handle.Transparency = 0.3
        handle.Parent = tool
        
        tool.Activated:Connect(function()
            local character = LP.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and root then
                if not game:GetService("UserInputService").TouchEnabled then
                    local mouse = LP:GetMouse()
                    local target = mouse.Hit.Position + Vector3.new(0, 3, 0)
                    root.CFrame = CFrame.new(target)
                    addOutput("Teleported to mouse location", Color3.fromRGB(100, 149, 237))
                end
            end
        end)
        
        handle.Touched:Connect(function(part)
            if game:GetService("UserInputService").TouchEnabled then
                local character = LP.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                local root = character and character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and root and part.Parent ~= character then
                    local target = part.Position + Vector3.new(0, 3, 0)
                    root.CFrame = CFrame.new(target)
                    addOutput("Teleported to touched location", Color3.fromRGB(100, 149, 237))
                end
            end
        end)
        
        local backpack = LP:FindFirstChild("Backpack")
        if backpack then
            tool.Parent = backpack
            teleportTool = tool
            addOutput("Teleport tool added to backpack! (PC: Click, Mobile: Touch)", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error: Backpack not found!", Color3.fromRGB(255, 100, 100))
        end
        
        tool.Destroying:Connect(function()
            teleportTool = nil
        end)
        
        tool.AncestryChanged:Connect(function()
            if not tool.Parent then
                teleportTool = nil
            end
        end)
        
    elseif cmd:match("^gear") then
        local gearId = cmd:match("^gear%s+(%d+)$")
        
        if not gearId then
            addOutput("Usage: gear [ID] (e.g., gear 18474459)", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        gearId = tonumber(gearId)
        
        local InsertService = game:GetService("InsertService")
        
        local success, gear = pcall(function()
            return InsertService:LoadAsset(gearId)
        end)
        
        if success and gear then
            local tool = gear:FindFirstChildOfClass("Tool") or gear:FindFirstChildWhichIsA("Tool")
            
            if tool then
                local backpack = LP:FindFirstChild("Backpack")
                if backpack then
                    tool.Parent = backpack
                    tool.Name = "Gear_" .. gearId
                    addOutput("Gear " .. gearId .. " added to backpack!", Color3.fromRGB(100, 149, 237))
                else
                    addOutput("Error: Backpack not found!", Color3.fromRGB(255, 100, 100))
                end
            else
                addOutput("Error: No tool found in gear " .. gearId, Color3.fromRGB(255, 100, 100))
            end
        else
            addOutput("Error: Could not load gear " .. gearId, Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "notools" or cmd == "cleartools" then
        local backpack = LP:FindFirstChild("Backpack")
        local character = LP.Character
        
        local toolCount = 0
        
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Destroy()
                    toolCount = toolCount + 1
                end
            end
        end
        
        if character then
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Destroy()
                    toolCount = toolCount + 1
                end
            end
        end
        
        teleportTool = nil
        
        addOutput("Removed " .. toolCount .. " tools", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "infiniteyield" or cmd == "iy" then
        addOutput("Loading Infinite Yield...", Color3.fromRGB(100, 149, 237))
        
        local success, result = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end)
        
        if success then
            addOutput("Infinite Yield loaded successfully! Type 'cmds' for commands", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error loading Infinite Yield: " .. tostring(result), Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "esp" then
        if ESP_ENABLED then
            addOutput("ESP is already enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        ESP_ENABLED = true
        addOutput("ESP enabled! (Name and Distance)", Color3.fromRGB(100, 149, 237))
        
        local function createESP(plr)
            if plr == LP then return end
            
            local character = plr.Character
            if not character then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = plr.Name .. "_ESP"
            highlight.FillColor = plr.Team and plr.Team.TeamColor.Color or Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.Parent = espFolder
            highlight.Adornee = character
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = plr.Name .. "_Info"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = espFolder
            billboard.Adornee = character:WaitForChild("Head")
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "NameLabel"
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.Position = UDim2.new(0, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextSize = 14
            nameLabel.Font = Enum.Font.SourceSansBold
            nameLabel.Parent = billboard
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Name = "DistanceLabel"
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.Text = "0 studs"
            distanceLabel.TextColor3 = Color3.new(1, 1, 1)
            distanceLabel.TextStrokeTransparency = 0
            distanceLabel.TextSize = 12
            distanceLabel.Font = Enum.Font.SourceSans
            distanceLabel.Parent = billboard
            
            local function updateDistance()
                if ESP_ENABLED and character and character:FindFirstChild("Head") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (character.Head.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    distanceLabel.Text = math.floor(distance) .. " studs"
                end
            end
            
            local distanceConnection = game:GetService("RunService").Heartbeat:Connect(updateDistance)
            
            espObjects[plr] = {
                Highlight = highlight,
                Billboard = billboard,
                Connection = distanceConnection
            }
        end
        
        local function removeESP(plr)
            if espObjects[plr] then
                if espObjects[plr].Highlight then
                    espObjects[plr].Highlight:Destroy()
                end
                if espObjects[plr].Billboard then
                    espObjects[plr].Billboard:Destroy()
                end
                if espObjects[plr].Connection then
                    espObjects[plr].Connection:Disconnect()
                end
                espObjects[plr] = nil
            end
        end
        
        for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
            createESP(plr)
        end
        
        game:GetService("Players").PlayerAdded:Connect(function(plr)
            if ESP_ENABLED then
                plr.CharacterAdded:Connect(function()
                    if ESP_ENABLED then
                        createESP(plr)
                    end
                end)
            end
        end)
        
        game:GetService("Players").PlayerRemoving:Connect(function(plr)
            removeESP(plr)
        end)
        
    elseif cmd == "unesp" then
        if not ESP_ENABLED then
            addOutput("ESP is not enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        ESP_ENABLED = false
        
        for plr, espData in pairs(espObjects) do
            if espData.Highlight then
                espData.Highlight:Destroy()
            end
            if espData.Billboard then
                espData.Billboard:Destroy()
            end
            if espData.Connection then
                espData.Connection:Disconnect()
            end
        end
        
        espObjects = {}
        espFolder:ClearAllChildren()
        
        addOutput("ESP disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "xray" then
        if XRAY_ENABLED then
            addOutput("Xray is already enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        XRAY_ENABLED = true
        addOutput("Xray enabled!", Color3.fromRGB(100, 149, 237))
        
        originalTransparencies = {}
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.9 then
                originalTransparencies[part] = part.Transparency
                
                if part.Size.Magnitude > 10 and not part:IsDescendantOf(game:GetService("Players"):GetPlayers()) then
                    part.Transparency = 0.7
                    part.Material = Enum.Material.Glass
                end
            end
        end
        
        workspace.DescendantAdded:Connect(function(descendant)
            if XRAY_ENABLED and descendant:IsA("BasePart") and descendant.Transparency < 0.9 then
                if not originalTransparencies[descendant] then
                    originalTransparencies[descendant] = descendant.Transparency
                end
                
                if descendant.Size.Magnitude > 10 and not descendant:IsDescendantOf(game:GetService("Players"):GetPlayers()) then
                    descendant.Transparency = 0.7
                    descendant.Material = Enum.Material.Glass
                end
            end
        end)
        
    elseif cmd == "unxray" then
        if not XRAY_ENABLED then
            addOutput("Xray is not enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        XRAY_ENABLED = false
        addOutput("Xray disabled!", Color3.fromRGB(100, 149, 237))
        
        for part, transparency in pairs(originalTransparencies) do
            if part and part.Parent then
                part.Transparency = transparency
                part.Material = Enum.Material.Plastic
            end
        end
        
        originalTransparencies = {}
        
    elseif cmd == "fullbright" or cmd == "fb" then
        if FULLBRIGHT_ENABLED then
            addOutput("Fullbright is already enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        FULLBRIGHT_ENABLED = true
        addOutput("Fullbright enabled!", Color3.fromRGB(100, 149, 237))
        
        local lighting = game:GetService("Lighting")
        originalBrightness = lighting.Brightness
        originalAmbient = lighting.Ambient
        originalOutdoorAmbient = lighting.OutdoorAmbient
        
        lighting.Brightness = 2
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        
        lighting.GlobalShadows = false
        
    elseif cmd == "unfullbright" or cmd == "unfb" then
        if not FULLBRIGHT_ENABLED then
            addOutput("Fullbright is not enabled!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        FULLBRIGHT_ENABLED = false
        addOutput("Fullbright disabled!", Color3.fromRGB(100, 149, 237))
        
        local lighting = game:GetService("Lighting")
        
        if originalBrightness then
            lighting.Brightness = originalBrightness
        end
        if originalAmbient then
            lighting.Ambient = originalAmbient
        end
        if originalOutdoorAmbient then
            lighting.OutdoorAmbient = originalOutdoorAmbient
        end
        
        lighting.GlobalShadows = true
        
    elseif cmd:match("^fog") then
        local fogValue = cmd:match("^fog%s+(%d+)$") or cmd:match("^fog%s+(%d+%.%d+)$")
        
        if fogValue then
            fogValue = tonumber(fogValue)
            
            if fogValue <= 0 then
                addOutput("Fog distance must be positive!", Color3.fromRGB(255, 100, 100))
                InputBox.Text = ""
                return
            end
            
            FOG_ENABLED = true
            game:GetService("Lighting").FogEnd = fogValue
            addOutput("Fog distance set to: " .. fogValue, Color3.fromRGB(100, 149, 237))
            
        elseif cmd == "fog" then
            if not FOG_ENABLED then
                addOutput("Usage: fog [distance] (e.g., fog 1000) or nofog to disable", Color3.fromRGB(173, 216, 230))
            else
                addOutput("Fog is enabled. Use nofog to disable", Color3.fromRGB(173, 216, 230))
            end
            
        else
            addOutput("Usage: fog [distance] (e.g., fog 1000)", Color3.fromRGB(173, 216, 230))
        end
        
    elseif cmd == "nofog" then
        if not originalFogEnd then
            originalFogEnd = game:GetService("Lighting").FogEnd
        end
        
        game:GetService("Lighting").FogEnd = originalFogEnd or 100000
        FOG_ENABLED = false
        addOutput("Fog disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd:match("^time") then
        local timeValue = cmd:match("^time%s+(%d+)$") or cmd:match("^time%s+(%d+%.%d+)$")
        
        if timeValue then
            timeValue = tonumber(timeValue)
            
            if timeValue < 0 or timeValue > 24 then
                addOutput("Time must be between 0 and 24!", Color3.fromRGB(255, 100, 100))
                InputBox.Text = ""
                return
            end
            
            game:GetService("Lighting").ClockTime = timeValue
            addOutput("Time set to: " .. timeValue .. ":00", Color3.fromRGB(100, 149, 237))
            
        elseif cmd == "time" then
            addOutput("Usage: time [hour] (e.g., time 12 for noon)", Color3.fromRGB(173, 216, 230))
        else
            addOutput("Usage: time [hour] (e.g., time 12)", Color3.fromRGB(173, 216, 230))
        end
        
    elseif cmd == "rejoin" then
        addOutput("Rejoining game...", Color3.fromRGB(100, 149, 237))
        
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LP)
        
    elseif cmd == "serverhop" then
        addOutput("Finding new server...", Color3.fromRGB(100, 149, 237))
        
        local function getServers()
            local servers = {}
            local success, result = pcall(function()
                return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            end)
            
            if success and result and result.data then
                for _, server in pairs(result.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server)
                    end
                end
            end
            return servers
        end
        
        local servers = getServers()
        
        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, randomServer.id, LP)
            addOutput("Joining server with " .. randomServer.playing .. " players", Color3.fromRGB(100, 149, 237))
        else
            addOutput("No available servers found!", Color3.fromRGB(255, 100, 100))
        end
        
    elseif cmd == "copyid" then
        local placeId = tostring(game.PlaceId)
        
        if pcall(function()
            setclipboard(placeId)
        end) then
            addOutput("Place ID copied to clipboard: " .. placeId, Color3.fromRGB(100, 149, 237))
        else
            addOutput("Place ID: " .. placeId .. " (Could not copy to clipboard)", Color3.fromRGB(100, 149, 237))
        end
        
    elseif cmd == "spin" then
        if SPIN_ENABLED then
            addOutput("Already spinning!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        SPIN_ENABLED = true
        addOutput("Spin enabled!", Color3.fromRGB(100, 149, 237))
        
        local character = LP.Character
        if not character then
            addOutput("Error: No character found!", Color3.fromRGB(255, 100, 100))
            InputBox.Text = ""
            return
        end
        
        local root = character:WaitForChild("HumanoidRootPart")
        local spinSpeed = 5
        
        spinConnection = game:GetService("RunService").Heartbeat:Connect(function(delta)
            if SPIN_ENABLED and character and root then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed * delta * 60), 0)
            else
                if spinConnection then
                    spinConnection:Disconnect()
                end
            end
        end)
        
    elseif cmd == "unspin" then
        if not SPIN_ENABLED then
            addOutput("Not spinning!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        SPIN_ENABLED = false
        
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
        
        addOutput("Spin disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "dance" then
        if DANCE_ENABLED then
            addOutput("Already dancing!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        DANCE_ENABLED = true
        addOutput("Dance enabled!", Color3.fromRGB(100, 149, 237))
        
        local character = LP.Character
        if not character then
            addOutput("Error: No character found!", Color3.fromRGB(255, 100, 100))
            InputBox.Text = ""
            return
        end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            addOutput("Error: No humanoid found!", Color3.fromRGB(255, 100, 100))
            InputBox.Text = ""
            return
        end
        
        local animationId = 5918726674 
        danceAnimation = Instance.new("Animation")
        danceAnimation.AnimationId = "rbxassetid://" .. animationId
        
        local animationTrack = humanoid:LoadAnimation(danceAnimation)
        animationTrack:Play()
        animationTrack.Looped = true
        
        LP.CharacterAdded:Connect(function(newCharacter)
            if DANCE_ENABLED then
                task.wait(1) 
                local newHumanoid = newCharacter:FindFirstChildOfClass("Humanoid")
                if newHumanoid then
                    local newTrack = newHumanoid:LoadAnimation(danceAnimation)
                    newTrack:Play()
                    newTrack.Looped = true
                end
            end
        end)
        
    elseif cmd == "undance" or cmd == "stopdance" then
        if not DANCE_ENABLED then
            addOutput("Not dancing!", Color3.fromRGB(173, 216, 230))
            InputBox.Text = ""
            return
        end
        
        DANCE_ENABLED = false
        
        local character = LP.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end
        
        if danceAnimation then
            danceAnimation:Destroy()
            danceAnimation = nil
        end
        
        addOutput("Dance disabled!", Color3.fromRGB(100, 149, 237))
        
    elseif cmd == "unbanvoicechat" then
        addOutput("Attempting to enable voice chat...", Color3.fromRGB(100, 149, 237))
        
        local success, errorMsg = pcall(function()
            local voiceChatService = game:GetService("VoiceChatService")
            voiceChatService:joinVoice()
        end)
        
        if success then
            addOutput("Voice chat enabled successfully!", Color3.fromRGB(100, 149, 237))
        else
            addOutput("Error enabling voice chat: " .. tostring(errorMsg), Color3.fromRGB(255, 100, 100))
        end
        
    else
        addOutput("Unknown command: " .. cmd, Color3.fromRGB(255, 100, 100))
    end
    
    InputBox.Text = ""
end)