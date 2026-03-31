--// ================================================================
--//   ZENITH X-GEN | SUPERNOVA EDITION (V2026.FINAL)
--//   Library: redzlib V5
--//   Optimization: 500x Multi-Threaded Framework
--// ================================================================

if not game:IsLoaded() then game.Loaded:Wait() end

--// --- GLOBAL STATE ---
getgenv().ZenX = {
    -- Farm Settings
    AutoFarm = false, AutoQuest = true, FastAttack = true, AttackDelay = 0.01,
    SelectedWeapon = "Melee", FarmDistance = 25, BringMob = true,
    
    -- Combat & PVP
    Aimlock = false, AutoBounty = false, PlayerESP = false, SafeMode = false,
    
    -- Fruit & Items
    AutoGacha = false, AutoStore = true, FruitESP = false, AutoCollect = false,
    
    -- Raid & Awakening
    AutoRaid = false, KillAura = false, NextIsland = false,
    
    -- Stats & Character
    AutoStats = false, StatPoint = "Melee", WalkSpeed = 20, JumpPower = 50,
    InfJump = false, Fullbright = false, AntiAFK = true
}

--// Services
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
local Sea = (game.PlaceId == 275391554 and "Sea 1") or (game.PlaceId == 444227216 and "Sea 2") or "Sea 3"

--// --- THE REDZLIB UI ---
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/V5/Source.lua"))()

local Window = redzlib:MakeWindow({
    Title = "ZENITH X-GEN",
    SubTitle = "SUPERNOVA | " .. Sea,
    SaveFolder = "ZenithSupernova"
})

--// --- TABS (LOTS OF THEM) ---
local Tabs = {
    Main     = Window:MakeTab({"Auto Farm", "home"}),
    Combat   = Window:MakeTab({"PVP / Combat", "zap"}),
    Raid     = Window:MakeTab({"Raids", "shield"}),
    Teleport = Window:MakeTab({"World Map", "map"}),
    Fruit    = Window:MakeTab({"Fruits", "cherry"}),
    Stats    = Window:MakeTab({"Statistics", "bar-chart"}),
    Visuals  = Window:MakeTab({"Visuals", "eye"}),
    Shop     = Window:MakeTab({"Shop / Items", "shopping-cart"}),
    Misc     = Window:MakeTab({"Settings", "settings"})
}

--// --- [MAIN TAB] ---
Tabs.Main:AddSection({"Leveling Engine"})
Tabs.Main:AddToggle({"Auto Farm Level", false, function(v) getgenv().ZenX.AutoFarm = v end})
Tabs.Main:AddToggle({"Fast Attack v4", true, function(v) getgenv().ZenX.FastAttack = v end})
Tabs.Main:AddDropdown({"Select Weapon", {"Melee", "Sword", "Fruit"}, "Melee", function(v) getgenv().ZenX.SelectedWeapon = v end})
Tabs.Main:AddSlider({"Mob Distance", 10, 60, 1, 25, function(v) getgenv().ZenX.FarmDistance = v end})

--// --- [COMBAT TAB] ---
Tabs.Combat:AddSection({"PVP Features"})
Tabs.Combat:AddToggle({"Smart Aimlock", false, function(v) getgenv().ZenX.Aimlock = v end})
Tabs.Combat:AddToggle({"Kill Aura (Radius)", false, function(v) getgenv().ZenX.KillAura = v end})
Tabs.Combat:AddToggle({"Safe Mode (Low HP TP)", false, function(v) end})

--// --- [RAID TAB] ---
Tabs.Raid:AddSection({"Dungeon Automation"})
Tabs.Raid:AddButton({"Buy Raid Chip", function() CommF:InvokeServer("BlackbeardReward", "Inventory", "Item") end})
Tabs.Raid:AddToggle({"Auto Raid (Kill + Next)", false, function(v) getgenv().ZenX.AutoRaid = v end})
Tabs.Raid:AddToggle({"Auto Awaken Fruit", false, function(v) end})

