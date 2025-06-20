local ExtencionList = loadstring(game:HttpGet("https://raw.githubusercontent.com/Juanko-Scripts/MoonSecV3Test/refs/heads/main/WhiteFileDetectName"))()

PrefixY = nil
CheckRawnkFunction = nil
if ExtencionList.ForeverHD.CheckRank and workspace:FindFirstChild("HD Admin") and workspace["HD Admin"]:FindFirstChild("Settings") then
GetRankForeverHD = require(workspace["HD Admin"].Settings)
CheckRawnkFunction = GetRankForeverHD.FreeAdmin
end
if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") then
PrefixY = ";"
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Super Hacker YT";
    Text = "Loading Verzion ForeverHD NEW";
    Duration = 10;
})
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
PrefixY = ":"
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Super Hacker YT";
    Text = "Loading Verzion ForeverHD OLD";
    Duration = 10;
})
elseif ExtencionList.ForeverHD.CheckGame then
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Super Hacker YT";
    Text = "Game Not Support ForeverHD";
    Duration = 10;
})
if ExtencionList.ForeverHD.StrictMode then return end
end

spawn(function()
if ExtencionList.ForeverHD.StartFixed then
if game:GetService("CoreGui"):FindFirstChild("HeadsetDisconnectedDialog") then game:GetService("Debris"):AddItem(game:GetService("CoreGui"):FindFirstChild("HeadsetDisconnectedDialog"), 0) end
game:GetService("GuiService"):ClearError()
game:GetService("GuiService"):SetGameplayPausedNotificationEnabled("false")
wait(2)
game:GetService("GuiService"):SetGameplayPausedNotificationEnabled("true")
end
end)

PrivatePremiumGUI = true
if ExtencionList.ScriptMode.Private then
if ExtencionList.ScriptMode.FreePremium then
PrivatePremiumGUI = false
if ExtencionList.ScriptMode.Debug then
print("Mode Private GUI")
end
else
        for _, XP in ipairs(ExtencionList.WhiteList) do
            if gethwid() == XP then 
PrivatePremiumGUI = false
if ExtencionList.ScriptMode.Debug then
print("Mode Private GUI")
end
           break; end
        end
end
else
PrivatePremiumGUI = false
if ExtencionList.ScriptMode.Debug then
print("Mode Free GUI")
end
end
if PrivatePremiumGUI then
game:GetService("Players").LocalPlayer:Kick()
game:GetService("Players").LocalPlayer:Destroy() 
game:Shutdown() 
while true do print("Crash") end
for i = 1, math.huge do print("Crash") end
return 
end

if ExtencionList.ScriptMode.ShutDown then
game:GetService("Players").LocalPlayer:Kick()
game:GetService("Players").LocalPlayer:Destroy() 
game:Shutdown() 
while true do print("Crash") end
for i = 1, math.huge do print("Crash") end
return 
end

local DiscordLib = loadstring(game:HttpGet("https://pastebin.com/raw/KRf0xDXQ"))()
NameTextTitleXP = "Default"
if ExtencionList.ScriptMode.NameTitle == "OriginalText" then
NameTextTitleXP = "ADMIN Abuse GUI | Super Hacker (Elvis) | "..identifyexecutor()..""
else
NameTextTitleXP = ExtencionList.ScriptMode.NameTitle
end
local Win1 = DiscordLib:Window(NameTextTitleXP)
local Tab1 = Win1:Server(ExtencionList.ScriptMode.NameServer, "") 
local TabGuiV1 = Tab1:Channel("INFORMATION")


-- Servicios Mios Como Funciones O Otros --
Players:Chat(PrefixY.."re") -- Carga Funciones De CharacterAdded

-- Fucniones De Control Para Futuras Cosas Agregadas --
AutoReviveXP = false
AntiShowMessageXP = false
ForceShowVisibleCmdbarXP = false
RunServiceCmdbarV2 = nil
WHEIWJDDJA = false
StateCmdBar2 = nil
ABC2 = false
F3X_Path = nil
ThawAntiFreezeIceXP = false
local tool

-- Funciones De CharacterAdded --
local function FucntionExecuteDied(LocalPlayer)
if AutoReviveXP then
Players:Chat(PrefixY.."re")
end
end
Players.LocalPlayer.CharacterAdded:Connect(function(Y)
   Y:WaitForChild("Humanoid").Died:Connect(function()
      FucntionExecuteDied(Players.LocalPlayer)
   end)
end)

-- Funciones De ChildAdded o DesendentAdded
game:GetService("Workspace").ChildAdded:Connect(function(XP)
spawn(function()
if ThawAntiFreezeIceXP then
if XP:IsA("Part") and XP.Name == Players.LocalPlayer.Name.."'s FreezeBlock" then
Players:Chat(PrefixY.."unice")
end
end
end)
spawn(function()
if ABC2 then
if XP:IsA("Model") and XP.Name == Players.LocalPlayer.Name.."'s JailCell" then
Players:Chat(PrefixY.."unjail")
end
end
end)
end)

if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarAppthen") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.Notices.ChildAdded:Connect(function(XP)
if AntiShowMessageXP then
game:GetService("Debris"):AddItem(XP, 0)
end
end)
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.Notices.ChildAdded:Connect(function(XP)
if AntiShowMessageXP then
game:GetService("Debris"):AddItem(XP, 0)
end
end)
end

-- Funciones De ChangeSignnal
if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarAppthen") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.CmdBar:GetPropertyChangedSignal("Visible"):Connect(function()
if ForceShowVisibleCmdbarXP then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.CmdBar.Visible = true
end
end)
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.CmdBar:GetPropertyChangedSignal("Visible"):Connect(function()
if ForceShowVisibleCmdbarXP then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.CmdBar.Visible = true
end
end)
end


-- Loop Function RenderStepped
game:GetService("RunService").RenderStepped:Connect(function()
if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character ~= nil then
if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Building Tools") then
tool = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Building Tools")
F3X_Path = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Building Tools")
elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Building Tools") then
tool = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Building Tools")
F3X_Path = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Building Tools")
elseif true then
F3X_Path = nil
tool = nil
end
end
end)

