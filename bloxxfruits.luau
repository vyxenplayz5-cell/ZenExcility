--// ================================================
--//   Zen Hub +  |  Zenith Edition (Full Layout)
--//   Library: redzlib V5
--// ================================================

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

local Window = redzlib:MakeWindow({
    Title      = "Zen Hub +",
    SubTitle   = "Zenith Edition v5",
    SaveFolder = "ZenHub_Pro",
})

--// Minimize Button (Your Custom Icon)
Window:AddMinimizeButton({
    Button = { 
        Image = "rbxassetid://101063822545949", 
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
    },
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

-- ===============================================
--// MAIN TAB
-- ===============================================
MainTab:AddSection({"Status"})
MainTab:AddParagraph({"Account:", "User: " .. game.Players.LocalPlayer.Name})
MainTab:AddSection({"Discord"})
MainTab:AddDiscordInvite({
    Name = "Zen Hub Community",
    Description = "Exclusive scripts",
    Logo = "rbxassetid://18751483361",
    Invite = "zenhub",
})

-- ===============================================
--// FARM TAB
-- ===============================================
FarmTab:AddSection({"Leveling"})
FarmTab:AddToggle({"Auto Farm Level", false, function(v) end})
FarmTab:AddToggle({"Auto Elite Hunter", false, function(v) end})
FarmTab:AddSection({"Material Farm"})
FarmTab:AddToggle({"Auto Farm Bones", false, function(v) end})
FarmTab:AddToggle({"Auto Farm Scrap Metal", false, function(v) end})
FarmTab:AddSection({"Weapon Config"})
FarmTab:AddDropdown({"Select Tool", {"Melee", "Sword", "Fruit"}, "Melee", function(v) end})
FarmTab:AddToggle({"Fast Attack", false, function(v) end})

-- ===============================================
--// MASTERY TAB
-- ===============================================
MasteryTab:AddSection({"Mastery Settings"})
MasteryTab:AddToggle({"Auto Mastery Melee", false, function(v) end})
MasteryTab:AddToggle({"Auto Mastery Sword", false, function(v) end})
MasteryTab:AddSlider({"Health % to Swap", 5, 50, 1, 20, function(v) end})

-- ===============================================
--// COMBAT TAB
-- ===============================================
CombatTab:AddSection({"PVP"})
CombatTab:AddToggle({"Auto Bounty Hunter", false, function(v) end})
CombatTab:AddToggle({"Safe Mode (Low HP)", false, function(v) end})
CombatTab:AddToggle({"Smart Reach", false, function(v) end})

-- ===============================================
--// TELEPORT TAB (Restored)
-- ===============================================
TeleportTab:AddSection({"World Travel"})
TeleportTab:AddButton({"Teleport to First Sea", function() end})
TeleportTab:AddButton({"Teleport to Second Sea", function() end})
TeleportTab:AddButton({"Teleport to Third Sea", function() end})
TeleportTab:AddSection({"Island Teleports"})
TeleportTab:AddDropdown({"Select Island", {"Starter Island", "Marine Ford", "Sky Island", "Prison", "Magma Village"}, "", function(v) end})
TeleportTab:AddButton({"Go to Island", function() end})

-- ===============================================
--// FRUIT TAB
-- ===============================================
FruitTab:AddSection({"Utilities"})
FruitTab:AddToggle({"Auto Collect Fruits", false, function(v) end})
FruitTab:AddToggle({"Auto Store Fruit", false, function(v) end})
FruitTab:AddSection({"Shop Sniper"})
FruitTab:AddToggle({"Auto Buy Mythical", false, function(v) end})

-- ===============================================
--// SEA EVENTS (Restored)
-- ===============================================
SeaTab:AddSection({"Sea Bosses"})
SeaTab:AddToggle({"Auto Sea Beast", false, function(v) end})
SeaTab:AddToggle({"Auto Terror Shark", false, function(v) end})
SeaTab:AddToggle({"Auto Leviathan", false, function(v) end})
SeaTab:AddButton({"Teleport to Mirage Island", function() end})

-- ===============================================
--// RAID / DUNGEON (Restored)
-- ===============================================
DungeonTab:AddSection({"Raid Automation"})
DungeonTab:AddToggle({"Auto Raid", false, function(v) end})
DungeonTab:AddToggle({"Kill Aura Raid", false, function(v) end})
DungeonTab:AddButton({"Buy Raid Chip", function() end})

-- ===============================================
--// SHOP TAB (Restored)
-- ===============================================
ShopTab:AddSection({"Fighting Styles"})
ShopTab:AddButton({"Buy Godhuman", function() end})
ShopTab:AddButton({"Buy Sharkman Karate", function() end})
ShopTab:AddSection({"Abilities"})
ShopTab:AddButton({"Buy Geppo", function() end})
ShopTab:AddButton({"Buy Haki", function() end})

-- ===============================================
--// VISUALS TAB
-- ===============================================
VisualTab:AddSection({"ESP"})
VisualTab:AddToggle({"Player ESP", false, function(v) end})
VisualTab:AddToggle({"Fruit ESP", false, function(v) end})
VisualTab:AddSection({"World Tweaks"})
VisualTab:AddToggle({"Fullbright", false, function(v) end})

-- ===============================================
--// MISC TAB
-- ===============================================
MiscTab:AddSection({"Server Utility"})
MiscTab:AddButton({"Server Hop", function() end})
MiscTab:AddButton({"Rejoin Server", function() end})
MiscTab:AddSection({"Performance"})
MiscTab:AddButton({"Boost FPS", function() end})
MiscTab:AddToggle({"Disable 3D Rendering", false, function(v) end})

--// Default Select
Window:SelectTab(MainTab)

--// ================================================
--// UI Toggle Logic
--// ================================================
local UIS = game:GetService("UserInputService")
local ToggleKey = Enum.KeyCode.LeftControl

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end 
    if input.KeyCode == ToggleKey then
        local Locations = {game:GetService("CoreGui"), game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")}
        for _, location in pairs(Locations) do
            for _, gui in pairs(location:GetChildren()) do
                if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                    gui.Main.Visible = not gui.Main.Visible
                end
            end
        end
    end
end)
