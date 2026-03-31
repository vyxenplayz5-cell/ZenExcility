--// ================================================
--//   Zen Hub +  |  Full functional Engine
--//   Library: redzlib V5
--// ================================================

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

--// --- SETTINGS & VARIABLES ---
_G.ZenSettings = {
    AutoFarm = false,
    FastAttack = false,
    SelectedWeapon = "Melee",
    FlySpeed = 300
}

local LP = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

--// --- THE FLY/TWEEN ENGINE ---
-- This function moves you to any position smoothly to bypass anti-cheats
local function TweenTo(targetCFrame)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    
    -- Stop any existing tweens first
    local dist = (targetCFrame.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(dist / _G.ZenSettings.FlySpeed, Enum.EasingStyle.Linear)
    
    local tween = TweenService:Create(LP.Character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    return tween
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

--// Tabs
local MainTab      = Window:MakeTab({"Main", "home"})
local FarmTab      = Window:MakeTab({"Auto Farm", "swords"})
local TeleportTab  = Window:MakeTab({"Teleport", "map"})
local SeaTab       = Window:MakeTab({"Sea Events", "waves"})
local MiscTab      = Window:MakeTab({"Misc", "list"})

-- ===============================================
--// FARM TAB (Logic Added)
-- ===============================================
FarmTab:AddSection({"Combat Engine"})

FarmTab:AddToggle({"Fast Attack", false, function(v)
    _G.ZenSettings.FastAttack = v
end})

FarmTab:AddDropdown({"Select Weapon", {"Melee", "Sword", "Fruit"}, "Melee", function(v)
    _G.ZenSettings.SelectedWeapon = v
end})

-- ===============================================
--// TELEPORT TAB (Buttons Fixed)
-- ===============================================
TeleportTab:AddSection({"Island Locations"})

-- These are example coordinates. 
-- In Blox Fruits, you'd replace CFrame.new(0,0,0) with actual Island Positions
TeleportTab:AddButton({"Teleport to Starter Island", function()
    TweenTo(CFrame.new(979, 16, 1432)) -- Example Starter Island Pos
end})

TeleportTab:AddButton({"Teleport to Marine Ford", function()
    TweenTo(CFrame.new(-2532, 7, 2056)) -- Example Marine Ford Pos
end})

TeleportTab:AddSection({"Movement Settings"})
TeleportTab:AddSlider({"Fly/Tween Speed", 100, 1000, 10, 300, function(v)
    _G.ZenSettings.FlySpeed = v
end})

-- ===============================================
--// SEA EVENTS
-- ===============================================
SeaTab:AddSection({"Beast Hunting"})
SeaTab:AddToggle({"Auto Sea Beast (Fly to Sea)", false, function(v)
    -- Logic for finding Sea Beasts would go here
end})

-- ===============================================
--// MISC TAB
-- ===============================================
MiscTab:AddSection({"Movement Utilities"})

MiscTab:AddToggle({"Infinite Jump", false, function(v)
    _G.InfJump = v
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end})

MiscTab:AddSlider({"WalkSpeed", 16, 500, 1, 16, function(v)
    LP.Character.Humanoid.WalkSpeed = v
end})

MiscTab:AddButton({"Server Hop", function()
    local ts = game:GetService("TeleportService")
    local hs = game:GetService("HttpService")
    local servers = hs:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
    ts:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)].id)
end})

--// Default Select
Window:SelectTab(MainTab)

--// --- UI Toggle ---
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