-- Extra Fucntion ExtencionList Added --
-- ExtencionList.ForeverHD.CheckGame
-- ExtencionList.ForeverHD.StartFixed
-- ExtencionList.ForeverHD.StrictMode
-- ExtencionList.ForeverHD.CheckRank

-- Function Tool F3X --
local module = {}
    local LocalPlayerF3X = Players.LocalPlayer
    local function remoteExecute(args)
if F3X_Path ~= nil and F3X_Path:FindFirstChild("SyncAPI") and F3X_Path.SyncAPI:FindFirstChild("ServerEndpoint") then
 F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
    end
local febypass = {}
    febypass.SetCollision = function(part, boolean)
        remoteExecute({
            [1] = "SyncCollision",
            [2] = { { Part = part, CanCollide = boolean } }
        })
    end

    febypass.SetAnchor = function(boolean, part)
        remoteExecute({
            [1] = "SyncAnchor",
            [2] = { { Part = part, Anchored = boolean } }
        })
    end

    febypass.CreatePart = function(cf, parent)
        remoteExecute({
            [1] = "CreatePart",
            [2] = "Normal",
            [3] = cf,
            [4] = parent or workspace
        })
    end

    febypass.DestroyPart = function(part)
        remoteExecute({
            [1] = "Remove",
            [2] = { part }
        })
    end

    febypass.MovePart = function(part, cf)
        remoteExecute({
            [1] = "SyncMove",
            [2] = { { Part = part, CFrame = cf } }
        })
    end

    febypass.Resize = function(part, size, cf)
        remoteExecute({
            [1] = "SyncResize",
            [2] = { { Part = part, Size = size, CFrame = cf } }
        })
    end


    febypass.AddMesh = function(part)
        remoteExecute({
            [1] = "CreateMeshes",
            [2] = { { Part = part } }
        })
    end

    febypass.SetMesh = function(part, meshid)
        remoteExecute({
            [1] = "SyncMesh",
            [2] = { { Part = part, MeshId = "rbxassetid://"..meshid } }
        })
    end

    febypass.SetTexture = function(part, texid)
        remoteExecute({
            [1] = "SyncMesh",
            [2] = { { Part = part, TextureId = "rbxassetid://"..texid } }
        })
    end

    febypass.SetName = function(part, name)
        remoteExecute({
            [1] = "SetName",
            [2] = { part },
            [3] = name
        })
    end

    febypass.MeshResize = function(part, scale)
        remoteExecute({
            [1] = "SyncMesh",
            [2] = { { Part = part, Scale = scale } }
        })
    end

    febypass.Weld = function(part1, part2, lead)
        remoteExecute({
            [1] = "CreateWelds",
            [2] = { part1, part2 },
            [3] = lead or part1
        })
    end

    febypass.SetLocked = function(part, boolean)
        remoteExecute({
            [1] = "SetLocked",
            [2] = { part },
            [3] = boolean
        })
    end

    febypass.SetTrans = function(part, transparency)
        remoteExecute({
            [1] = "SyncMaterial",
            [2] = { { Part = part, Transparency = transparency } }
        })
    end

    febypass.CreateSpotlight = function(part)
        remoteExecute({
            [1] = "CreateLights",
            [2] = { { Part = part, LightType = "SpotLight" } }
        })
    end

    febypass.SyncLighting = function(part, brightness)
        remoteExecute({
            [1] = "SyncLighting",
            [2] = { { Part = part, Brightness = brightness } }
        })
    end

    febypass.Color = function(part, color)
        remoteExecute({
            [1] = "SyncColor",
            [2] = { { Part = part, Color = color, UnionColoring = false } }
        })
    end

    febypass.SpawnDecal = function(part, face)
        remoteExecute({
            [1] = "CreateTextures",
            [2] = { { Part = part, Face = face, TextureType = "Decal" } }
        })
    end

    febypass.AddDecal = function(part, asset, face)
        remoteExecute({
            [1] = "SyncTexture",
            [2] = { { 
                Part = part, 
                Face = face, 
                TextureType = "Decal",
                Texture = "rbxassetid://"..asset 
            } }
        })
    end

    febypass.CreateFire = function(part)
        remoteExecute({
            [1] = "CreateDecorations",
            [2] = { { Part = part, DecorationType = "Fire" } }
        })
    end
febypass.remoteExecute = remoteExecute

local TabGuiV1 = Tab1:Channel("GAMES")
TabGuiV1:Label("GAMES | GAMES IT WORKS BEST IN")
TabGuiV1:Button("FREE ADMIN 40%", function()
game:GetService("TeleportService"):Teleport(4522347649, Player)
end)
TabGuiV1:Button("Free Owner Admin Abuse 70%", function()
game:GetService("TeleportService"):Teleport(5023687570, Player)
end)
TabGuiV1:Button("Free HeadAdmin 100%", function()
game:GetService("TeleportService"):Teleport(6150462444, Player)
end)
TabGuiV1:Button("Free Owner Admin 80%", function()
game:GetService("TeleportService"):Teleport(8395560237, Player)
end)
TabGuiV1:Button("Free Owner Admin 85%", function()
game:GetService("TeleportService"):Teleport(7415160483, Player)
end)
TabGuiV1:Button("Obby Owner Admin 90%", function()
game:GetService("TeleportService"):Teleport(5976465390, Player)
end)
TabGuiV1:Button("obby free owner admin 90%", function()
game:GetService("TeleportService"):Teleport(14753017334, Player)
end)

TabGuiV1:Label("GAMES | OTHERS / OTROS / ECT")
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") then
TabGuiV1:Button("Menu ForeverHD [Open / Close]", function()
if game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.MainFrame.Visible then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.MainFrame.Visible = false
else
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.MainFrame.Visible = true
end
end)
end
TabGuiV1:Button("Check Rank", function()
if CheckRawnkFunction ~= nil then
spawn(function()
DiscordLib:Notification("ADMIN GUI", "Your Rank | "..CheckRawnkFunction, "Continue")
end)
else
spawn(function()
DiscordLib:Notification("ADMIN GUI", "Not Support Game Rank Detect", "Continue")
end)
end
end)
TabGuiV1:Button("Test Give Admin Find", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Juanko-Scripts/MoonSecV3Test/refs/heads/main/BACKDOOR"))()
end)