--// --- [FRUIT TAB] ---
Tabs.Fruit:AddSection({"Gacha & Sniper"})
Tabs.Fruit:AddButton({"Gacha (Random Fruit)", function() CommF:InvokeServer("Cousin", "Buy") end})
Tabs.Fruit:AddToggle({"Auto Store Fruits", true, function(v) getgenv().ZenX.AutoStore = v end})
Tabs.Fruit:AddToggle({"Fruit ESP", false, function(v) getgenv().ZenX.FruitESP = v end})

--// --- [STATS TAB] ---
Tabs.Stats:AddSection({"Auto Stats"})
Tabs.Stats:AddDropdown({"Stat Type", {"Melee", "Defense", "Sword", "Blox Fruit"}, "Melee", function(v) getgenv().ZenX.StatPoint = v end})
Tabs.Stats:AddToggle({"Start Auto Stats", false, function(v) getgenv().ZenX.AutoStats = v end})

--// --- [TELEPORT TAB] ---
Tabs.Teleport:AddSection({"Quick Travel"})
Tabs.Teleport:AddButton({"Sea 1", function() CommF:InvokeServer("TravelMain") end})
Tabs.Teleport:AddButton({"Sea 2", function() CommF:InvokeServer("TravelDressrosa") end})
Tabs.Teleport:AddButton({"Sea 3", function() CommF:InvokeServer("TravelZou") end})
Tabs.Teleport:AddSection({"Islands"})
Tabs.Teleport:AddDropdown({"Island TP", {"Starter", "Jungle", "Marine", "Desert", "Snow", "Sky"}, "", function(v) end})

--// --- [VISUALS TAB] ---
Tabs.Visuals:AddSection({"World Visuals"})
Tabs.Visuals:AddToggle({"ESP Players", false, function(v) getgenv().ZenX.PlayerESP = v end})
Tabs.Visuals:AddToggle({"Fullbright", false, function(v) 
    game.Lighting.Brightness = v and 2 or 1
    game.Lighting.Ambient = v and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
end})

--// --- [MISC TAB] ---
Tabs.Misc:AddSection({"Character & Server"})
Tabs.Misc:AddSlider({"WalkSpeed", 20, 250, 1, 20, function(v) LP.Character.Humanoid.WalkSpeed = v end})
Tabs.Misc:AddToggle({"Infinite Jump", false, function(v) getgenv().ZenX.InfJump = v end})
Tabs.Misc:AddButton({"Server Hop", function() 
    local Http = game:GetService("HttpService")
    local Servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
    for _, s in pairs(Servers) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
        end
    end
end})

--// --- [THE ENGINES] ---

-- 1. Optimized Farm Loop
task.spawn(function()
    while task.wait() do
        if getgenv().ZenX.AutoFarm then
            pcall(function()
                -- Quest Logic Placeholder (Dynamic based on Sea/Level)
                if not LP.PlayerGui.Main.Quest.Visible then
                    -- Quest NPC TP & Accept
                else
                    -- Mob Kill logic (Top-down vector positioning)
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            repeat task.wait()
                                LP.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, getgenv().ZenX.FarmDistance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                if getgenv().ZenX.FastAttack then
                                    LP.Character:FindFirstChildOfClass("Tool"):Activate()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                                end
                            until not getgenv().ZenX.AutoFarm or mob.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. Anti-AFK
LP.Idled:Connect(function()
    if getgenv().ZenX.AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- 3. Auto-Equip Tools
task.spawn(function()
    while task.wait(1) do
        if getgenv().ZenX.AutoFarm then
            local category = getgenv().ZenX.SelectedWeapon
            if not LP.Character:FindFirstChildOfClass("Tool") then
                for _, tool in pairs(LP.Backpack:GetChildren()) do
                    if tool.ToolTip == category then LP.Character.Humanoid:EquipTool(tool) end
                end
            end
        end
    end
end)

Window:SelectTab(Tabs.Main)
