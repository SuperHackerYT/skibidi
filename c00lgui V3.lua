-- // Please Dont Skid This, My Mom Is Kinda Homeless \\ --

local UI = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/SuperHackerYT/skibidi/refs/heads/main/c00lui.lua"
))()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local win = UI:CreateWindow("FE c00lgui V3 By Elvis")
local move = win:CreateTab("Movement")

move:AddInput("WalkSpeed", function(v)
    local n = tonumber(v)
    if n and lp.Character then
        lp.Character.Humanoid.WalkSpeed = n
    end
end)

move:AddInput("JumpPower", function(v)
    local n = tonumber(v)
    if n and lp.Character then
        lp.Character.Humanoid.JumpPower = n
    end
end)

move:AddInput("Gravity", function(v)
    local n = tonumber(v)
    if n then
        workspace.Gravity = n
    end
end)

local infJump = false
move:AddToggle("Infinite Jump", false, function(state)
    infJump = state
end)

UIS.JumpRequest:Connect(function()
    if infJump and lp.Character then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local noclip = false
move:AddToggle("Noclip", false, function(state)
    noclip = state
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip and lp.Character then
        for _,v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- <<<<< FLY STUFF >>>>> --

-- Fly
local flyToggle = false
local flySpeed = 1
local FLYING = false
local flyKeyDown, flyKeyUp, mfly1, mfly2
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- PC Fly
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

-- Stop fly
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

-- Mobile Fly
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

-- UnMobileFly
local function UnMobileFly()
local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
if root then
    if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
    if root:FindFirstChild("BodyGyro") then root.BodyGyro:Destroy() end
end
end

-- // Fly \\ --
move:AddToggle("Fly", false, function(state)
        flyToggle = state
        if flyToggle then
            if game:GetService("UserInputService").TouchEnabled then
                MobileFly()
            else
                sFLY()
            end
        else
            NOFLY()
            UnMobileFly()
        end
end)

local Combat = win:CreateTab("Combat")

Combat:AddButton("Kill All (Unanchored Parts Need In Game)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ily-neo/neos-repo/refs/heads/main/projects/FE%20Kill%20All.lua"))()
end)

Combat:AddButton("Fling All (Needs Player Collision)", function()
    loadstring(game:HttpGet("https://paste.rs/Z0TY0"))()
end)

Combat:AddButton("Instant Kill Sword", function()
local range = 10
 
local player = game:GetService("Players").LocalPlayer
 
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players:GetPlayers()
    for i = 2, #p do local v = p[i].Character
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
                for i,v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        firetouchinterest(tool.Handle,v,0)
                        firetouchinterest(tool.Handle,v,1)
                    end
                end
            end
        end
    end
end)
end)

Combat:AddButton("Grab & Kill NPC (R6)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GUI-Offical/FileTest/refs/heads/main/Grab%20R6.txt", true))()
end)

Combat:AddButton("Punch Fling (R15)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fedoratums/Base-Script/Base-Script/fedoratum punch fling",true))()
end)


Combat:AddButton("Seraphic Blade (R15)", function()
    loadstring(game:HttpGet("https://pastefy.app/59mJGQGe/raw"))()
end)

local ds = win:CreateTab("Destruction")

ds:AddButton("Kick All", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ZXAZyL3q",true))()
end)

ds:AddButton("Crash Server (In ingame Avatar Catalog support games)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/stellar-dv/stellar/refs/heads/main/crashv2.txt"))()
end)

ds:AddButton("Blackhole (Need unanchored parts in game)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/deprivationist/Sypher-Hub-NDS/refs/heads/main/Sypher%20Hub%20NDS.txt"))()
end)

ds:AddButton("F3X Server Destruction (Need F3X)", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/FgMrTkpq'))()
end)

ds:AddButton("John Doe", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-John-doe-46160"))()
end)

ds:AddButton("Flip World", function()
    for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("BasePart") and not obj.Anchored then
		obj.Anchored = true
	end
	if obj:IsA("BasePart") then
		local pos = obj.Position
		local rot = obj.Orientation

		obj.Position = Vector3.new(pos.X, -pos.Y, pos.Z)
		obj.Orientation = Vector3.new(-rot.X, rot.Y + 180, -rot.Z)
	end
end

if workspace:FindFirstChild("Camera") then
	local cam = workspace.CurrentCamera
	cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(180), 0, 0)
end
end)

local ut = win:CreateTab("Utility")

ut:AddButton("GOD Mode (On kill bricks)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/eD8HBXGS",true))()
end)

ut:AddButton("ESP", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/cool83birdcarfly02six/UNIVERSALESPLTX/main/README.md'),true))()
end)

ut:AddButton("Teleport Tool", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Teleport-tool-7095",true))()
end)

ut:AddButton("Unban Voicechat", function()
     voiceChatService = game:GetService("VoiceChatService")
     voiceChatService:joinVoice()
end)

ut:AddButton("Tool Giver", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Game-tool-giver-12133"))()
end)

ut:AddButton("View Others", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/hDd6w1iK",true))()
end)