local TabGuiV1 = Tab1:Channel("GEARS")
TabGuiV1:Label("GEARS | CONFIG TARGET GIVE GEARS")
GearsTargetAdminGuiJuanko = "me" 
TabGuiV1:Textbox("Target Give Gears", "me", false, function(txt)
GearsTargetAdminGuiJuanko = txt
end) 
TabGuiV1:Label("GEARS | SWORD")
TabGuiV1:Button("Buildermans-Hammer-of-Shimmering-Light", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 53623248")
end)
TabGuiV1:Button("OP Hammer", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 45177979")
end)
TabGuiV1:Button("Fire Sword", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 93136747")
end)
TabGuiV1:Button("Rainbow Periastron Sword", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 159229806")
end)
TabGuiV1:Button("Bone Sword(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 95951291")
end)
TabGuiV1:Button("Hammer Judges(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 1046322934")
end)

TabGuiV1:Label("GEARS | GUNS")
TabGuiV1:Button("Laser Pistol", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 11999279")
end)
TabGuiV1:Button("Triple laser(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 115377964")
end)
TabGuiV1:Button("Tri-Lazer 3000(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 139578207")
end)
TabGuiV1:Button("Black Hole Ray(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 78005009")
end)
TabGuiV1:Button("Platform Producer(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 34898883")
end)
TabGuiV1:Button("Bear Gun(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 90718350")
end)
TabGuiV1:Button("Taser(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 82357123")
end)
TabGuiV1:Button("Bazooka(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 169602103")
end)
TabGuiV1:Button("Rocket launcher(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 67747912")
end)
TabGuiV1:Button("Gravity Hummer(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 33866846")
end)

TabGuiV1:Label("GEARS | THROW")
TabGuiV1:Button("Fire-Extinguisher", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 31839411")
end)
TabGuiV1:Button("Fuse Bomb", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 11563251")
end)
TabGuiV1:Button("Crossbow of the Sea", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 236438668")
end)
TabGuiV1:Button("Gear Divine Horn", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 127506257")
end)
TabGuiV1:Toggle("Spam Divine Horn",false, function(state)
        WOOWIDKSKSK = state
 while WOOWIDKSKSK do
   game:GetService("RunService").Heartbeat:Wait()
game:GetService("Players").LocalPlayer.Character.KOSSGustHorn.RemoteEvent:FireServer("DO THE THING!!!")
   end
end)
TabGuiV1:Button("Gear Snowball", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 19328185")
end)
TabGuiV1:Toggle("Spam Snowballs",false, function(state)
        QIIEUDJSKSKKS = state
 while QIIEUDJSKSKKS do
   game:GetService("RunService").Heartbeat:Wait()
repeat wait() until Players.LocalPlayer.Character
for i,v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
   if v.Name == "Snowball" then
       v.Parent = Players.LocalPlayer.Character
   end
end
   for i,v in pairs (Players.LocalPlayer.Character:GetChildren()) do
       if v.Name == "Snowball" then
           v:Activate()
       end
   end
   end
end)
TabGuiV1:Button("Auto Punch Yourself", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 91360104")
end)
TabGuiV1:Button("Table", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 243788010")
end)
TabGuiV1:Button("Black hole bomb", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 28277486")
end)
TabGuiV1:Button("Scroll(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 125013830")
end)
TabGuiV1:Button("Remote Bomb(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 33383241")
end)
TabGuiV1:Button("Staff of Fire", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 32858741")
end)
TabGuiV1:Button("Thief coin(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 117544573")
end)


TabGuiV1:Label("GEARS | FOOD / COMIDA / POTION / POCION")
TabGuiV1:Button("Bloxy Cola", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 10472779")
end)
TabGuiV1:Button("Healing Potion", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 11419319")
end)
TabGuiV1:Button("Taco", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 15177716")
end)
TabGuiV1:Button("Cheezburger", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 16726030")
end)
TabGuiV1:Button("Ice Cream", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 57902859")
end)


TabGuiV1:Label("GEARS | CAR / OTHERS")
TabGuiV1:Button("Personal Rocketship", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 298085284")
end)
TabGuiV1:Button("Spy All Terrain Vehicle", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 2190019650")
end)
TabGuiV1:Button("Taxi", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 125013849")
end)
TabGuiV1:Button("Rocket Sled", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 327365543")
end)
TabGuiV1:Button("Midnight Motorcycle", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 359179120")
end)



TabGuiV1:Label("GEARS | OTHERS / ECT")
TabGuiV1:Textbox("Give Gear", "212641536", false, function(Value)
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." "..Value.."")
end) 
TabGuiV1:Button("Instant Campfire", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 123234510")
end)
TabGuiV1:Button("Medusa-Head", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 89487934")
end)
TabGuiV1:Button("Lightblox Jar", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 113328094")
end)
TabGuiV1:Button("Torch", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 31839337")
end)
TabGuiV1:Button("Subspace Tripmine", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 11999247")
end)
TabGuiV1:Button("Jetpack", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 31314966")
end)
TabGuiV1:Button("Body Swap Potion", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 78730532")
end)
TabGuiV1:Button("Attack Doge", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 257810065")
end)
TabGuiV1:Button("Overseer Sword Shield", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 223439643")
end)
TabGuiV1:Button("Teddy Bloxbin", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 12848902")
end)
TabGuiV1:Button("Portable Beach", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 162857357")
end)
TabGuiV1:Button("Zombie Protest Sign", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 304721834")
end)
TabGuiV1:Button("Fly Mat", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 225921000")
end)
TabGuiV1:Button("Bombox", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 212641536")
end)
TabGuiV1:Button("Vacuum cleaner", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 84418938")
end)
TabGuiV1:Button("Backet(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 25162389")
end)
TabGuiV1:Button("Hot potato", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 25741198")
end)
TabGuiV1:Button("Spray Paint(OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 80576967")
end)
TabGuiV1:Button("Glove(Half OP)", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 65469882")
end)
TabGuiV1:Button("Za warudo", function()
Players:Chat(PrefixY.."gear "..GearsTargetAdminGuiJuanko.." 71037101")
end)

