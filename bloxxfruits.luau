--// ================================================
--//   Zen Hub +  |  Zenith Edition (PRO FUNCTIONS)
--//   Library: redzlib V5
--// ================================================

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

--// GLOBAL SETTINGS (The "Brain")
_G.ZenSettings = {
    AutoFarm = false,
    FastAttack = false,
    SelectedWeapon = "Melee",
    Fullbright = false,
    AutoStore = false,
    AntiLag = false
}

--// Services
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

--// FUNCTION: Smooth Tween (Fly to locations)
local function TweenTo(targetCFrame)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local distance = (targetCFrame.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    local speed = 300 -- Adjust for anti-cheat
    local info = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(LP.Character.HumanoidRootPart, info, {CFrame = targetCFrame})
    tween:Play()
    return tween
end

--// FUNCTION: Fast Attack (Animation Canceller)
spawn(function()
    while task.wait() do
        if _G.ZenSettings.FastAttack then
            pcall(function()
                local tool = LP.Character:FindFirstChildOfClass("Tool")
                if tool and (tool.Name == _G.ZenSettings.SelectedWeapon or _G.ZenSettings.SelectedWeapon == "Any") then
                    -- Simulates click for high speed
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end
            end)
        end
    end
end)

local Window = redzlib:MakeWindow({
    Title      = "Zen Hub +",
    SubTitle   = "Zenith Edition v5",
    SaveFolder = "ZenHub_Pro",
})

--// Minimize Button
Window:AddMinimizeButton({
    Button = { 
        Image = "rbxassetid://101063822545949", 
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
    },
    Corner = { CornerRadius = UDim.new(0, 12) },
})

--// Tabs
local MainTab      = Window:MakeTab({"Main", "home"})
local FarmTab      = Window:MakeTab({"Auto Farm", "swords"})
local TeleportTab  = Window:MakeTab({"Teleport", "map"})
local VisualTab    = Window:MakeTab({"Visuals", "eye"})
local MiscTab      = Window:MakeTab({"Misc", "list"})

-- ===============================================
--// FARM TAB LOGIC
-- ===============================================
FarmTab:AddSection({"Leveling"})
FarmTab:AddToggle({"Auto Farm Level", false, function(v) 
    _G.ZenSettings.AutoFarm = v 
end})

FarmTab:AddSection({"Weapon Config"})
FarmTab:AddDropdown({"Select Tool", {"Melee", "Sword", "Fruit"}, "Melee", function(v)
    _G.ZenSettings.SelectedWeapon = v
end})

FarmTab:AddToggle({"Fast Attack", false, function(v)
    _G.ZenSettings.FastAttack = v
end})

-- ===============================================
--// TELEPORT TAB LOGIC
-- ===============================================
TeleportTab:AddSection({"Quick Teleport"})
TeleportTab:AddButton({"Spawn Location", function()
    if LP.Character then
        LP.Character.HumanoidRootPart.CFrame = LP.RespawnLocation and LP.RespawnLocation.CFrame or CFrame.new(0, 100, 0)
    end
end})

-- ===============================================
--// VISUALS TAB LOGIC
-- ===============================================
VisualTab:AddSection({"Lighting"})
VisualTab:AddToggle({"Fullbright", false, function(v)
    _G.ZenSettings.Fullbright = v
    if v then
        game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
        game:GetService("Lighting").Brightness = 2
    else
        game:GetService("Lighting").Ambient = Color3.fromRGB(138, 138, 138)
        game:GetService("Lighting").Brightness = 1
    end
end})

-- ===============================================
--// MISC TAB LOGIC
-- ===============================================
MiscTab:AddSection({"Server Utility"})
MiscTab:AddButton({"Server Hop", function()
    local HttpService = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local Raw = game:HttpGet(Api)
    local Servers = HttpService:JSONDecode(Raw)
    if Servers and Servers.data then
        TPS:TeleportToPlaceInstance(game.PlaceId, Servers.data[math.random(1, #Servers.data)].id)
    end
end})

MiscTab:AddToggle({"Disable 3D Rendering", false, function(v)
    RunService:Set3dRenderingEnabled(not v)
end})

--// Default Select
Window:SelectTab(MainTab)

--// UI Toggle Logic
local UIS = game:GetService("UserInputService")
local ToggleKey = Enum.KeyCode.LeftControl

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end 
    if input.KeyCode == ToggleKey then
        local found = false
        local locations = {game:GetService("CoreGui"), LP:WaitForChild("PlayerGui")}
        for _, loc in pairs(locations) do
            for _, gui in pairs(loc:GetChildren()) do
                if gui:IsA("ScreenGui") and gui:FindFirstChild("Main") then
                    gui.Main.Visible = not gui.Main.Visible
                    found = true
                end
            end
        end
    end
end)
