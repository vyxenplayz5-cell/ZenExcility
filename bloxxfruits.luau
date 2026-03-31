--// ================================================
--//   Zen Hub +  |  The "Everything" Edition
--//   Library: redzlib V5
--// ================================================

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

--// --- GLOBAL ENGINE SETTINGS ---
_G.ZenSettings = {
    AutoFarm = false,
    FastAttack = false,
    SelectedWeapon = "Melee",
    FlySpeed = 300,
    AutoRaid = false,
    FruitNotifier = false
}

local LP = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

--// FLY/TWEEN ENGINE
local function TweenTo(targetCFrame)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local dist = (targetCFrame.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(dist / _G.ZenSettings.FlySpeed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(LP.Character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
end

local Window = redzlib:MakeWindow({
    Title      = "Zen Hub +",
    SubTitle   = "Zenith Edition v5",
    SaveFolder = "ZenHub_Pro",
})

--// Minimize Button
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://101063822545949", BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(30, 30, 30) },
    Corner = { CornerRadius = UDim.new(0, 12) },
})

--// Tab Creation
local MainTab      = Window:MakeTab({"Main", "home"})
local FarmTab      = Window:MakeTab({"Auto Farm", "swords"})
local MasteryTab   = Window:MakeTab({"Mastery", "graduation-cap"})
local CombatTab    = Window:MakeTab({"Combat", "zap"})
local TeleportTab  = Window:MakeTab({"Teleport", "map"})
local FruitTab     = Window:MakeTab({"Fruit", "cherry"})
local SeaTab       = Window:MakeTab({"Sea Events", "waves"})
local DungeonTab   = Window:MakeTab({"Raid/Dungeon", "box"})
local ShopTab      = Window:MakeTab({"Shop", "shopping-cart"})
local VisualTab    = Window:MakeTab({"Visuals", "eye"})
local MiscTab      = Window:MakeTab({"Misc", "list"})

--// --- MAIN TAB ---
MainTab:AddSection({"User Info"})
MainTab:AddParagraph({"Welcome!", "Script loaded for: " .. LP.Name})
MainTab:AddSection({"Links"})
MainTab:AddButton({"Copy Discord Invite", function() setclipboard("https://discord.gg/zenhub") end})

--// --- FARM TAB ---
FarmTab:AddSection({"Leveling"})
FarmTab:AddToggle({"Auto Farm Level", false, function(v) _G.ZenSettings.AutoFarm = v end})
FarmTab:AddToggle({"Auto Elite Hunter", false, function(v) end})
FarmTab:AddSection({"Weapon Settings"})
FarmTab:AddDropdown({"Select Weapon", {"Melee", "Sword", "Fruit"}, "Melee", function(v) _G.ZenSettings.SelectedWeapon = v end})
FarmTab:AddToggle({"Fast Attack", false, function(v) _G.ZenSettings.FastAttack = v end})

--// --- MASTERY TAB ---
MasteryTab:AddSection({"Mastery Farm"})
MasteryTab:AddToggle({"Auto Mastery (Melee)", false, function(v) end})
MasteryTab:AddToggle({"Auto Mastery (Fruit)", false, function(v) end})
MasteryTab:AddSlider({"HP Stop %", 5, 50, 1, 20, function(v) end})

--// --- COMBAT TAB ---
CombatTab:AddSection({"PVP Utilities"})
CombatTab:AddToggle({"Auto Bounty", false, function(v) end})
CombatTab:AddToggle({"Safe Mode (Runs at 20% HP)", false, function(v) end})
CombatTab:AddToggle({"Smart Reach", false, function(v) end})

--// --- TELEPORT TAB ---
TeleportTab:AddSection({"Sea Travel"})
TeleportTab:AddButton({"Travel to Sea 1", function() end})
TeleportTab:AddButton({"Travel to Sea 2", function() end})
TeleportTab:AddButton({"Travel to Sea 3", function() end})
TeleportTab:AddSection({"Islands"})
TeleportTab:AddDropdown({"Select Island", {"Starter", "Jungle", "Snow", "Magma", "Skypiea"}, "", function(v) end})
TeleportTab:AddButton({"Fly to Island", function() end})

--// --- FRUIT TAB ---
FruitTab:AddSection({"Inventory"})
FruitTab:AddButton({"Store All Fruits", function() end})
FruitTab:AddToggle({"Auto Buy Random Fruit", false, function(v) end})
FruitTab:AddSection({"Finders"})
FruitTab:AddToggle({"Fruit ESP", false, function(v) end})
FruitTab:AddToggle({"Fruit Notifier", false, function(v) end})

--// --- SEA EVENTS TAB ---
SeaTab:AddSection({"Sea Farming"})
SeaTab:AddToggle({"Auto Sea Beast", false, function(v) end})
SeaTab:AddToggle({"Auto Ship Farm", false, function(v) end})
SeaTab:AddToggle({"Auto Terror Shark", false, function(v) end})

--// --- DUNGEON TAB ---
DungeonTab:AddSection({"Raid Controls"})
DungeonTab:AddButton({"Buy Raid Chip", function() end})
DungeonTab:AddToggle({"Auto Raid (Join & Kill)", false, function(v) end})
DungeonTab:AddToggle({"Kill Aura Raid", false, function(v) end})

--// --- SHOP TAB ---
ShopTab:AddSection({"Melee Styles"})
ShopTab:AddButton({"Buy Godhuman", function() end})
ShopTab:AddButton({"Buy Dragon Breath", function() end})
ShopTab:AddSection({"Sword Shop"})
ShopTab:AddButton({"Buy Bisento", function() end})

--// --- VISUALS TAB ---
VisualTab:AddSection({"ESP Visuals"})
VisualTab:AddToggle({"Player ESP", false, function(v) end})
VisualTab:AddToggle({"Chest ESP", false, function(v) end})
VisualTab:AddSection({"World Visuals"})
VisualTab:AddToggle({"Fullbright", false, function(v) end})
VisualTab:AddToggle({"Remove Fog", false, function(v) end})

--// --- MISC TAB ---
MiscTab:AddSection({"Character Hacks"})
MiscTab:AddSlider({"WalkSpeed", 16, 500, 1, 16, function(v) LP.Character.Humanoid.WalkSpeed = v end})
MiscTab:AddToggle({"Infinite Jump", false, function(v) end})
MiscTab:AddSection({"Server Settings"})
MiscTab:AddButton({"Server Hop", function() end})
MiscTab:AddButton({"Rejoin", function() end})
MiscTab:AddToggle({"Disable 3D Rendering", false, function(v) game:GetService("RunService"):Set3dRenderingEnabled(not v) end})

--// Default Select
Window:SelectTab(MainTab)

--// UI Toggle (LeftControl)
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, proc)
    if not proc and input.KeyCode == Enum.KeyCode.LeftControl then
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                gui.Main.Visible = not gui.Main.Visible
            end
        end
    end
end)