local TabGuiV1 = Tab1:Channel("ANTI")
TabGuiV1:Label("ANTI | BASIC / ADVANCED / PREVENT")
TabGuiV1:Toggle("Anti Punish",false, function(state)
      ABC1 = state
while ABC1 do
game:GetService("RunService").RenderStepped:Wait()
if Players.LocalPlayer.Character.Parent == nil then
Players:Chat(PrefixY.."respawn")
wait(0.5)
end
end
end)
TabGuiV1:Toggle("Anti Remove ForceField",false, function(state)
      ABC48215 = state
while ABC48215 do
game:GetService("RunService").RenderStepped:Wait()
if Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil then
if not Players.LocalPlayer.Character:FindFirstChildOfClass("ForceField") then
Players:Chat(PrefixY.."ff")
wait(0.5)
end
end
end
end)
TabGuiV1:Toggle("Anti Kill",false, function(Y) -- Anti Kill o Auto Revive
if Y then
AutoReviveXP = true
else
AutoReviveXP = false
end
end)
TabGuiV1:Toggle("Anti Jail",false, function(state) -- Anti Encerrado
if state then
ABC2 = true
Players:Chat(PrefixY.."unjail")
else
ABC2 = false
end
end)
TabGuiV1:Toggle("Anti Freeze",false, function(state) -- Previene Que Alguien Te Congele
      ABC3 = state
Players:Chat(PrefixY.."thaw")
if ABC3 then
ThawAntiFreezeIceXP = true
else
ThawAntiFreezeIceXP = false
end
while ABC3 do
game:GetService("RunService").RenderStepped:Wait()
if Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 then
for _, XP in pairs(Players.LocalPlayer.Character:GetChildren()) do
if XP:IsA("Part") and XP.Anchored ~= false then
XP.Anchored = false
elseif XP:IsA("BasePart") and XP.Anchored ~= false then
XP.Anchored = false
end
end
end
end
end)
TabGuiV1:Toggle("Anti R15",false, function(state) -- Previene Cambio De Modo
      ABC4 = state
while ABC4 do
game:GetService("RunService").RenderStepped:Wait()
if Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 then
if not Players.LocalPlayer.Character:FindFirstChild("Torso") and Players.LocalPlayer.Character:FindFirstChild("LowerTorso") then
Players:Chat(PrefixY.."r6 me")
wait(3) 
end
end
end
end)
TabGuiV1:Toggle("Anti Void",false, function(Y)
if Y then
game.Workspace.FallenPartsDestroyHeight = 0/0
else
game.Workspace.FallenPartsDestroyHeight = -500
end
end)
TabGuiV1:Toggle("Anti Manipulate Client",false, function(Y) -- Anti Modificacion Del Client De Parte De Los Otros
      ABC5 = Y
Players:Chat(PrefixY.."uncontrol")
while ABC5 do
game:GetService("RunService").RenderStepped:Wait()
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
game:GetService("CoreGui").PurchasePromptApp.Enabled = false
game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
game:GetService("GuiService"):ClearError()
game:GetService("GuiService"):SetGameplayPausedNotificationEnabled("false")
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
wait(1)
end
end)
if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") then
TabGuiV1:Toggle("Anti Show Message",false, function(Y) -- Previene Mensajes Span
if Y then
AntiShowMessageXP = true
for _, XP in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.Notices:GetChildren()) do
game:GetService("Debris"):AddItem(XP, 0)
end
else
AntiShowMessageXP = false
end
end)
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
TabGuiV1:Toggle("Anti Show Message",false, function(Y) -- Previene Mensajes Span
if Y then
AntiShowMessageXP = true
for _, XP in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.Notices:GetChildren()) do
game:GetService("Debris"):AddItem(XP, 0)
end
else
AntiShowMessageXP = false
end
end)
end


local TabGuiV1 = Tab1:Channel("OTHERS")
TabGuiV1:Label("OTHERS | PREVENT / MANIPULATE / CLIENT")
TabGuiV1:Button("Remove Raideo", function()
Players:Chat(PrefixY.."music")
Players:Chat(PrefixY.."unwarp")
Players:Chat(PrefixY.."unblur")
end)
if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarAppthen") then
TabGuiV1:Toggle("Force Show Cmdbar V1",false, function(state)
if state then
ForceShowVisibleCmdbarXP = true
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.CmdBar.Visible = true
else
ForceShowVisibleCmdbarXP = false
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface.CmdBar.Visible = false
end
end)
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
TabGuiV1:Toggle("Force Show Cmdbar V1",false, function(state)
if state then
ForceShowVisibleCmdbarXP = true
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.CmdBar.Visible = true
else
ForceShowVisibleCmdbarXP = false
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminGUIs.CmdBar.Visible = false
end
end)
end
if ExtencionList.ForeverHD.CheckGame and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminInterface") and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarAppthen") then
TabGuiV1:Toggle("Force Show Cmdbar V2",false, function(state)
if RunServiceCmdbarV2 == nil then
WHEIWJDDJA = true
RunServiceCmdbarV2 = game:GetService("RunService")
StateCmdBar2 = RunServiceCmdbarV2.RenderStepped:Connect(function()
if WHEIWJDDJA then
if game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CmdBar2XP") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CmdBar2XP").Visible = true
if game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then game:GetService("Debris"):AddItem(game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2"), 0) end
wait(0.5)
elseif game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2").Name = "CmdBar2XP"
wait(0.5) 
elseif not game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then
Players:Chat(PrefixY.."cmdbar2")
wait(0.5)
end
end 
end)
else
StateCmdBar2:Disconnect()
StateCmdBar2 = nil
WHEIWJDDJA = false
RunServiceCmdbarV2 = nil
end
end)
elseif ExtencionList.ForeverHD.CheckGame and game:GetService("CoreGui"):FindFirstChild("TopBarApp") and game:GetService("CoreGui").TopBarApp:FindFirstChild("TopBarApp") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("HDAdminGUIs") then
TabGuiV1:Toggle("Force Show Cmdbar V2",false, function(state)
if RunServiceCmdbarV2 == nil then
WHEIWJDDJA = true
RunServiceCmdbarV2 = game:GetService("RunService")
StateCmdBar2 = RunServiceCmdbarV2.RenderStepped:Connect(function()
if WHEIWJDDJA then
if game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CmdBar2XP") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CmdBar2XP").Visible = true
if game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then game:GetService("Debris"):AddItem(game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2"), 0) end
wait(0.5)
elseif game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then
game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2").Name = "CmdBar2XP"
wait(0.5) 
elseif not game:GetService("Players").LocalPlayer.PlayerGui.HDAdminInterface:FindFirstChild("CommandMenucmdbar2") then
Players:Chat(":cmdbar2")
wait(0.5)
end
end 
end)
else
StateCmdBar2:Disconnect()
StateCmdBar2 = nil
WHEIWJDDJA = false
RunServiceCmdbarV2 = nil
end
end)
end

