local UIS = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer or game.Players.PlayerAdded:Wait()
local Camera = workspace.CurrentCamera

local Flix = loadstring(game:HttpGet("https://radiant-puffpuff-a4e0c1.netlify.app",true))()

local window = b:CreateWindow({
    Title   = "SkyArc",
    Icon    = "rbxassetid://96216488061257",
    Theme   = "Dark",
    Keybind = Enum.KeyCode.RightControl
})

local mainTab = window:CreateTab({
    Title = "Main"
})

mainTab:CreateSection({
    Title = "Movement"
})

local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local function sFLY()
    repeat task.wait() until lp and lp.Character and lp.Character:WaitForChild("HumanoidRootPart") and lp.Character:FindFirstChildOfClass("Humanoid")
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect(); flyKeyUp:Disconnect() end

    local T = lp.Character:WaitForChild("HumanoidRootPart")
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
                if not flyToggle and lp.Character:FindFirstChildOfClass('Humanoid') then
                    lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
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
            if lp.Character:FindFirstChildOfClass('Humanoid') then
                lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
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
    if lp.Character:FindFirstChildOfClass('Humanoid') then
lp.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
end
end

local function MobileFly()
    NOFLY()
    FLYING = true
    local root = lp.Character:WaitForChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera
    local controlModule = require(lp.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
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
        root = lp.Character:WaitForChild("HumanoidRootPart")
        camera = workspace.CurrentCamera
        if lp.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild("BodyVelocity") and root:FindFirstChild("BodyGyro") then
            local humanoid = lp.Character:FindFirstChildWhichIsA("Humanoid")
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

local Fly = mainTab:CreateToggle({
    Title = "Fly",
    Desc= "Gives you the ability to fly!",
    Value = false,
    Callback = function(state)
        flyToggle = state
        if flyToggle then
            if UserInputService.TouchEnabled then
                MobileFly()
            else
                sFLY()
            end
        else

            FLYING = false

            if flyKeyDown then flyKeyDown:Disconnect() flyKeyDown=nil end
            if flyKeyUp then flyKeyUp:Disconnect() flyKeyUp=nil end
            if mfly1 then mfly1:Disconnect() mfly1=nil end
            if mfly2 then mfly2:Disconnect() mfly2=nil end

            local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
                if root:FindFirstChild("BodyGyro") then root.BodyGyro:Destroy() end
            end

            local humanoid = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
})

local NoClip = false

local Noclip = mainTab:CreateToggle({
    Title = "NoClip",
    Desc = "Pass through walls",
    Value = false,
    Callback = function(state)
    NoClip = state 
end
})

RunService.Stepped:Connect(function()
    if NoClip then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

local player = Players.LocalPlayer

local wsVal = 16
local jpVal = 50
local gravVal = 196.2
local enforcing = true

local loopConn = RunService.Stepped:Connect(function()
    pcall(function()
        if enforcing and player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = wsVal
                hum.JumpPower = jpVal
                pcall(function() hum.JumpHeight = jpVal * 0.7 end)
            end
            workspace.Gravity = gravVal
        end
    end)
end)

player.CharacterAdded:Connect(function()
    task.wait(0.1)
    local hum = player.Character:WaitForChild("Humanoid")
    hum.WalkSpeed = wsVal
    hum.JumpPower = jpVal
    pcall(function() hum.JumpHeight = jpVal * 0.7 end)
end)

mainTab:CreateTextbox({
    Title = "WalkSpeed", Desc = "type num + enter (loop locks it)",
    Value = "16", ClearTextOnFocus = false,
    Callback = function(text) wsVal = tonumber(text) or wsVal end
})

mainTab:CreateTextbox({
    Title = "JumpPower", Desc = "type num + enter (works old/new roblox)",
    Value = "50", ClearTextOnFocus = false,
    Callback = function(text) jpVal = tonumber(text) or jpVal end
})

mainTab:CreateTextbox({
    Title = "Gravity", Desc = "0=float, 196=normal (client physics)",
    Value = "196", ClearTextOnFocus = false,
    Callback = function(text) gravVal = tonumber(text) or gravVal end
})

mainTab:CreateToggle({
    Title = "Lock Movement", Desc = "on = immune to resets",
    Value = true,
    Callback = function(on) enforcing = on end
})

mainTab:CreateSection({
    Title = "Protection"
})

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local lastSafePosition = humanoidRootPart.CFrame

local antiFlingConnection
local antiVoidConnection, positionConnection, velocityConnection

mainTab:CreateToggle({
    Title = "Anti Fling",
    Desc = "stops ragdoll fling bs",
    Value = false,
    Callback = function(state)
        if state then
            antiFlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                        if part.Velocity.Magnitude > 50 then
                            part.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end)
        else
            if antiFlingConnection then
                antiFlingConnection:Disconnect()
                antiFlingConnection = nil
            end
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
})

local lastGroundPosition = humanoidRootPart.CFrame
local antiVoidConnection

local function onTouch(part)
    if part and part.Parent and part ~= humanoidRootPart then
        lastGroundPosition = humanoidRootPart.CFrame
    end
end

mainTab:CreateToggle({
    Title = "Anti Void",
    Desc = "tele back if fall >100 studs below last touched spot",
    Value = false,
    Callback = function(state)
        if state then
            humanoidRootPart.Touched:Connect(onTouch)

            antiVoidConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local fallDistance = lastGroundPosition.Position.Y - humanoidRootPart.Position.Y
                if fallDistance > 100 then
                    humanoidRootPart.CFrame = lastGroundPosition
                    local currentVel = humanoidRootPart.Velocity
                    humanoidRootPart.Velocity = Vector3.new(currentVel.X, 0, currentVel.Z)
                end
            end)
        else
            if antiVoidConnection then
                antiVoidConnection:Disconnect()
                antiVoidConnection = nil
            end
            for _, conn in pairs(humanoidRootPart:GetConnections("Touched")) do
                if conn.Function == onTouch then
                    conn:Disconnect()
                end
            end
        end
    end
})

