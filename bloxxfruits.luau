--// ================================================
--//   Zen Hub +  |  Zenith Edition (Beyond Redz)
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

--// Tabs
local MainTab     = Window:MakeTab({"Main", "home"})
local FarmTab     = Window:MakeTab({"Auto Farm", "swords"})
local MasteryTab  = Window:MakeTab({"Mastery", "graduation-cap"})
local CombatTab   = Window:MakeTab({"Combat", "zap"})
local TeleportTab = Window:MakeTab({"Teleport", "map"})
local FruitTab    = Window:MakeTab({"Fruit", "cherry"})
local SeaTab      = Window:MakeTab({"Sea Events", "waves"})
local DungeonTab  = Window:MakeTab({"Raid/Dungeon", "box"})
local ShopTab     = Window:MakeTab({"Shop", "shopping-cart"})
local VisualTab   = Window:MakeTab({"Visuals", "eye"})
local MiscTab     = Window:MakeTab({"Misc", "list"})

-- ===============================================
--// MAIN TAB
-- ===============================================
MainTab:AddSection({"Status"})
MainTab:AddParagraph({"Account:", "User: " .. game.Players.LocalPlayer.Name})
MainTab:AddParagraph({"Session:", "Time Elapsed: 00:00:00"})

MainTab:AddSection({"Discord & Updates"})
MainTab:AddDiscordInvite({
    Name = "Zen Hub Community",
    Description = "Exclusive scripts & Early Access",
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
FarmTab:AddToggle({"Auto Farm Conjured Cocoa", false, function(v) end})

FarmTab:AddSection({"Weapon Config"})
FarmTab:AddDropdown({"Select Tool", {"Melee", "Sword", "Fruit"}, "Melee", function(v) end})
FarmTab:AddToggle({"Fast Attack (Zen-Speed)", false, function(v) end})
FarmTab:AddToggle({"Multi-Target Hit", false, function(v) end})

-- ===============================================
--// MASTERY TAB
-- ===============================================
MasteryTab:AddSection({"Mastery Farm"})
MasteryTab:AddToggle({"Auto Mastery Melee", false, function(v) end})
MasteryTab:AddToggle({"Auto Mastery Sword", false, function(v) end})
MasteryTab:AddToggle({"Auto Mastery Fruit", false, function(v) end})
MasteryTab:AddSlider({"Health % to Swap", 5, 50, 1, 20, function(v) end})

-- ===============================================
--// COMBAT TAB
-- ===============================================
CombatTab:AddSection({"PVP Logic"})
CombatTab:AddToggle({"Auto Bounty Hunter", false, function(v) end})
CombatTab:AddToggle({"Safe Mode", false, function(v) end})
CombatTab:AddToggle({"Auto Ken Haki", false, function(v) end})
CombatTab:AddToggle({"Smart Reach", false, function(v) end})

-- ===============================================
--// FRUIT TAB
-- ===============================================
FruitTab:AddSection({"Fruit Utilities"})
FruitTab:AddToggle({"Auto Collect Fruits", false, function(v) end})
FruitTab:AddToggle({"Auto Store Fruit", false, function(v) end})
FruitTab:AddSection({"Sniper"})
FruitTab:AddToggle({"Auto Buy Mythical Fruits", false, function(v) end})

-- ===============================================
--// SEA EVENTS
-- ===============================================
SeaTab:AddSection({"Sea Farming"})
SeaTab:AddToggle({"Auto Sea Beast", false, function(v) end})
SeaTab:AddToggle({"Auto Terror Shark", false, function(v) end})
SeaTab:AddToggle({"Auto Leviathan", false, function(v) end})
SeaTab:AddButton({"Teleport to Mirage Island", function() end})

-- ===============================================
--// VISUALS TAB
-- ===============================================
VisualTab:AddSection({"ESP"})
VisualTab:AddToggle({"Player ESP", false, function(v) end})
VisualTab:AddToggle({"Fruit ESP", false, function(v) end})
VisualTab:AddSection({"World Tweaks"})
VisualTab:AddToggle({"Fullbright", false, function(v) end})
VisualTab:AddToggle({"X-Ray Mode", false, function(v) end})

-- ===============================================
--// MISC TAB
-- ===============================================
MiscTab:AddSection({"Automation"})
MiscTab:AddTextBox({"Discord Webhook URL", "Paste here...", function(v) end})
MiscTab:AddSection({"Server Utility"})
MiscTab:AddButton({"Server Hop", function() end})
MiscTab:AddButton({"Rejoin Server", function() end})
MiscTab:AddSection({"Performance"})
MiscTab:AddButton({"Boost FPS", function() end})
MiscTab:AddToggle({"Disable 3D Rendering", false, function(v) end})

--// Default Select
Window:SelectTab(MainTab)

--// ================================================
--// UI Toggle Logic (DEEP SEARCH FIX)
--// ================================================

local UIS = game:GetService("UserInputService")
local ToggleKey = Enum.KeyCode.LeftControl

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end 
    
    if input.KeyCode == ToggleKey then
        local Found = false
        
        -- Search in both possible storage locations
        local Locations = {game:GetService("CoreGui"), game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")}
        
        for _, location in pairs(Locations) do
            for _, gui in pairs(location:GetChildren()) do
                -- Look for the ScreenGui that contains the library's "Main" frame
                if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                    local MainFrame = gui:FindFirstChild("Main")
                    if MainFrame then
                        MainFrame.Visible = not MainFrame.Visible
                        Found = true
                    end
                end
            end
        end
        
        if Found then
            print("[Zen Hub +]: UI Toggled Successfully")
        else
            warn("[Zen Hub +]: Could not find the Main frame to toggle!")
        end
    end
end)