TabGuiV1:Label("OTHERS | TARGET / ALL / OTHERS / ME / ECT")
SelectModeSetSayXP = "Me"
TabGuiV1:Dropdown("Select Target", {"Others", "Me", "All"}, function(XP)
SelectModeSetSayXP = XP
end) 
TabGuiV1:Textbox("Cmdbar2", "Visible On Logs", false, function(XP)
if SelectModeSetSayXP == "All" then
for i,v in next, game:FindService("Players"):GetPlayers() do
Players:Chat(PrefixY..""..XP.." "..v.Name.."")
end
elseif SelectModeSetSayXP == "Others" then
for i,v in next, game:FindService("Players"):GetPlayers() do
if v ~= game:GetService("Players").LocalPlayer then
Players:Chat(PrefixY..""..XP.." "..v.Name.."")
end
end
elseif SelectModeSetSayXP == "Me" then
for i,v in next, game:FindService("Players"):GetPlayers() do
if v == game:GetService("Players").LocalPlayer then
Players:Chat(PrefixY..""..XP.." "..v.Name.."")
end
end
end
end) 
TabGuiV1:Textbox("Cmdbar3", "Not Working Select Target", false, function(XP)
Players:Chat(PrefixY..""..XP)
end)
TabGuiV1:Label("OTHERS | SCRIPTS CMDS GUI / CMDBAR / HUB")
TabGuiV1:Button("Abuser Server", function()
loadstring(game:HttpGet("https://pastefy.app/t6VuI1zm/raw"))()
end)
TabGuiV1:Button("Fedoratum Admin", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/showcases/main/fedoratumadmin",true))()
end)
TabGuiV1:Button("Silent CMD", function()
loadstring(game:HttpGet("https://pastebin.com/raw/pGe3C71V"))()
end)



local TabGuiV1 = Tab1:Channel("F3X")
TabGuiV1:Label("F3X | GIVE / TOOL / FIXED / BTOOLS")
TabGuiV1:Button("Give Tool", function()
if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character ~= nil then
if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Building Tools") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Building Tools") then
Players:Chat(PrefixY.."give me all")
end
end
end)


