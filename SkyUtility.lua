local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/SuperHackerYT/skibidi/refs/heads/main/SkyUI.txt"))()

local MainTab = UI:AddTab({Name = "Main"})
local OthersTab = UI:AddTab({Name = "Others"})

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TPService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

local infiniteJumpEnabled = false
local speedBoostEnabled = false
local speedMultiplier = 2
local xrayEnabled = false
local noclipCamEnabled = false
local noCollisionEnabled = false
local animationFrozen = false
local originalWalkspeed = Humanoid.WalkSpeed
local originalJumpPower = Humanoid.JumpPower
local originalJumpEnabled = true
local frozen = false
local nightMode = false
local originalBrightness = Lighting.Brightness
local originalFogEnd = Lighting.FogEnd

MainTab:AddButton({
    Name = "Infinite Jump",
    Callback = function()
        infiniteJumpEnabled = not infiniteJumpEnabled
        if infiniteJumpEnabled then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Infinite Jump",
                Text = "Enabled",
                Duration = 2
            })
            
            local connection
            connection = UIS.JumpRequest:Connect(function()
                if infiniteJumpEnabled then
                    Humanoid:ChangeState("Jumping")
                else
                    connection:Disconnect()
                end
            end)
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Infinite Jump",
                Text = "Disabled",
                Duration = 2
            })
        end
    end
})

MainTab:AddButton({
    Name = "Noclip",
    Callback = function()
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Noclip",
            Text = "Enabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Clip",
    Callback = function()
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Clip",
            Text = "Enabled (Collision On)",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Boost Speed",
    Callback = function()
        speedBoostEnabled = not speedBoostEnabled
        if speedBoostEnabled then
            Humanoid.WalkSpeed = originalWalkspeed * speedMultiplier
            game.StarterGui:SetCore("SendNotification", {
                Title = "Speed Boost",
                Text = "Enabled",
                Duration = 2
            })
        else
            Humanoid.WalkSpeed = originalWalkspeed
            game.StarterGui:SetCore("SendNotification", {
                Title = "Speed Boost",
                Text = "Disabled",
                Duration = 2
            })
        end
    end
})