mainTab:CreateToggle({
    Title = "Anti KillPart / Anti TouchPart",
    Desc = "ignore death parts",
    Value = false,
    Callback = function(state)
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
})

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    lastSafePosition = humanoidRootPart.CFrame
end)

mainTab:CreateSection({
    Title = "Troll"
})

local walkFlingActive = false
local flingLoop

mainTab:CreateToggle({
    Title = "Walk Fling",
    Desc = "fling those bitches with this feature",
    Value = false,
    Callback = function(state)
        walkFlingActive = state

        local function startFling(char)
            if not walkFlingActive then return end
            local root = char:WaitForChild("HumanoidRootPart")
            local hum = char:WaitForChild("Humanoid")

            root.CanCollide = false
            hum:ChangeState(Enum.HumanoidStateType.Physics)

            flingLoop = RunService.Heartbeat:Connect(function()
                if not walkFlingActive or not root.Parent then
                    flingLoop:Disconnect()
                    return
                end

                local vel = root.Velocity
                root.Velocity = vel * 99999999 + Vector3.new(0, 99999999, 0)
                RunService.RenderStepped:Wait()
                root.Velocity = vel
                RunService.Stepped:Wait()
                root.Velocity = vel + Vector3.new(0, 0.1, 0)
            end)
        end

        if state then
            startFling(character)
            player.CharacterAdded:Connect(startFling)
        else
            if flingLoop then
                flingLoop:Disconnect()
                flingLoop = nil
            end
            if humanoidRootPart and humanoidRootPart.Parent then
                humanoidRootPart.CanCollide = true
            end
        end
    end
})

local invisEnabled = false

local function setTransparency(char, alpha)
    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" or obj:IsA("Decal") then
            obj.Transparency = alpha
        end
    end
end

mainTab:CreateToggle({
    Title = "Invisibility",
    Desc = "become ghost (seat method)",
    Value = false,
    Callback = function(state)
        invisEnabled = state
        local char = player.Character or player.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")

        if not torso then return end

        if state then
            local savedPos = root.CFrame

            char:MoveTo(Vector3.new(-25.95, 84, 3537.55))
            task.wait(0.15)
            
            local seat = Instance.new("Seat")
            seat.Name = "invischair"
            seat.Transparency = 1
            seat.CanCollide = false
            seat.Anchored = false
            seat.Size = Vector3.new(2, 1, 2)
            seat.Position = Vector3.new(-25.95, 84, 3537.55)
            seat.Parent = workspace

            local weld = Instance.new("Weld")
            weld.Part0 = seat
            weld.Part1 = torso
            weld.C0 = CFrame.new(0, -1, 0)
            weld.Parent = seat

            task.wait()
            seat.CFrame = savedPos

            setTransparency(char, 0.75)
        else
            local seat = workspace:FindFirstChild("invischair")
            if seat then seat:Destroy() end
            setTransparency(char, 0)
        end
    end
})

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