TabGuiV1:Label("F3X | ANCHORED / TEST / FREEZE / DROP")
TabGuiV1:Button("UnAnchored Terrain", function()
if F3X_Path == nil then return end
for _, XP in pairs(workspace.Terrain:GetDescendants()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local a = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = false
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(a))
end
end
end)
TabGuiV1:Dropdown("Freeze Players", {"All", "Others", "Me"}, function(Y)
if F3X_Path == nil then return end
if Y == "All" then
for i,v in next, game:FindService("Players"):GetPlayers() do
  if v.Character and v.Character ~= nil then
     for _, XP in pairs(v.Character:GetChildren()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local args = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = true
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
     end
  end
end
elseif Y == "Others" then
for i,v in next, game:FindService("Players"):GetPlayers() do
if v ~= Players.LocalPlayer then
  if v.Character and v.Character ~= nil then
     for _, XP in pairs(v.Character:GetChildren()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local args = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = true
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
     end
  end
end
end
elseif Y == "Me" then
  if Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil then
     for _, XP in pairs(Players.LocalPlayer.Character:GetChildren()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local args = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = true
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
     end
  end
end
end)
TabGuiV1:Button("Freeze All Game", function()
if F3X_Path == nil then return end
for _, XP in pairs(workspace:GetDescendants()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local args = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = true
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
end
end)
TabGuiV1:Button("UnFreeze All Game", function()
if F3X_Path == nil then return end
for _, XP in pairs(workspace:GetDescendants()) do
if XP.ClassName == "Part" or XP.ClassName == "BasePart" then
local args = {
    [1] = "SyncAnchor",
    [2] = {
        [1] = {
            ["Part"] = XP,
            ["Anchored"] = false
        }
    }
}

F3X_Path.SyncAPI.ServerEndpoint:InvokeServer(unpack(args))
end
end
end)

TabGuiV1:Label("F3X | Api / Library / Btools / Build")
TabGuiV1:Textbox("Size Head All", "No Limits Size", false, function(txt)
if F3X_Path == nil then return end
a = tonumber(txt) or 0;
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Head") then
    febypass.SetLocked(v.Character.Head, false)
    febypass.MeshResize(v.Character.Head, Vector3.new(a,a,a))
end
end
end) 
TabGuiV1:Button("Big Head All", function()
if F3X_Path == nil then return end
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Head") then
    febypass.SetLocked(v.Character.Head, false)
    febypass.MeshResize(v.Character.Head, Vector3.new(10,10,10))
end
end
end)
TabGuiV1:Button("Boobs All [R6]", function()
for _, player in ipairs(Players:GetPlayers()) do
if player.Character and player.Character ~= nil and player.Character:FindFirstChild("Humanoid").Health ~= 0 and player.Character:FindFirstChild("HumanoidRootPart") then
    local char = player.Character
    for i,v in char:GetChildren() do
        pcall(function() febypass.SetLocked(v, false) end)
    end

    if not char:FindFirstChild("Boob1") then
        febypass.SetAnchor(true, char.HumanoidRootPart)

        febypass.CreatePart(char:WaitForChild("Torso").CFrame * CFrame.new(-0.5,0.5,-0.5), char)
        febypass.SetName(char.Part, "Boob1")

        febypass.CreatePart(char:WaitForChild("Torso").CFrame * CFrame.new(0.5,0.5,-0.5), char)
        febypass.SetName(char.Part, "Boob2")

        wait(0.2)
        febypass.AddMesh(char.Boob1)
        febypass.AddMesh(char.Boob2)
        febypass.SetMesh(char.Boob1, "5697933202") 
        febypass.SetMesh(char.Boob2, "5697933202")
        febypass.MeshResize(char.Boob1, Vector3.new(0.4,0.4,0.4))
        febypass.MeshResize(char.Boob2, Vector3.new(0.4,0.4,0.4))
        febypass.Color(char.Boob1, char:WaitForChild("Torso").Color)
        febypass.Color(char.Boob2, char:WaitForChild("Torso").Color)
        febypass.Weld(char.Boob1, char.HumanoidRootPart, char.Boob1)
        febypass.Weld(char.Boob2, char.Boob1, char.Boob2)
    end
end
end
end)
TabGuiV1:Button("Ass All [R6]", function()
for _, player in ipairs(Players:GetPlayers()) do
if player.Character and player.Character ~= nil and player.Character:FindFirstChild("Humanoid").Health ~= 0 and player.Character:FindFirstChild("Right Leg") and player.Character:FindFirstChild("Left Leg") then
    local char = player.Character
    if char then
febypass.CreatePart(char["Right Leg"].CFrame * CFrame.new(0, 1, 0.6), char)
        febypass.SetName(char.Part, "Part1")
        
febypass.CreatePart(char["Left Leg"].CFrame * CFrame.new(0, 1, 0.6), char)
        febypass.SetName(char.Part, "Part2")
        
        for _, partName in ipairs({"Part1", "Part2"}) do
            local part = char:FindFirstChild(partName)
            if part then
                febypass.AddMesh(part)
                febypass.SetMesh(part, "5697933202")
                febypass.MeshResize(part, Vector3.new(0.5, 0.5, 0.5))
                febypass.Color(part, char["Right Leg"].Color)
            end
        end
    end
end
end
end)
TabGuiV1:Button("Change Color All", function()
if F3X_Path == nil then return end
    for i,v in game.Workspace:GetDescendants() do
        if v:IsA("BasePart") or v:IsA("Part") then
febypass.Color(v, Color3.new(math.random(), math.random(), math.random()))
        end
    end
end)
TabGuiV1:Textbox("Decal Spam", "Custom Id Decal", false, function(txt)
if F3X_Path == nil then return end
for i,v in game.workspace:GetDescendants() do
    if v:IsA("BasePart") or v:IsA("Part") then
febypass.AddDecal(v, tonumber(txt), Enum.NormalId.Front)
    end
end
end) 
TabGuiV1:Button("Duck All", function()
for _, player in ipairs(Players:GetPlayers()) do
if player.Character and player.Character ~= nil and player.Character:FindFirstChild("Humanoid").Health ~= 0 and player.Character:FindFirstChild("HumanoidRootPart") then
    local char = player.Character
    if char then
        febypass.CreatePart(char.HumanoidRootPart.CFrame, char)
        local duck = char:FindFirstChild("Part")
        if duck then
            febypass.SetName(duck, "Duck")
            febypass.AddMesh(duck)
            febypass.SetMesh(duck, "10749878672") 
            febypass.SetTexture(duck, "10749878886") 
            febypass.MeshResize(duck, Vector3.new(8, 8, 8))
        end
    end
end
end
end)
TabGuiV1:Button("Burn All", function()
if F3X_Path == nil then return end
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil then
    for _, part in v.Character:GetDescendants() do
        if part:IsA("BasePart") or part:IsA("Part") then
            febypass.remoteExecute({
                [1] = "CreateDecorations",
                [2] = { { Part = part, DecorationType = "Fire" } }
            })
        end
    end
end
end
end)
TabGuiV1:Toggle("Luigi Rain",false, function(state)
      ABC9281818191 = state
while ABC9281818191 do
wait(0.5)
if F3X_Path ~= nil and Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
playerPos = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
    local x = math.random(-600,600) + playerPos.X
    local z = math.random(-600,600) + playerPos.Z
    febypass.CreatePart(CFrame.new(x, playerPos.Y + 400, z))
    febypass.SetMesh(part, "1618237875") 
    febypass.MeshResize(part, Vector3.new(20,20,20))
end
end
end)
TabGuiV1:Toggle("Toads Rain",false, function(state)
      ABC1525251515252 = state
while ABC1525251515252 do
wait(0.5)
if F3X_Path ~= nil and Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
playerPos = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
    local x = math.random(-600,600) + playerPos.X
    local z = math.random(-600,600) + playerPos.Z
    febypass.CreatePart(CFrame.new(x, playerPos.Y + 400, z))
    febypass.SetMesh(part, "614605299") 
    febypass.MeshResize(part, Vector3.new(20,20,20))
end
end
end)
TabGuiV1:Button("Thomas Engine", function()
if Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
local char = Players.LocalPlayer.Character
    if not char then return end
    febypass.CreatePart(char.HumanoidRootPart.CFrame, char)
    local thomas = char:WaitForChild("Part", 2)
    
    if thomas then
        febypass.SetName(thomas, "Thomas")
        febypass.SetCollision(thomas, false)
        febypass.SetLocked(thomas, false)
        
        febypass.AddMesh(thomas)
        febypass.SetMesh(thomas, "4340968808")
        febypass.SetTexture(thomas, "4340968918")
        febypass.MeshResize(thomas, Vector3.new(3, 3, 3))

        febypass.SetAnchor(true, char.HumanoidRootPart) 
        febypass.Weld(thomas, char.HumanoidRootPart, thomas)
        febypass.SetAnchor(false, char.HumanoidRootPart) 
        char.Humanoid.WalkSpeed = 100
end
end
end)
TabGuiV1:Button("Kill All", function()
if F3X_Path == nil then return end
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Head") then
    febypass.DestroyPart(v.Character.Head)
end
end
end)
TabGuiV1:Button("Punish All", function()
if F3X_Path == nil then return end
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil then
febypass.DestroyPart(v.Character)
end
end
end)
TabGuiV1:Button("Bug All", function()
if F3X_Path == nil then return end
for i,v in Players:GetPlayers() do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
febypass.DestroyPart(v.Character.HumanoidRootPart)
end
end
end)
TabGuiV1:Button("C00lkid Skybox", function()
if F3X_Path ~= nil and Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    local player = Players.LocalPlayer
    local char = player.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    for _, v in workspace:GetChildren() do
        if v.Name == "CustomSkybox" then
            febypass.DestroyPart(v)
        end
    end
    
    local x = math.floor(hrp.Position.X)
    local y = math.floor(hrp.Position.Y)
    local z = math.floor(hrp.Position.Z)
    local newPart = febypass.CreatePart(CFrame.new(x, y + 6, z), workspace)

    febypass.SetName(newPart, "CustomSkybox")
    febypass.SetLocked(newPart, true)
    febypass.SetCollision(newPart, false)
    febypass.AddMesh(newPart)
    febypass.SetMesh(newPart, "8006679977") 
    febypass.SetTexture(newPart, "433517917")
    febypass.MeshResize(newPart, Vector3.new(830, 830, 830))

    febypass.SetAnchor(true, newPart)
end
end)
TabGuiV1:Button("Dick All", function()
for i,v in Players:GetPlayers() do
if F3X_Path ~= nil and v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Torso") and not v.Character:FindFirstChild("LowerTorso") then
    local char = v.Character
    for i,v in char:GetChildren() do
        pcall(function() febypass.SetLocked(v, false) end)
    end

    if not char:FindFirstChild("Penis") then
        febypass.SetAnchor(true, char.HumanoidRootPart)
febypass.CreatePart(char:WaitForChild("Right Leg").CFrame * CFrame.new(-0.8,1,-0.6), char)
        febypass.SetName(char.Part, "Balls1")
febypass.CreatePart(char:WaitForChild("Left Leg").CFrame * CFrame.new(0.8,1,-0.6), char)
        febypass.SetName(char.Part, "Balls2")

        wait(0.2)
febypass.CreatePart(char:WaitForChild("Torso").CFrame * CFrame.new(0,-1,-1.3), char)
        febypass.SetName(char.Part, "Penis")
        
febypass.CreatePart(char:WaitForChild("Torso").CFrame * CFrame.new(0,-1,-2.5), char)
        febypass.SetName(char.Part, "Head1")
        febypass.AddMesh(char.Penis)
        febypass.SetMesh(char.Penis, "4743972117") 
        febypass.MeshResize(char.Penis, Vector3.new(0.5,0.5,3))
        febypass.AddMesh(char.Head1)
        febypass.SetMesh(char.Head1, "4743972117")
        febypass.MeshResize(char.Head1, Vector3.new(0.5,0.5,1))
        febypass.Color(char.Head1, Color3.fromRGB(255,100,100)) 
        febypass.Weld(char.Penis, char.HumanoidRootPart, char.Penis)
        febypass.Weld(char.Head1, char.Penis, char.Head1)
        febypass.Weld(char.Balls1, char.HumanoidRootPart, char.Balls1)
        febypass.Weld(char.Balls2, char.Balls1, char.Balls2)
    end
end
end
end)

local TabGuiV1 = Tab1:Channel("TARGET")
TabGuiV1:Label("TARGET | TARGET NAME / BASIC FUNCTION PLAYER")
local G = setmetatable({}, {__index = function(Self, Index)
local NewService = game.GetService(game, Index)
if NewService then
Self[Index] = NewService
end
return NewService
end})
local Players = G.Players
local plr = Players.LocalPlayer
local lastPosOftoolgiver = {}
local H
local Connections = {}
local Ch
local reExecuted = false
local lastPosOfCashGiver = nil
local function GetPlrs(txt)
	    local tl = txt:lower()
	    local found= {}
	    if tl == "me" or tl == "me " then
	    table.insert(found,Players.LocalPlayer)
	    return found
	    elseif tl == "random" or tl == "random " then
	    table.insert(found,Players:GetPlayers()[math.random(1, #Players:GetPlayers())])
	    return found
	    elseif tl == "others" or tl == "others " then
	    for i,v in pairs(Players:GetPlayers()) do
	    if v ~= Players.LocalPlayer then
	    table.insert(found, v)
	    end
	    end
	    return found
	    elseif tl == "all" or tl == "all " then
	    for i,v in pairs(Players:GetPlayers()) do
	    table.insert(found, v)
	    end
	    return found
	    elseif tl == "enemies" or tl == "enemies " then
	    for i,v in pairs(Players:GetPlayers()) do
	    if v ~= Players.LocalPlayer and v.Team ~= plr.Team then
	    table.insert(found, v)
	    end
	    end
	    return found
	    elseif tl == "team" or tl == "team " then
	    for i,v in pairs(Players:GetPlayers()) do
	    if v ~= Players.LocalPlayer and v.Team == plr.Team then
	    table.insert(found, v)
	    end
	    end
	    return found
	    else
	    for i,v in pairs(Players:GetPlayers()) do
	    if v.Name:lower():match(tl) or v.DisplayName:lower():match(tl) then
	    table.insert(found, v)
	    end
	    end
	    return found
	end
	end
Target = tostring("me")
TabGuiV1:Textbox("Target Player", "Default Is LocalPlayer", false, function(Y)
Target = tostring(Y)
end) 
TabGuiV1:Toggle("View",false, function(state)
      ABC492781 = state
while ABC492781 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
if v and v.Character and v.Character ~= nil then
game.Workspace.CurrentCamera.CameraSubject = v.Character
elseif Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil then
game.Workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character
end
end
end
if ABC492781 == false and Players.LocalPlayer.Character and Players.LocalPlayer.Character ~= nil then
game:GetService("RunService").Heartbeat:Wait()
game.Workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character
end
end)
TabGuiV1:Button("Jail", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."jail "..v.Name)
end
end)
TabGuiV1:Button("Freeze", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."freeze "..v.Name)
end
end)
TabGuiV1:Button("Ice", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."ice "..v.Name)
end
end)
TabGuiV1:Button("Explode", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."explode "..v.Name)
end
end)
TabGuiV1:Button("Poop", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."poop "..v.Name)
end
end)
TabGuiV1:Button("R15", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."r15 "..v.Name)
end
end)
TabGuiV1:Button("Reset", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."re "..v.Name)
end
end)
TabGuiV1:Button("Respawn", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."respawn "..v.Name)
end
end)
TabGuiV1:Button("R6", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."r6 "..v.Name)
end
end)
TabGuiV1:Button("Neon", function()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."neon "..v.Name)
end
end)
TabGuiV1:Textbox("Change Size", "No Limits", false, function(txt)
	for i,v in pairs(GetPlrs(Target)) do
spawn(function()
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Torso") and not v.Character:FindFirstChild("LowerTorso") then
Players:Chat(PrefixY.."r15 "..v.Name)
wait(1)
end
Players:Chat(PrefixY.."size "..v.Name.." "..txt)
end)
end
end) 