MainTab:AddButton({
    Name = "Super Jump",
    Callback = function()
        Humanoid.JumpPower = 100
        game.StarterGui:SetCore("SendNotification", {
            Title = "Super Jump",
            Text = "Jump power set to 100",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Rejoin",
    Callback = function()
        TPService:Teleport(game.PlaceId, Player)
    end
})

MainTab:AddButton({
    Name = "AntiAFK",
    Callback = function()
        local VirtualUser = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        game.StarterGui:SetCore("SendNotification", {
            Title = "AntiAFK",
            Text = "Enabled - Will not kick for AFK",
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "AntiLag",
    Callback = function()
        settings().Rendering.QualityLevel = 1
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") then
                effect.Enabled = false
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "AntiLag",
            Text = "Graphics optimized for performance",
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "AntiKick",
    Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        
        getgenv().Anti = true
        
        local Anti
        Anti = hookmetamethod(game, "__namecall", function(self, ...)
            if self == plr and getnamecallmethod():lower() == "kick" and getgenv().Anti then
                return warn("[ANTI-KICK] Client Tried To Call Kick Function On LocalPlayer")
            end
            return Anti(self, ...)
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "AntiKick",
            Text = "Enabled - Prevents local player kicks",
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "AntiBan",
    Callback = function()
        local X;
        X = hookmetamethod(game, "__namecall", function(self, ...)
           if getnamecallmethod() == "Ban" then
               local eval1 = {false}
               local eval2 = {false}
               local args = {...}
               if debug.validlevel(3) and self.Parent == nil then
                   local stack = debug.getstack(3)
                   local counter = 0
                   local expected;
                   for i,v in pairs(stack) do
                       if v == game.Players.LocalPlayer.Name or v == "Ban" or v == "Packet" or v == "Network" then
                           counter = counter + 1
                       elseif type(v) == "number" then
                           if type(expected) == "number" then
                               expected = expected + v
                           else
                               expected = v
                           end
                       end
                   end
                   if counter == expected then
                       eval1 = {true, counter+5}
                   end
               end
               if eval1[1] then
                   if #args == eval1[2] then
                       local counter = 0
                       local outgoingkey;
                       for i,v in pairs(args) do
                           if v == game.Players.LocalPlayer.Name or v == "Ban" or v == "Packet" or v == "Network" then
                               counter = counter + 1
                           elseif tostring(i) == "userdata: 0x000000001bdfb8ea" then --current outgoing key address, could change if roblox updates
                               outgoingkey = v
                           end
                           if counter == eval1[2] then
                               eval2 = {true, outgoingkey}
                           end
                       end
                   end
                   if eval2[1] then
                       game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0, outgoingkey) --stops ban packets (requires outgoing key to set it to 0)
                       game.Players.LocalPlayer:Kick("Game attempted to ban you but was blocked") --kicked because it'll detect the namecall being blocked
                       return wait(9e9)
                   end
               end
           end
           return X(self, ...)
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "AntiBan",
            Text = "Enabled - Attempts to block ban attempts",
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "Night",
    Callback = function()
        Lighting.ClockTime = 0
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Night",
            Text = "Time set to night",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Day",
    Callback = function()
        Lighting.ClockTime = 14
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Day",
            Text = "Time set to day",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Equip Tools",
    Callback = function()
        for _, tool in pairs(Player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                Humanoid:EquipTool(tool)
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Tools",
            Text = "All tools equipped",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Drop Tools",
    Callback = function()
        for _, tool in pairs(Character:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = workspace
                tool.Handle.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Tools",
            Text = "Tools dropped",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Check Health",
    Callback = function()
        local health = Humanoid.Health
        local maxHealth = Humanoid.MaxHealth
        game.StarterGui:SetCore("SendNotification", {
            Title = "Health Check",
            Text = string.format("Health: %.1f/%.1f", health, maxHealth),
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "Show InvisParts",
    Callback = function()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency > 0.5 then
                part.Transparency = 0.5
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Invisible Parts",
            Text = "Made semi-transparent parts visible",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Hide InvisParts",
    Callback = function()
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency == 0.5 then
                part.Transparency = 1
            end
        end
    end
})

MainTab:AddButton({
    Name = "Reset",
    Callback = function()
        Humanoid.Health = 0
    end
})

MainTab:AddButton({
    Name = "Goto Camera",
    Callback = function()
        Character.HumanoidRootPart.CFrame = Camera.CFrame
    end
})

MainTab:AddButton({
    Name = "Goto Spawn",
    Callback = function()
        local spawnLocation = Player:GetJoinData().SpawnLocation
        if spawnLocation then
            Character.HumanoidRootPart.CFrame = CFrame.new(spawnLocation)
        else
            Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        end
    end
})

MainTab:AddButton({
    Name = "Xray On",
    Callback = function()
        xrayEnabled = true
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency ~= 1 then
                part.LocalTransparencyModifier = 0.5
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Xray",
            Text = "Enabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Xray Off",
    Callback = function()
        xrayEnabled = false
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Xray",
            Text = "Disabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Account Age",
    Callback = function()
        local age = Player.AccountAge
        local years = math.floor(age / 365)
        local days = age % 365
        game.StarterGui:SetCore("SendNotification", {
            Title = "Account Age",
            Text = string.format("%d years, %d days old", years, days),
            Duration = 5
        })
    end
})

MainTab:AddButton({
    Name = "Leave",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

MainTab:AddButton({
    Name = "Spawn Part",
    Callback = function()
        local part = Instance.new("Part")
        part.Size = Vector3.new(5, 5, 5)
        part.Position = Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
        part.BrickColor = BrickColor.Random()
        part.Anchored = true
        part.Parent = workspace
        game.StarterGui:SetCore("SendNotification", {
            Title = "Part Spawned",
            Text = "A random colored part has been spawned",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Freeze Animation",
    Callback = function()
        animationFrozen = true
        for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
        Humanoid:LoadAnimation(Instance.new("Animation")):Play()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Animation",
            Text = "Frozen",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Unfreeze Animation",
    Callback = function()
        animationFrozen = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Animation",
            Text = "Unfrozen",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Noclip Cam",
    Callback = function()
        noclipCamEnabled = not noclipCamEnabled
        if noclipCamEnabled then
            Camera.CameraType = Enum.CameraType.Scriptable
            game.StarterGui:SetCore("SendNotification", {
                Title = "Noclip Camera",
                Text = "Enabled - Camera is now free",
                Duration = 3
            })
        else
            Camera.CameraType = Enum.CameraType.Custom
            game.StarterGui:SetCore("SendNotification", {
                Title = "Noclip Camera",
                Text = "Disabled",
                Duration = 2
            })
        end
    end
})

MainTab:AddButton({
    Name = "Disable Jump",
    Callback = function()
        originalJumpEnabled = Humanoid.JumpPower > 0
        Humanoid.JumpPower = 0
        game.StarterGui:SetCore("SendNotification", {
            Title = "Jump",
            Text = "Disabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Enable Jump",
    Callback = function()
        Humanoid.JumpPower = originalJumpPower
        game.StarterGui:SetCore("SendNotification", {
            Title = "Jump",
            Text = "Enabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Serverhop",
    Callback = function()
        local Http = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local function getServers()
            local servers = {}
            local req = request({
                Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
            })
            if req.Success then
                local body = Http:JSONDecode(req.Body)
                if body and body.data then
                    for _, server in pairs(body.data) do
                        if server.playing < server.maxPlayers and server.id ~= game.JobId then
                            table.insert(servers, server.id)
                        end
                    end
                end
            end
            return servers
        end
        
        local servers = getServers()
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Server Hop",
                Text = "No servers found",
                Duration = 3
            })
        end
    end
})

MainTab:AddButton({
    Name = "Inf Zoom",
    Callback = function()
        Player.CameraMaxZoomDistance = 10000
        Player.CameraMinZoomDistance = 0
        game.StarterGui:SetCore("SendNotification", {
            Title = "Infinite Zoom",
            Text = "Zoom limits removed",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Full Brightness",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Brightness",
            Text = "Set to maximum",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Dark Mode",
    Callback = function()
        nightMode = true
        originalBrightness = Lighting.Brightness
        Lighting.Brightness = 0.2
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Dark Mode",
            Text = "Enabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Undark Mode",
    Callback = function()
        nightMode = false
        Lighting.Brightness = originalBrightness
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Dark Mode",
            Text = "Disabled",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Laydown",
    Callback = function()
        Humanoid.Sit = true
        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-90), 0, 0)
    end
})

MainTab:AddButton({
    Name = "Sit",
    Callback = function()
        Humanoid.Sit = true
    end
})

MainTab:AddButton({
    Name = "Stand",
    Callback = function()
        Humanoid.Sit = false
    end
})

MainTab:AddButton({
    Name = "Count Players",
    Callback = function()
        local count = #game:GetService("Players"):GetPlayers()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Player Count",
            Text = string.format("%d players in server", count),
            Duration = 3
        })
    end
})

MainTab:AddButton({
    Name = "Remove Fog",
    Callback = function()
        originalFogEnd = Lighting.FogEnd
        Lighting.FogEnd = 1000000
        game.StarterGui:SetCore("SendNotification", {
            Title = "Fog",
            Text = "Removed",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Freeze",
    Callback = function()
        frozen = true
        Humanoid.WalkSpeed = 0
        Humanoid.JumpPower = 0
        Humanoid.AutoRotate = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Character",
            Text = "Frozen",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Unfreeze",
    Callback = function()
        frozen = false
        Humanoid.WalkSpeed = originalWalkspeed
        Humanoid.JumpPower = originalJumpPower
        Humanoid.AutoRotate = true
        game.StarterGui:SetCore("SendNotification", {
            Title = "Character",
            Text = "Unfrozen",
            Duration = 2
        })
    end
})

MainTab:AddButton({
    Name = "Underground",
    Callback = function()
        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -100, 0)
    end
})


OthersTab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

OthersTab:AddButton({
    Name = "Btool",
    Callback = function()
        local CloneTool = Instance.new("Tool")
        CloneTool.Name = "Clone"
        CloneTool.ToolTip = "Clone Tool"
        CloneTool.RequiresHandle = false
        CloneTool.Activated:Connect(function()
            local target = Player:GetMouse().Target
            if target then
                local clone = target:Clone()
                clone.Parent = workspace
                clone.Position = target.Position + Vector3.new(5, 0, 0)
            end
        end)
        CloneTool.Parent = Player.Backpack
        
        local DeleteTool = Instance.new("Tool")
        DeleteTool.Name = "Delete"
        DeleteTool.ToolTip = "Delete Tool"
        DeleteTool.RequiresHandle = false
        DeleteTool.Activated:Connect(function()
            local target = Player:GetMouse().Target
            if target and target ~= workspace.Terrain then
                target:Destroy()
            end
        end)
        DeleteTool.Parent = Player.Backpack
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "Btools",
            Text = "Clone and Delete tools added to backpack",
            Duration = 3
        })
    end
})

OthersTab:AddButton({
    Name = "FPS Check",
    Callback = function()
        local fps = 1 / RunService.RenderStepped:Wait()
        game.StarterGui:SetCore("SendNotification", {
            Title = "FPS",
            Text = string.format("Current FPS: %d", math.floor(fps)),
            Duration = 3
        })
    end
})

OthersTab:AddButton({
    Name = "Teleport GUI",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Minimize = Instance.new("TextButton")
        local Close = Instance.new("TextButton")
        local SaveBtn = Instance.new("TextButton")
        local TeleportBtn = Instance.new("TextButton")
        local CoordInput = Instance.new("TextBox")
        
        ScreenGui.Parent = CoreGui
        ScreenGui.Name = "TeleportGUI"
        
        local UserInputService = game:GetService("UserInputService")
        local dragging
        local dragInput
        local dragStart
        local startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        Frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = Frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
        
        Frame.Size = UDim2.new(0, 300, 0, 200)
        Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Active = true
        Frame.Draggable = true
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.Text = "Teleport GUI"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.Parent = Frame
        
        Minimize.Size = UDim2.new(0, 30, 0, 30)
        Minimize.Position = UDim2.new(1, -60, 0, 0)
        Minimize.Text = "_"
        Minimize.Parent = Title
        
        Close.Size = UDim2.new(0, 30, 0, 30)
        Close.Position = UDim2.new(1, -30, 0, 0)
        Close.Text = "X"
        Close.Parent = Title
        
        CoordInput.Size = UDim2.new(0.8, 0, 0, 30)
        CoordInput.Position = UDim2.new(0.1, 0, 0.3, 0)
        CoordInput.PlaceholderText = "X, Y, Z coordinates"
        CoordInput.Text = ""
        CoordInput.Parent = Frame
        
        SaveBtn.Size = UDim2.new(0.35, 0, 0, 30)
        SaveBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
        SaveBtn.Text = "Save Position"
        SaveBtn.Parent = Frame
        
        TeleportBtn.Size = UDim2.new(0.35, 0, 0, 30)
        TeleportBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
        TeleportBtn.Text = "Teleport"
        TeleportBtn.Parent = Frame
        
        SaveBtn.MouseButton1Click:Connect(function()
            local pos = Character.HumanoidRootPart.Position
            CoordInput.Text = string.format("%d, %d, %d", pos.X, pos.Y, pos.Z)
        end)
        
        TeleportBtn.MouseButton1Click:Connect(function()
            local coords = CoordInput.Text:gsub(" ", ""):split(",")
            if #coords == 3 then
                local x, y, z = tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3])
                if x and y and z then
                    Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
                end
            end
        end)
        
        Minimize.MouseButton1Click:Connect(function()
            Frame.Visible = not Frame.Visible
        end)
        
        Close.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
    end
})

OthersTab:AddButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infiniteeee/dex/main/out.lua"))()
    end
})

OthersTab:AddButton({
    Name = "ESP",
    Callback = function()
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= Player and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP_Highlight"
                highlight.Adornee = player.Character
                highlight.Parent = player.Character
                
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP_Info"
                billboard.Adornee = player.Character:WaitForChild("Head")
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.Text = player.Name
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.new(1, 1, 1)
                nameLabel.Parent = billboard
                
                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.TextColor3 = Color3.new(1, 1, 1)
                distanceLabel.Parent = billboard
                
                billboard.Parent = player.Character
                
                game:GetService("RunService").Heartbeat:Connect(function()
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local distance = (Player.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        distanceLabel.Text = string.format("Distance: %.1f studs", distance)
                    end
                end)
            end
        end
    end
})

OthersTab:AddButton({
    Name = "Collision",
    Callback = function()
        noCollisionEnabled = false
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Collision",
            Text = "Enabled",
            Duration = 2
        })
    end
})

OthersTab:AddButton({
    Name = "No Collision",
    Callback = function()
        noCollisionEnabled = true
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        game.StarterGui:SetCore("SendNotification", {
            Title = "Collision",
            Text = "Disabled",
            Duration = 2
        })
    end
})

OthersTab:AddButton({
    Name = "AutoClicker",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Minimize = Instance.new("TextButton")
        local Close = Instance.new("TextButton")
        local ToggleBtn = Instance.new("TextButton")
        local SpeedLabel = Instance.new("TextLabel")
        local SpeedSlider = Instance.new("TextBox")
        
        ScreenGui.Parent = CoreGui
        ScreenGui.Name = "AutoClickerGUI"
        
        Frame.Size = UDim2.new(0, 250, 0, 150)
        Frame.Position = UDim2.new(0.5, -125, 0.3, 0)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Active = true
        Frame.Draggable = true
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.Text = "Auto Clicker"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.Parent = Frame
        
        Minimize.Size = UDim2.new(0, 30, 0, 30)
        Minimize.Position = UDim2.new(1, -60, 0, 0)
        Minimize.Text = "_"
        Minimize.Parent = Title
        
        Close.Size = UDim2.new(0, 30, 0, 30)
        Close.Position = UDim2.new(1, -30, 0, 0)
        Close.Text = "X"
        Close.Parent = Title
        
        ToggleBtn.Size = UDim2.new(0.6, 0, 0, 40)
        ToggleBtn.Position = UDim2.new(0.2, 0, 0.3, 0)
        ToggleBtn.Text = "Start AutoClicker"
        ToggleBtn.Parent = Frame
        
        SpeedLabel.Size = UDim2.new(0.6, 0, 0, 20)
        SpeedLabel.Position = UDim2.new(0.2, 0, 0.7, 0)
        SpeedLabel.Text = "Clicks per second:"
        SpeedLabel.BackgroundTransparency = 1
        SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
        SpeedLabel.Parent = Frame
        
        SpeedSlider.Size = UDim2.new(0.2, 0, 0, 25)
        SpeedSlider.Position = UDim2.new(0.7, 0, 0.7, 0)
        SpeedSlider.Text = "10"
        SpeedSlider.Parent = Frame
        
        local clicking = false
        local connection
        
        ToggleBtn.MouseButton1Click:Connect(function()
            clicking = not clicking
            if clicking then
                ToggleBtn.Text = "Stop AutoClicker"
                local cps = tonumber(SpeedSlider.Text) or 10
                
                connection = game:GetService("RunService").Heartbeat:Connect(function()
                    local mouse = Player:GetMouse()
                    if mouse.Target then
                        mouse1click()
                    end
                end)
            else
                ToggleBtn.Text = "Start AutoClicker"
                if connection then
                    connection:Disconnect()
                end
            end
        end)
        
        Minimize.MouseButton1Click:Connect(function()
            Frame.Visible = not Frame.Visible
        end)
        
        Close.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            if connection then
                connection:Disconnect()
            end
        end)
    end
})

game:GetService("RunService").Stepped:Connect(function()
    if noclipCamEnabled then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    if noCollisionEnabled then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

OthersTab:AddButton({
    Name = "Spectate GUI",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
        local MainFrame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local MinimizeBtn = Instance.new("TextButton")
        local CloseBtn = Instance.new("TextButton")
        local PlayersFrame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")
        local StopSpectateBtn = Instance.new("TextButton")
        
        ScreenGui.Parent = CoreGui
        ScreenGui.Name = "SpectateGUI"
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        MainFrame.Size = UDim2.new(0, 300, 0, 350)
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
        MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        MainFrame.BorderSizePixel = 0
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = MainFrame
        
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Title.Text = "Spectate Players"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 14
        Title.Parent = MainFrame
        
        MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
        MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)
        MinimizeBtn.Text = "_"
        MinimizeBtn.BackgroundTransparency = 1
        MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeBtn.Font = Enum.Font.GothamBold
        MinimizeBtn.TextSize = 18
        MinimizeBtn.Parent = Title
        
        CloseBtn.Size = UDim2.new(0, 30, 0, 30)
        CloseBtn.Position = UDim2.new(1, -30, 0, 0)
        CloseBtn.Text = "X"
        CloseBtn.BackgroundTransparency = 1
        CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 14
        CloseBtn.Parent = Title
        
        PlayersFrame.Size = UDim2.new(0.9, 0, 0, 250)
        PlayersFrame.Position = UDim2.new(0.05, 0, 0.12, 0)
        PlayersFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        PlayersFrame.BorderSizePixel = 0
        PlayersFrame.ScrollBarThickness = 6
        PlayersFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        PlayersFrame.Parent = MainFrame
        
        UIListLayout.Parent = PlayersFrame
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.Name
        UIListLayout.Padding = UDim.new(0, 5)
        
        UIPadding.Parent = PlayersFrame
        UIPadding.PaddingTop = UDim.new(0, 5)
        UIPadding.PaddingLeft = UDim.new(0, 5)
        UIPadding.PaddingRight = UDim.new(0, 5)
        
        StopSpectateBtn.Size = UDim2.new(0.8, 0, 0, 35)
        StopSpectateBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
        StopSpectateBtn.Text = "Stop Spectating"
        StopSpectateBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        StopSpectateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        StopSpectateBtn.Font = Enum.Font.GothamBold
        StopSpectateBtn.TextSize = 14
        StopSpectateBtn.Parent = MainFrame
        
        local StopBtnCorner = Instance.new("UICorner")
        StopBtnCorner.CornerRadius = UDim.new(0, 6)
        StopBtnCorner.Parent = StopSpectateBtn
        
        local function createPlayerButton(player)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 40)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Text = player.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Font = Enum.Font.Gotham
            button.TextSize = 12
            button.AutoButtonColor = true
            button.Parent = PlayersFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button
            
            local accountAge = player.AccountAge
            local years = math.floor(accountAge / 365)
            local days = accountAge % 365
            
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                button.Text = string.format("%s (%dy %dd)", player.Name, years, days)
            end)
            
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                button.Text = player.Name
            end)
            
            button.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local originalCameraType = Camera.CameraType
                    local originalSubject = Camera.CameraSubject
                    
                    Camera.CameraType = Enum.CameraType.Custom
                    Camera.CameraSubject = player.Character:FindFirstChild("Humanoid") or player.Character:WaitForChild("Humanoid")
                    
                    for _, btn in pairs(PlayersFrame:GetChildren()) do
                        if btn:IsA("TextButton") then
                            if btn == button then
                                btn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                            else
                                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                            end
                        end
                    end
                    
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Spectating",
                        Text = "Now spectating: " .. player.Name,
                        Duration = 3
                    })
                    
                    StopSpectateBtn.MouseButton1Click:Connect(function()
                        Camera.CameraType = originalCameraType
                        Camera.CameraSubject = originalSubject
                        
                        for _, btn in pairs(PlayersFrame:GetChildren()) do
                            if btn:IsA("TextButton") then
                                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                            end
                        end
                        
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "Spectating",
                            Text = "Stopped spectating",
                            Duration = 3
                        })
                    end)
                else
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Player has no character",
                        Duration = 2
                    })
                end
            end)
        end
        
        local function populatePlayers()
            for _, child in pairs(PlayersFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= Player then
                    createPlayerButton(player)
                end
            end
            
            PlayersFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
        end
        
        populatePlayers()
        
        local RefreshBtn = Instance.new("TextButton")
        RefreshBtn.Size = UDim2.new(0, 30, 0, 30)
        RefreshBtn.Position = UDim2.new(0.9, -35, 0.12, 0)
        RefreshBtn.Text = "↻"
        RefreshBtn.BackgroundTransparency = 1
        RefreshBtn.TextColor3 = Color3.fromRGB(100, 200, 100)
        RefreshBtn.Font = Enum.Font.GothamBold
        RefreshBtn.TextSize = 20
        RefreshBtn.Parent = MainFrame
        
        RefreshBtn.MouseButton1Click:Connect(function()
            populatePlayers()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Spectate GUI",
                Text = "Player list refreshed",
                Duration = 2
            })
        end)
        
        MinimizeBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
        
        CloseBtn.MouseButton1Click:Connect(function()
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
            
            ScreenGui:Destroy()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Spectate GUI",
                Text = "Closed - Camera reset to player",
                Duration = 3
            })
        end)
        
        game:GetService("Players").PlayerAdded:Connect(function(player)
            wait(0.5)
            if player ~= Player then
                createPlayerButton(player)
                PlayersFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
            end
        end)
        
        game:GetService("Players").PlayerRemoving:Connect(function(player)
            for _, button in pairs(PlayersFrame:GetChildren()) do
                if button:IsA("TextButton") and button.Text:find(player.Name) then
                    button:Destroy()
                    PlayersFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
                    break
                end
            end
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "Spectate GUI",
            Text = "GUI opened - Click players to spectate",
            Duration = 4
        })
    end
})

local InfoTab = UI:AddTab({Name = "Info"})

InfoTab:AddButton({
    Name = "Info",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Sky Utility",
            Text = "By SkyArc Development",
            Duration = 7
        })
    end
})

InfoTab:AddButton({
    Name = "Credits",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Credits",
            Text = "Dev - Elvis",
            Duration = 7
        })
    end
})

game.StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded",
    Text = "All features have been loaded successfully!",
    Duration = 5
})