local reachEnabled = false
local reachRange = 18
local reachLoop

local function startReach()
    reachLoop = RunService.Heartbeat:Connect(function()
        if not reachEnabled then return end

        local tool = character:FindFirstChildOfClass("Tool")
        if not tool or not tool:FindFirstChild("Handle") then return end

        local handle = tool.Handle

        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer == player then continue end
            local targetChar = targetPlayer.Character
            if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end
            if not targetChar:FindFirstChild("Humanoid") or targetChar.Humanoid.Health <= 0 then continue end

            local root = targetChar.HumanoidRootPart
            local distance = (character.HumanoidRootPart.Position - root.Position).Magnitude

            if distance <= reachRange then
                for _, part in pairs(targetChar:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Size = Vector3.new(5, 5, 5)
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

spawn(function()
    while task.wait(0.5) do
        if not reachEnabled then
            pcall(function()
                for _, targetPlayer in pairs(Players:GetPlayers()) do
                    if targetPlayer ~= player and targetPlayer.Character then
                        for _, part in pairs(targetPlayer.Character:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                part.Size = Vector3.new(2, 2, 1)
                                part.Transparency = 0
                                part.CanCollide = true
                            end
                        end
                    end
                end
            end)
        end
    end
end)

mainTab:CreateToggle({
    Title = "Sword Reach",
    Desc = "hit from far, sword looks normal",
    Value = false,
    Callback = function(state)
        reachEnabled = state

        if state then
            startReach()
        else
            if reachLoop then
                reachLoop:Disconnect()
                reachLoop = nil
            end
        end
    end
})

mainTab:CreateTextbox({
    Title = "Reach Range",
    Desc = "14-25 best | 30+ obvious",
    Value = "18",
    ClearTextOnFocus = false,
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 10 and num <= 50 then
            reachRange = num
        end
    end
})

player.CharacterAdded:Connect(function(char)
    character = char
end)

mainTab:CreateSection({
    Title = "Others"
})

mainTab:CreateButton({
    Title = "Open unanchored abuser",
    Desc = "Control unanchored objects",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/Brick/refs/heads/main/Brick.lua"))()
    end
})

mainTab:CreateButton({
    Title = "Set Day Time",
    Desc = "makes it bright af ??",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.ClockTime = 14
        lighting.Brightness = 3
        lighting.GlobalShadows = false
        lighting.FogEnd = 100000
    end
})

mainTab:CreateButton({
    Title = "Set Night Time",
    Desc = "spooky dark mode ??",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.ClockTime = 0
        lighting.Brightness = 1
        lighting.GlobalShadows = true
        lighting.FogEnd = 500
    end
})

local xrayEnabled = false

mainTab:CreateToggle({
    Title = "X-Ray Vision",
    Desc = "walls become glass",
    Value = false,
    Callback = function(state)
        xrayEnabled = state
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") and not part.Parent:IsA("Accessory") then
                if state then
                    part.Transparency = 0.7
                    if part.Material ~= Enum.Material.ForceField then
                        part.Material = Enum.Material.ForceField
                    end
                else
                    part.Transparency = 0
                    part.Material = Enum.Material.Plastic
                end
            end
        end
    end
})

mainTab:CreateButton({
    Title = "Respawn Character",
    Desc = "instant reset",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
        end
    end
})

mainTab:CreateSection({
    Title = "Aim Assist"
})

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local aimbotEnabled = false
local crosshairEnabled = false
local teamCheckEnabled = false
local autoTriggerEnabled = false
local fov = 120 
local smooth = 0.15

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local crosshair = Instance.new("Frame", screenGui)
crosshair.Size = UDim2.new(0, fov*2, 0, fov*2)
crosshair.Position = UDim2.new(0.5, -fov, 0.5, -fov)
crosshair.BackgroundTransparency = 1
crosshair.Visible = false

local circle = Instance.new("ImageLabel", crosshair)
circle.Size = UDim2.new(1, 0, 1, 0)
circle.BackgroundTransparency = 1
circle.Image = "rbxassetid://3570695787"
circle.ImageColor3 = Color3.new(0,1,0)
circle.ImageTransparency = 0.5
circle.ScaleType = Enum.ScaleType.Fit

local function getClosest()
    local closest, dist = nil, fov
    local mousePos = Vector2.new(mouse.X, mouse.Y)
    
    for _, target in pairs(Players:GetPlayers()) do
        if target == player or not target.Character then continue end
        if teamCheckEnabled and target.Team == player.Team then continue end
        
        local head = target.Character:FindFirstChild("Head")
        if not head then continue end
        
        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
        local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
        local delta = (mousePos - screenPoint).Magnitude
        
        if delta < dist and onScreen then
            closest = head
            dist = delta
        end
    end
    
    return closest
end

local aimLoop = RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    
    local target = getClosest()
    if target then
        local targetPos = target.Position
        local currentCFrame = camera.CFrame
        local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPos)
        
        camera.CFrame = currentCFrame:lerp(targetCFrame, smooth)
    end
end)

RunService.Heartbeat:Connect(function()
    if not autoTriggerEnabled or not aimbotEnabled then return end
    
    local target = getClosest()
    if target then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end)

mainTab:CreateToggle({
    Title = "Aimbot",
    Desc = "snaps to nearest enemy head",
    Value = false,
    Callback = function(state) aimbotEnabled = state end
})

mainTab:CreateToggle({
    Title = "Crosshair (FOV Circle)",
    Desc = "green circle in middle",
    Value = false,
    Callback = function(state)
        crosshairEnabled = state
        crosshair.Visible = state
    end
})

mainTab:CreateToggle({
    Title = "Team Check",
    Desc = "ignore teammates",
    Value = true,
    Callback = function(state) teamCheckEnabled = state end
})

mainTab:CreateToggle({
    Title = "Auto Trigger",
    Desc = "auto fires when locked",
    Value = false,
    Callback = function(state) autoTriggerEnabled = state end
})

player.CharacterAdded:Connect(function() character = character end)

mainTab:CreateSection({
    Title = "Server"
})

mainTab:CreateButton({
    Title    = "Rejoin",
    Desc   = "Rejoin the server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

mainTab:CreateButton({
    Title    = "Serverhop",
    Desc   = "Hops to another server",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TPService = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"

        local function serverhop()
            local Servers = Http:JSONDecode(game:HttpGet(Api))
            for _,v in pairs(Servers.data) do
                if v.playing < v.maxPlayers then
                    TPService:TeleportToPlaceInstance(game.PlaceId, v.id, game.Players.LocalPlayer)
                    break
                end
            end
        end
        serverhop()
    end
})

local scriptsTab = window:CreateTab({
    Title = "Scripts"
})

scriptsTab:CreateSection({
    Title = "Admin Scripts"
})

scriptsTab:CreateButton({
    Title = "QuirkyCMD",
    Desc = "Serversided admin with specific game support",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/OfficialCynatica/636bed3e9ba0088733feb986768f8015/raw", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Nameless Admin",
    Desc = "Best reworked admin script ??",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Infinite Yield",
    Desc = "The OG legendary admin",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

scriptsTab:CreateButton({
    Title = "AK Admin",
    Desc = "Powerful admin + game-specific cmds (has key)",
    Callback = function()
        loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
    end
})

scriptsTab:CreateSection({
    Title = "Trending Script Hubs"
})

scriptsTab:CreateButton({
    Title = "Redz Hub",
    Desc = "Blox Fruits auto-farm king",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedzDev/RedzHub/main/RedzHub.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Than Hub",
    Desc = "Keyless auto-win for tons of games",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
    end
})

scriptsTab:CreateButton({
    Title = "DeclareMods",
    Desc = "Fresh 2025 scripts for all hits",
    Callback = function()
        loadstring(game:HttpGet("https://declaremods.com/scripts/DeclareHub.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Owl Hub",
    Desc = "30+ games supported hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
    end
})

scriptsTab:CreateButton({
    Title = "Voidware",
    Desc = "Best 99 NITF script + Multi-games support",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/vapevoidware/main/NewMainScript.lua", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Rift Hub",
    Desc = "BETA auto-play for Fisch & Forsaken",
    Callback = function()
        loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "ThunderZ Hub",
    Desc = "GAG and BloxFruits and more",
    Callback = function()
        _G.ThunderVersion = "Mobile"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ThunderZ-05/HUB/main/Script"))()
    end
})

scriptsTab:CreateButton({
    Title = "HoHo Hub",
    Desc = "Level farm + fruit hunter for BF",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})

scriptsTab:CreateSection({
    Title = "Other Scripts"
})

scriptsTab:CreateButton({
    Title = "Dex Explorer",
    Desc = "explore game internals",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/DEX-Explorer/refs/heads/main/Mobile.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Dex ++",
    Desc = "upgraded dex vibes",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "RemoteSpy",
    Desc = "spy on remotes",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/p0e1/Gg/refs/heads/main/RemoteSpy.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "SimpleSpy",
    Desc = "easy remote logger",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BOXLEGENDARY/SimpleSpyZxL/refs/heads/main/notify.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Mobile Keyboard (Delta)",
    Desc = "delta kb for mobile",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Scripts & AntiCheat Searcher",
    Desc = "find hidden scripts",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Script-searcher-56910"))()
    end
})

scriptsTab:CreateButton({
    Title = "Free Products Sniper",
    Desc = "Some games only",
    Callback = function()
        loadstring(game:HttpGet("https://paste.rs/m0GKH"))()
    end
})

scriptsTab:CreateSection({
    Title = "Chat Bypassers"
})

scriptsTab:CreateButton({
    Title = "BetterBypasser",
    Desc = "Best chat bypasser (has key)",
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Synergy-Networks/products/main/BetterBypasser/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Xeon Chat Bypasser",
    Desc = "AI auto-bypass, says anything",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ProphecySkondo/00152838123b42aac0dc879eb9c47042/raw/fde6a9fc2ed94d03c9ff84360b7cd8929f69ddf7/gistfile1.txt"))()
    end
})

scriptsTab:CreateButton({
    Title = "Cookie Chat Bypasser",
    Desc = "New & strong bypasser",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/mert134/358b6c0b43e67f75dd4c8f1fc17af692/raw/d79af94b05269769e44360e4c4bb4dff5cda2a15/gistfile1.txt"))()
    end
})

scriptsTab:CreateSection({
    Title = "FE Scripts 1"
})

scriptsTab:CreateButton({
    Title = "Open YouTube",
    Desc = "Watch vids without leaving game",
    Callback = function()
        loadstring(game:HttpGet("https://paste.rs/cGICv"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Telekinesis",
    Desc = "Grab & throw stuff",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-Telekinesis-V5-21542"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Become HamsterBall",
    Desc = "Roll around like a hamster",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/unofficial-Projects/FEHamsterBall.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE BlackHole",
    Desc = "Suck everyone in",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/main/BringFlingPlayers"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE ChatSpy",
    Desc = "See private & deleted chats",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dan41/Roblox-Scripts/refs/heads/main/CHAT%20SPY%20-%202025/ChatSpy2025.lua", true))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Egor",
    Desc = "Classic troll animation",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/RybHqGnp", true))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Sharingan",
    Desc = "Naruto eyes go brrr",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/bidQM5Bz"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Inventory Viewer",
    Desc = "See what others have",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/gQNchhrC"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Sandevistan",
    Desc = "Cyberpunk slow-mo",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/idbiRMZG"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Superhero Fly",
    Desc = "Superman fly pose",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XyR6izYv"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Sonic",
    Desc = "Gotta go fast",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/chqPBh9F"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Sonic New",
    Desc = "R15 Sonic X Super",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Azizanzz0/FE-R15-Sonic-X-Super/refs/heads/main/Protected%20SonicXSuper.txt"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Ragdoll",
    Desc = "Flop around",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/shakk-code/fe-ragdoll-script/refs/heads/main/script.lua", true))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Punch NPC",
    Desc = "One punch man",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/wJy7ksD0"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Drift Car",
    Desc = "Tokyo drift in Roblox",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AstraOutlight/my-scripts/refs/heads/main/fe%20car%20v3"))()
    end
})

scriptsTab:CreateButton({
    Title = "Become Steve & Play Minecraft",
    Desc = "Minecraft in Roblox",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Biem6ondo/mc/refs/heads/main/STARTUP"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Become Dog",
    Desc = "Woof woof",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/WyqDmp0t"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Fake IP Logger",
    Desc = "Scare noobs",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/rpmS1eWX"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Invisible VoiceChat Troll",
    Desc = "Snail limbs + voice troll",
    Callback = function()
        _G.Snail_Config = {
            Speed = 0.4,
            TunnelSpeed = 1,
            Offset = CFrame.new(0,3,0),
            TunnelOffset = CFrame.new(0,-6,0),
            Teleport = Enum.KeyCode.E,
            Tunnel = Enum.KeyCode.Q,
            ResetCamera = Enum.KeyCode.R,
            TunnelIsToggle = true,
            DistanceChangesSpeed = true,
            UseCameraRotaton = false,
            Distance = 5,
            Enabled = true,
            Sounds = true,
            Audios = { Teleport = { SoundId = 507863457 } },
            Max_Height = 15,
            Root_Height = 4,
        }
        if _G.Snail_Ran then return end
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MastersMZ-Scripts/Scripts/main/Snail%20Script/Snail%20Limbs%20Version.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Float Tools (Press J)",
    Desc = "idk",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/DDK5Ek1A"))()
    end
})

scriptsTab:CreateButton({
    Title = "Desync",
    Desc = "Lag on others' screens only",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/8zQ57jls/raw"))()
    end
})

scriptsTab:CreateSection({
    Title = "FE Scripts 2"
})

scriptsTab:CreateButton({
    Title = "FE Browser (Mobile Only)",
    Desc = "Surf the web in-game",
    Callback = function()
        loadstring(game:HttpGet("https://paste.rs/Fe5G7"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Trolling GUI",
    Desc = "Ultimate troll menu",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Tool Giver",
    Desc = "Give anyone any tool",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Animations Hub (R6/R15)",
    Desc = "1000+ animations",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Dvrknvss/UniversalFEScriptHub/main/UFE'))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Animations Player",
    Desc = "Play any animation ID",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Idk12384/Animation-Player-Script/refs/heads/main/Main%20Code"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Super Lag",
    Desc = "Crash the server (use wisely)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GBmWn4eZ", true))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Gun",
    Desc = "Hat-based gun (equip hats first)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/pYMbRb7w"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Control NPC",
    Desc = "Take over any NPC",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Jerk Off R6",
    Desc = "Classic R6 troll",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/imalwaysad/universal-gui/refs/heads/main/jerk%20off%20r6"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Invisible",
    Desc = "Seat method lol",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Invisible V2",
    Desc = "True Invisibility",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/refs/heads/main/Invisible%20Mode'))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Invisible V3",
    Desc = "You can even kill ppl with tool with this invis",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/Invis/refs/heads/main/Invistoggle", true))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Equip Multiple Tools",
    Desc = "Hold 10+ tools at once",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/MultiToolsV1/main/script"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Face Bang R6",
    Desc = "R6 face violation",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-FACEBANG-28199"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Seraphic Blade",
    Desc = "Float angel idk ahh wtf script",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/59mJGQGe/raw"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Ragdoll",
    Desc = "Floppy ragdoll mode",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrArgy/MrArgyRobloxScripts/refs/heads/main/ragdoll_buttons_secured.txt"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Rewind",
    Desc = "Reverse your movements",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/L"))()
    end
})

scriptsTab:CreateButton({
    Title = "FE Google Translate",
    Desc = "Speak many languages like a polygot",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/refs/heads/main/Translator'))()
    end
})

scriptsTab:CreateSection({
    Title = "Executors"
})

scriptsTab:CreateButton({
    Title = "Trigon Executor (OLD)",
    Desc = "Classic Trigon UI",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/Trigon/refs/heads/main/Trigon.txt"))()
    end
})

scriptsTab:CreateButton({
    Title = "Codex Executor (NEW)",
    Desc = "2025 clean executor",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CodexScripts/CodexUI/refs/heads/main/CodexMain"))()
    end
})

scriptsTab:CreateButton({
    Title = "Delta Executor (NEW)",
    Desc = "Delta new, fully working",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/iXvqMv4G/raw", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Arceus X (OLD)",
    Desc = "OG mobile executor",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Arceus-X-Executor-22878"))()
    end
})

scriptsTab:CreateButton({
    Title = "KRNL (OLD)",
    Desc = "Classic KRNL remake",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wtfplayer/redemption/main/krnlnoui.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Hydrogen (Remake)",
    Desc = "Remade hydrogen", 
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dnezero/hydrogen_remake/refs/heads/main/.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Synapse X",
    Desc = "Synapse X reborn UI",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/tB1McyJv/raw"))()
    end
})

scriptsTab:CreateSection({
    Title = "Flix - Game scripts"
})

scriptsTab:CreateButton({
    Title = "99 Nights In The Forest - Flix",
    Desc = "GOD Mode, Auto Day Farm, Kill Aura, etc",
    Callback = function()
        loadstring(game:HttpGet('https://pastefy.app/EFLiQVp7/raw'))()
    end
})

scriptsTab:CreateSection({
    Title = "Game scripts"
})

scriptsTab:CreateButton({
    Title = "Blox Fruits - Redz Hub",
    Desc = "auto-farm, raids, fruit finder",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RedzDev/RedzHub/main/RedzHub.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Arsenal - Speed Hub X",
    Desc = "aimbot, ESP, no recoil",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed Hub X.lua", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Dress to Impress - Auto Farm",
    Desc = "auto outfits, vote boost",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusTheStar/SiriusScripts/main/Dress%20to%20Impress.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Evade - God Mode",
    Desc = "invincible, auto dodge",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

scriptsTab:CreateButton({
    Title = "Fisch - Rift Hub",
    Desc = "auto-fish, rod upgrader",
    Callback = function()
        loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Pet Sim X - Auto Farm",
    Desc = "egg hatch, pet dupes",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Adopt Me - Auto Gifts",
    Desc = "pet farm, bucks grind",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndle/AdoptMeScript/main/AdoptMe.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Brookhaven - Teleports",
    Desc = "house tp, money giver",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BrookehavenScripts/Brookhaven/main/Brookhaven.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "MM2 - ESP & Gun Mods",
    Desc = "knife aura, gun reach",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MurderMystery2Scripts/MM2/main/MM2.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Jailbreak - Car ESP",
    Desc = "vehicle farm, cop tools",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JailbreakScripts/Jailbreak/main/Jailbreak.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "TSB - Speed Hub",
    Desc = "auto combos, ESP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed Hub X.lua", true))()
    end
})

scriptsTab:CreateButton({
    Title = "Anime Vanguards - Auto Farm",
    Desc = "unit summon, gold grind",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnimeVanguardsScripts/AV/main/AV.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "World of Stands - Auto Quests",
    Desc = "stand farm, arrow finder",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/WorldOfStandsScripts/WOS/main/WOS.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Chained Together - Auto Climb",
    Desc = "rope farm, level skip",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ChainedScripts/Chained/main/Chained.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Plants Evolution - Tora",
    Desc = "Infinite Wins, OP Pets",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/PlantEvolution"))()
    end
})

scriptsTab:CreateButton({
    Title = "Fight in a Supermarket - Tora",
    Desc = "Kill Aura, Auto Cash",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/FightinaSupermarket"))()
    end
})

scriptsTab:CreateButton({
    Title = "Deadly Delivery - Tora",
    Desc = "Auto Find Items, Fast Coins",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadlyDelivery"))()
    end
})

scriptsTab:CreateButton({
    Title = "DUMP script - Me",
    Desc = "Instant Steal, OP Eggs",
    Callback = function()
        loadstring(game:HttpGet("https://paste.rs/vH4OJ"))()
    end
})

scriptsTab:CreateButton({
    Title = "Tank Game - Tora",
    Desc = "Max Speed, Auto Upgrades",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/TankGame"))()
    end
})

scriptsTab:CreateButton({
    Title = "Blox Loot - Tora",
    Desc = "Mob Hitbox, Auto attack",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/BloxLoot"))()
    end
})

scriptsTab:CreateButton({
    Title = "Dig grandma's backyard - Tora",
    Desc = "Auto secret, mythic, easy cash",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DigGrandmasBackyard"))()
    end
})

scriptsTab:CreateButton({
    Title = "Race Clicker - Auto Click",
    Desc = "speed boost, rebirths",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RaceClickerScripts/RC/main/RC.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "SharkBite 2 - Auto Farm",
    Desc = "boat spawn, shark tp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SharkBiteScripts/SB2/main/SB2.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Death Ball - God Mode",
    Desc = "ball farm, power ups",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DeathBallScripts/DB/main/DB.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Banana Eats - Auto Collect",
    Desc = "banana farm, speed",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BananaEatsScripts/BE/main/BE.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Saber Showdown - Auto Parry",
    Desc = "sword farm, ESP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SaberShowdownScripts/SS/main/SS.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Guts & Blackpowder - God Mode",
    Desc = "zombie farm, weapons",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GutsBlackpowderScripts/GBP/main/GBP.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Grow a Garden - Auto Grow",
    Desc = "plant farm, harvest",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGardenScripts/GAG/main/GAG.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Blade Ball - Auto Parry Hub",
    Desc = "auto parry, spam, no cd",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bababaoooi/blade-ball/main/script.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "BedWars - Voidware",
    Desc = "godmode, kill aura, auto win",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/vapevoidware/main/NewMainScript.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Doors - Nullfire Hub",
    Desc = "auto farm, esp, no clip",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/tHP2wggq"))()
    end
})

scriptsTab:CreateButton({
    Title = "Royale High - Auto Diamonds",
    Desc = "diamond farm, fly, tp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RoyaleHighScripts/RH/main/farm.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Bloxburg - Infinite Money",
    Desc = "auto build, job farm",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/kfnrxDDG"))()
    end
})

scriptsTab:CreateButton({
    Title = "Plants Vs Brainrots - EzHub",
    Desc = "auto farm, auto sell, tp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EzHub/PlantsVsBrainrots/main/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Parkour Champions - Speed Hub",
    Desc = "fly, speed, no clip",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Parkour.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Rivals - Aimbot & ESP",
    Desc = "silent aim, esp, no recoil",
    Callback = function()
        loadstring(game:HttpGet("https://rscripts.net/script/rivals-aimbot-gSfG"))()
    end
})

scriptsTab:CreateButton({
    Title = "Untitled Boxing - BeanZ Hub",
    Desc = "auto dodge, no stun, inf speed",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/acIOGYQ-H_0"))()
    end
})

scriptsTab:CreateButton({
    Title = "Dandy's World - Hex Hub",
    Desc = "auto farm, esp, fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HexHub/Dandys/main/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "99 Nights Forest - Survival Hub",
    Desc = "godmode, auto craft, tp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SurvivalHub/99Nights/main/script.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Steal a Brainrot - Piska Hub",
    Desc = "auto steal, speed, esp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PiskaHub/Brainrot/main/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Toilet TD - Auto Farm",
    Desc = "auto place, money farm",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TTDHub/ToiletTD/main/farm.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Bee Swarm - Auto Hive",
    Desc = "auto pollen, honey farm",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BeeSwarmScripts/BSS/main/hub.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Phantom Forces - Aimbot",
    Desc = "silent aim, esp, no spread",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PFScripts/Phantom/main/aimbot.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Counter Blox - CBX Hub",
    Desc = "aimbot, wallhack, rage",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CBXHub/CounterBlox/main/loader.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Ability Wars - Auto Farm",
    Desc = "ability dupe, cash grind",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AWHub/AbilityWars/main/farm.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Blackrock Mountain - God Mode",
    Desc = "invincible, auto climb",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BRMHub/Blackrock/main/godmode.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "Nat Disaster Surv - NDS Hub",
    Desc = "fly, tp, godmode",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NDSHub/Survival/main/hub.lua"))()
    end
})

scriptsTab:CreateButton({
    Title = "MeepCity - Auto Rebirth",
    Desc = "coins, pets, houses",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MeepHub/MeepCity/main/rebirth.lua"))()
    end
})