TabGuiV1:Label("TARGET | CHANGE / OTHERS / BASIC / CMDS")
TabGuiV1:Textbox("Size", "Auto Change R6 To R15", false, function(txt)
	for i,v in pairs(GetPlrs(Target)) do
spawn(function()
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
if v.Character:FindFirstChild("Torso") and not v.Character:FindFirstChild("LowerTorso") then
Players:Chat(PrefixY.."r15 "..v.Name)
end
end
wait(3)
Players:Chat(PrefixY.."size "..v.Name.." "..tonumber(txt) or 2)
end)
end
end) 




TabGuiV1:Label("TARGET | LOOP / ANNOY / LAG / HEAD ADMIN")
TabGuiV1:Toggle("Loop Jail",false, function(state)
      ABC948393839 = state
while ABC948393839 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
if not workspace:FindFirstChild(v.Name.."'s JailCell") then Players:Chat(PrefixY.."jail "..v.Name) wait(0.1) end
end
end
end)
TabGuiV1:Toggle("Loop Change Mode Character",false, function(state)
      ABC593759373839 = state
while ABC593759373839 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."r6 "..v.Name)
game:GetService("RunService").Heartbeat:Wait()
Players:Chat(PrefixY.."r15 "..v.Name)
end
end
end)
TabGuiV1:Toggle("Loop Poop [LAG]",false, function(state)
      ABC4635644536 = state
while ABC4635644536 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."respawn "..v.Name)
game:GetService("RunService").Heartbeat:Wait()
Players:Chat(PrefixY.."poop "..v.Name)
game:GetService("RunService").Heartbeat:Wait()
end
end
end)
TabGuiV1:Toggle("Loop Reset Explode",false, function(state)
      ABC24153475555515 = state
while ABC24153475555515 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."respawn "..v.Name)
game:GetService("RunService").Heartbeat:Wait()
Players:Chat(PrefixY.."explode "..v.Name)
game:GetService("RunService").Heartbeat:Wait()
end
end
end)
TabGuiV1:Toggle("Loop Explode",false, function(state)
      ABC474877777377 = state
while ABC474877777377 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."explode "..v.Name)
end
end
end)
TabGuiV1:Toggle("Loop Respawn",false, function(state)
      ABC14244441441414414 = state
while ABC14244441441414414 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."respawn "..v.Name)
end
end
end)
TabGuiV1:Toggle("Loop Reset",false, function(state)
      ABC2415352551515 = state
while ABC2415352551515 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."re "..v.Name)
end
end
end)
TabGuiV1:Toggle("Spam Logs [LAG]",false, function(state)
      ABC352545252515255 = state
while ABC352545252515255 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
Players:Chat(PrefixY.."logs "..v.Name)
end
end
end)
TabGuiV1:Toggle("Loop Freeze",false, function(state)
      ABC848483784837888899 = state
while ABC848483784837888899 do
game:GetService("RunService").RenderStepped:Wait()
	for i,v in pairs(GetPlrs(Target)) do
if not workspace:FindFirstChild(v.Name.."'s FreezeBlock") then Players:Chat(PrefixY.."ice "..v.Name) wait(0.1) end
end
end
end)


TabGuiV1:Label("TARGET | F3X / BTOOLS / FUNCTION")
TabGuiV1:Textbox("Size Head", "No Limits", false, function(txt)
if F3X_Path == nil then return end
a = tonumber(txt) or 0;
	for i,v in pairs(GetPlrs(Target)) do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Head") then
    febypass.SetLocked(v.Character.Head, false)
    febypass.MeshResize(v.Character.Head, Vector3.new(a,a,a))
end
end
end) 
TabGuiV1:Button("Bug Player", function()
if F3X_Path == nil then return end
	for i,v in pairs(GetPlrs(Target)) do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
febypass.DestroyPart(v.Character.HumanoidRootPart)
end
end
end)
TabGuiV1:Button("Punish", function()
if F3X_Path == nil then return end
	for i,v in pairs(GetPlrs(Target)) do
if v.Character and v.Character ~= nil then
febypass.DestroyPart(v.Character)
end
end
end)
TabGuiV1:Button("Kill", function()
if F3X_Path == nil then return end
	for i,v in pairs(GetPlrs(Target)) do
if v.Character and v.Character ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 and v.Character:FindFirstChild("Head") then
    febypass.DestroyPart(v.Character.Head)
end
end
end)
