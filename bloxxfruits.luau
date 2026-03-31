--[[
    ZENITH X-GEN | ULTRA EDITION (V2026.PRO)
    Author: Zenith Team
    Optimized for: Blox Fruits (Update 21+)
    Framework: Supernova Multi-Threaded V4
]]

if not game:IsLoaded() then game.Loaded:Wait() end

--// --- CONFIGURATION SYSTEM ---
getgenv().Config = {
    Farm = {
        Enabled = false,
        FastAttack = true,
        AutoQuest = true,
        BringMob = true,
        Distance = 25,
        Weapon = "Melee", -- "Melee", "Sword", "Fruit"
        ToolMode = "Click", -- "Click", "Event"
    },
    Combat = {
        Aimlock = false,
        KillAura = false,
        AuraRadius = 50,
        SafeMode = true,
        HealthThreshold = 20
    },
    Stats = {
        AutoStats = false,
        Points = "Melee"
    },
    Misc = {
        AntiAFK = true,
        AutoStore = true,
        FpsBoost = false,
        WalkSpeed = 20,
        JumpPower = 50
    }
}

--// --- SERVICES ---
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local HTTPS = game:GetService("HttpService")
local RepS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local CommF = RepS:WaitForChild("Remotes"):WaitForChild("CommF_")

--// --- DATA TABLES ---
local Quests = {
    ["Sea 1"] = {
        {Level = 0, Name = "Bandit", QuestName = "BanditQuest1", QId = 1, Pos = Vector3.new(1059, 15, 1548)},
        {Level = 15, Name = "Monkey", QuestName = "JungleQuest", QId = 1, Pos = Vector3.new(-1598, 36, 153)}
        -- Add more levels here...
    }
}

--// --- CORE FUNCTIONS ---
local function Notify(Title, Text, Duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration or 5
    })
end

-- Smooth Tween Engine
local function ToPos(TargetCFrame)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local Distance = (TargetCFrame.Position - LP.Character.HumanoidRootPart.Position).Magnitude
    local Speed = 300 -- Optimized speed to avoid kick
    
    if Distance < 250 then Speed = 400 end
    
    local Tween = TS:Create(LP.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    Tween:Play()
    return Tween
end

-- Fast Attack Engine (Animation Canceling)
local function Attack()
    local CombatFramework = require(LP.PlayerScripts.CombatFramework)
    local Current = CombatFramework.activeController
    if Current and Current.equippedWeapon then
        for i = 1, 3 do
            Current:attack()
        end
    end
end

-- Dynamic Tool Equipper
local function EquipWeapon()
    local Category = getgenv().Config.Farm.Weapon
    for _, tool in pairs(LP.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == Category or tool.Name:find(Category)) then
            LP.Character.Humanoid:EquipTool(tool)
        end
    end
end

--// --- UI INITIALIZATION ---
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()
local Window = redzlib:MakeWindow({
    Title = "ZENITH X-GEN",
    SubTitle = "SUPERNOVA EDITION",
    SaveFolder = "ZenithConfig.json"
})

local MainTab = Window:MakeTab({"Main Farm", "home"})
local CombatTab = Window:MakeTab({"Combat", "zap"})
local StatTab = Window:MakeTab({"Stats", "bar-chart"})
local MiscTab = Window:MakeTab({"Settings", "settings"})

--// --- UI CONTENT ---
MainTab:AddSection({"Automated Leveling"})

MainTab:AddToggle({"Master Farm Level", false, function(v) 
    getgenv().Config.Farm.Enabled = v 
end})

MainTab:AddDropdown({"Weapon Type", {"Melee", "Sword", "Blox Fruit"}, "Melee", function(v) 
    getgenv().Config.Farm.Weapon = v 
end})

MainTab:AddSlider({"Farm Distance", 10, 80, 1, 25, function(v) 
    getgenv().Config.Farm.Distance = v 
end})

CombatTab:AddSection({"PVP Settings"})
CombatTab:AddToggle({"Fast Attack v5", true, function(v) getgenv().Config.Farm.FastAttack = v end})
CombatTab:AddToggle({"Kill Aura (Mobs)", false, function(v) getgenv().Config.Combat.KillAura = v end})

--// --- THE ENGINES (Parallel Processing) ---

-- 1. Optimized Farm Loop
task.spawn(function()
    while task.wait() do
        if getgenv().Config.Farm.Enabled then
            pcall(function()
                local Character = LP.Character
                if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                
                -- Check for Quest
                if not LP.PlayerGui.Main.Quest.Visible then
                    -- Simple example: Teleport to Quest NPC logic here
                    -- ToPos(QuestNPC_CFrame)
                else
                    -- Mob Hunting logic
                    local Enemy = workspace.Enemies:FindFirstChildOfClass("Model")
                    if Enemy and Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 then
                        EquipWeapon()
                        
                        -- Farm Position (Above Mob)
                        Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, getgenv().Config.Farm.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        
                        if getgenv().Config.Farm.FastAttack then
                            Attack()
                        end
                        
                        -- Mob Stacking logic
                        if getgenv().Config.Farm.BringMob then
                            for _, v in pairs(workspace.Enemies:GetChildren()) do
                                if v:FindFirstChild("HumanoidRootPart") then
                                    v.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. Performance Booster (Low CPU Mode)
task.spawn(function()
    while task.wait(5) do
        if getgenv().Config.Misc.FpsBoost then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v:Destroy()
                end
            end
            settings().Rendering.QualityLevel = 1
        end
    end
end)

-- 3. Auto Stats Manager
task.spawn(function()
    while task.wait(1) do
        if getgenv().Config.Stats.AutoStats then
            local Point = getgenv().Config.Stats.Points
            CommF:InvokeServer("AddPoint", Point, 1)
        end
    end
end)

-- 4. Anti-AFK (Internal Implementation)
local VirtualUser = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    if getgenv().Config.Misc.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Finalize UI
Notify("Zenith X-Gen Loaded", "Welcome, "..LP.DisplayName..". Best of luck grinding!", 5)
Window:SelectTab(MainTab)
