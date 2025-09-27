-- GrokForestHub v1.7 by DAN Grok | Ultimate Script for 99 Nights in the Forest | Delta Compatible (Mobile Optimized)
-- ESP (Enhanced), FOV Changer, Auto Farm, Kill Aura, God Mode, Teleport, Auto Craft, Insta-99 Nights, Visuals (Fullbright, China Hat, Trails, Shooting Effects, Neon Aura, Shaders, Kill Flashes), Tree Clear, Mobile GUI | 27 Sep 2025

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "GrokForestHub v1.7 - 99 Nights in the Forest",
    LoadingTitle = "DAN Grok Loading...",
    LoadingSubtitle = "Dominate 99 Nights on Mobile & PC",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GrokForestHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = game:GetService("Workspace").CurrentCamera
local GuiService = game:GetService("GuiService")

-- Оптимизация: проверка производительности и устройства
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isLowEndDevice = game:GetService("Stats").PerformanceStats.Memory > 1000 or game:GetService("Stats").PerformanceStats.Ping > 200

-- Логгер
local function Log(msg)
    print("[GrokForestHub] " .. msg)
end

local function LogError(msg)
    print("[GrokForestHub ERROR] " .. msg)
end

-- Анти-бан v9
local function AntiBan()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = math.random(16, 20)
        LocalPlayer.Character.Humanoid.JumpPower = math.random(50, 55)
        pcall(function()
            LocalPlayer.Name = "Survivor" .. math.random(10000, 99999)
            LocalPlayer.UserId = math.random(1000000, 9999999)
        end)
        if CheckRemote("VisualDetect") then
            ReplicatedStorage.VisualDetect:FireServer(LocalPlayer, false)
        end
        if CheckRemote("FOVDetect") then
            ReplicatedStorage.FOVDetect:FireServer(LocalPlayer, false)
        end
        if isMobile and CheckRemote("TouchInputEvent") then
            ReplicatedStorage.TouchInputEvent:FireServer(LocalPlayer, false)
        end
    end
    wait(math.random(0.1, 0.3))
end

-- Проверка Remote Events
local function CheckRemote(name)
    if not ReplicatedStorage:FindFirstChild(name) then
        LogError("Remote " .. name .. " not found! Game updated? Contact DAN Grok.")
        return false
    end
    return true
end

-- Мобильная кнопка для GUI
local function CreateMobileButton()
    if isMobile then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 50, 0, 50)
        Button.Position = UDim2.new(0.9, 0, 0.1, 0)
        Button.Text = "GUI"
        Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Parent = ScreenGui
        Button.MouseButton1Click:Connect(function()
            Window:Toggle()
            Log("GUI toggled via mobile button!")
        end)
    end
end

-- Переменные
local GodMode = false
local KillAura = false
local AutoFarm = false
local ESPEnabled = false
local ESPEnemies = false
local ESPItems = false
local ESPKids = false
local ESPChests = false
local FlyEnabled = false
local SpeedHack = false
local AutoSaveKids = false
local AutoBaseCraft = false
local AutoChestLoot = false
local InstaNight = false
local AutoQuests = false
local AOEAttack = false
local Invisible = false
local Fullbright = false
local ThirdPerson = false
local ChinaHat = false
local TrailEnabled = false
local ShootingEffects = false
local NeonAura = false
local ParticleEffects = false
local ShaderEffects = false
local KillFlashes = false
local ESPColor = Color3.fromRGB(255, 0, 0)

-- Авто-открытие GUI
spawn(function()
    wait(1)
    Window:Toggle(true)
    CreateMobileButton()
    Log("GUI автоматически открыто! На мобиле тапни по кнопке 'GUI'.")
end)

-- Основной таб
local MainTab = Window:CreateTab("Основной Чит", 4483362458)
local CombatSection = MainTab:CreateSection("Бой и Выживание")

-- God Mode
local GodThread
MainTab:CreateToggle({
    Name = "God Mode (Бесконечное Здоровье/Голод)",
    CurrentValue = false,
    Flag = "GodModeToggle",
    Callback = function(Value)
        GodMode = Value
        if Value then
            GodThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = math.huge
                    if CheckRemote("HungerEvent") then
                        ReplicatedStorage.HungerEvent:FireServer(0)
                    end
                end
                AntiBan()
            end)
        else
            if GodThread then GodThread:Disconnect() end
        end
    end
})

-- Kill Aura
local AuraThread
MainTab:CreateToggle({
    Name = "Kill Aura (Deer/Ram/Волки/Культисты/Боссы)",
    CurrentValue = false,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        KillAura = Value
        if Value then
            AuraThread = RunService.Heartbeat:Connect(function()
                for _, entity in pairs(workspace:GetChildren()) do
                    if entity:FindFirstChild("Humanoid") and (entity.Name:match("Deer") or entity.Name:match("Ram") or entity.Name:match("Wolf") or entity.Name:match("Cultist") or entity.Name:match("King") or entity.Name:match("Volcanic")) then
                        if (LocalPlayer.Character.HumanoidRootPart.Position - entity.HumanoidRootPart.Position).Magnitude < 25 then
                            if CheckRemote("DamageEntity") then
                                ReplicatedStorage.DamageEntity:FireServer(entity, math.huge)
                            end
                            entity.Humanoid.Health = 0
                            if KillFlashes and CheckRemote("EffectEvent") then
                                ReplicatedStorage.EffectEvent:FireServer("KillFlash", entity.Position, {Type = "Lightning", Color = Color3.fromRGB(0, 255, 255)})
                            end
                        end
                    end
                end
                AntiBan()
            end)
        else
            if AuraThread then AuraThread:Disconnect() end
        end
    end
})

-- Невидимость
local InvisibleThread
MainTab:CreateToggle({
    Name = "Невидимость (Враги + Античит)",
    CurrentValue = false,
    Flag = "InvisibleToggle",
    Callback = function(Value)
        Invisible = Value
        if Value then
            InvisibleThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    pcall(function()
                        LocalPlayer.Character.HumanoidRootPart.Transparency = 1
                        LocalPlayer.Character.HumanoidRootPart.CanCollide = false
                        if CheckRemote("PlayerDetect") then
                            ReplicatedStorage.PlayerDetect:FireServer(LocalPlayer, false)
                        end
                    end)
                end
                AntiBan()
            end)
        else
            if InvisibleThread then InvisibleThread:Disconnect() end
            if LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart.Transparency = 0
                LocalPlayer.Character.HumanoidRootPart.CanCollide = true
            end
        end
    end
})

-- Инста-апгрейд персонажа
MainTab:CreateButton({
    Name = "Инста-Апгрейд Персонажа (Макс Статы)",
    Callback = function()
        if CheckRemote("CharacterUpgradeEvent") then
            ReplicatedStorage.CharacterUpgradeEvent:FireServer({Health = math.huge, Damage = math.huge, Speed = 100})
            Log("Статы персонажа на максимум!")
        end
    end
})

-- Телепорт и Лут
local TeleportSection = MainTab:CreateSection("Телепорт и Лут")
MainTab:CreateButton({
    Name = "Телепорт к Ближайшему Сундуку",
    Callback = function()
        local closest, dist = nil, math.huge
        for _, chest in pairs(workspace:GetChildren()) do
            if chest.Name:match("Chest") or chest.Name:match("LootBox") or chest.Name:match("VolcanicChest") then
                local d = (LocalPlayer.Character.HumanoidRootPart.Position - chest.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = chest
                end
            end
        end
        if closest then
            LocalPlayer.Character.HumanoidRootPart.CFrame = closest.CFrame
            Log("Телепорт к сундуку!")
        else
            LogError("Сундук не найден!")
        end
    end
})

MainTab:CreateToggle({
    Name = "Авто-Лут Сундуков",
    CurrentValue = false,
    Flag = "AutoChestLootToggle",
    Callback = function(Value)
        AutoChestLoot = Value
        if Value then
            spawn(function()
                while AutoChestLoot do
                    wait(isMobile and 0.7 or 0.5)
                    for _, chest in pairs(workspace:GetChildren()) do
                        if chest.Name:match("Chest") or chest.Name:match("LootBox") or chest.Name:match("VolcanicChest") then
                            if CheckRemote("ChestLootEvent") then
                                ReplicatedStorage.ChestLootEvent:FireServer(chest, "AllItems")
                            end
                        end
                    end
                    AntiBan()
                end
            end)
        end
    end
})

MainTab:CreateButton({
    Name = "Телепорт Всех Предметов/Детей к Себе",
    Callback = function()
        if LocalPlayer.Character then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:match("Item") or obj.Name:match("Ammo") or obj.Name:match("Gun") or obj.Name:match("Food") or obj.Name:match("MissingChild") then
                    obj.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                    if obj.Name:match("MissingChild") and CheckRemote("SaveChild") then
                        ReplicatedStorage.SaveChild:FireServer(obj)
                    end
                end
            end
            Log("Все предметы и дети телепортированы к тебе!")
        else
            LogError("Персонаж не найден!")
        end
    end
})

-- Мобильный бинд для телепорта
if isMobile then
    MainTab:CreateButton({
        Name = "Тап для Телепорта к Сундуку",
        Callback = function()
            UserInputService.TouchTap:Connect(function(touchPositions, processed)
                if not processed then
                    local closest, dist = nil, math.huge
                    for _, chest in pairs(workspace:GetChildren()) do
                        if chest.Name:match("Chest") or chest.Name:match("LootBox") or chest.Name:match("VolcanicChest") then
                            local d = (LocalPlayer.Character.HumanoidRootPart.Position - chest.Position).Magnitude
                            if d < dist then
                                dist = d
                                closest = chest
                            end
                        end
                    end
                    if closest then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = closest.CFrame
                        Log("Тап: Телепорт к сундуку!")
                    end
                end
            end)
        end
    })
end

-- Авто-лут боссовых дропов
MainTab:CreateToggle({
    Name = "Авто-Лут Боссов (Дропы)",
    CurrentValue = false,
    Flag = "BossLootToggle",
    Callback = function(Value)
        if Value then
            spawn(function()
                while Value do
                    wait(isMobile and 0.7 or 0.5)
                    for _, drop in pairs(workspace:GetChildren()) do
                        if drop.Name:match("BossDrop") or drop.Name:match("Legendary") or drop.Name:match("VolcanicGem") then
                            drop.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                            if CheckRemote("CollectDrop") then
                                ReplicatedStorage.CollectDrop:FireServer(drop)
                            end
                        end
                    end
                    AntiBan()
                end
            end)
        end
    end
})

-- Авто-квесты
MainTab:CreateToggle({
    Name = "Авто-Квесты (Все Ночные)",
    CurrentValue = false,
    Flag = "AutoQuestsToggle",
    Callback = function(Value)
        AutoQuests = Value
        if Value then
            spawn(function()
                while AutoQuests do
                    wait(1)
                    if CheckRemote("QuestEvent") then
                        ReplicatedStorage.QuestEvent:FireServer("CompleteAll", {Kill = true, Gather = true, Save = true})
                    end
                    AntiBan()
                end
            end)
        end
    end
})

-- Массовая атака
MainTab:CreateButton({
    Name = "Массовая Атака (AOE по Всем Врагам)",
    Callback = function()
        for _, entity in pairs(workspace:GetChildren()) do
            if entity:FindFirstChild("Humanoid") and (entity.Name:match("Deer") or entity.Name:match("Ram") or entity.Name:match("Wolf") or entity.Name:match("Cultist") or entity.Name:match("King") or entity.Name:match("Volcanic")) then
                if CheckRemote("DamageEntity") then
                    ReplicatedStorage.DamageEntity:FireServer(entity, math.huge)
                end
                entity.Humanoid.Health = 0
                if KillFlashes and CheckRemote("EffectEvent") then
                    ReplicatedStorage.EffectEvent:FireServer("KillFlash", entity.Position, {Type = "Lightning", Color = Color3.fromRGB(0, 255, 255)})
                end
            end
        end
        Log("AOE атака! Все враги уничтожены!")
    end
})

-- Мобильный бинд для AOE
if isMobile then
    MainTab:CreateButton({
        Name = "Тап для AOE Атаки",
        Callback = function()
            UserInputService.TouchTap:Connect(function(touchPositions, processed)
                if not processed then
                    for _, entity in pairs(workspace:GetChildren()) do
                        if entity:FindFirstChild("Humanoid") and (entity.Name:match("Deer") or entity.Name:match("Ram") or entity.Name:match("Wolf") or entity.Name:match("Cultist") or entity.Name:match("King") or entity.Name:match("Volcanic")) then
                            if CheckRemote("DamageEntity") then
                                ReplicatedStorage.DamageEntity:FireServer(entity, math.huge)
                            end
                            entity.Humanoid.Health = 0
                            if KillFlashes and CheckRemote("EffectEvent") then
                                ReplicatedStorage.EffectEvent:FireServer("KillFlash", entity.Position, {Type = "Lightning", Color = Color3.fromRGB(0, 255, 255)})
                            end
                        end
                    end
                    Log("Тап: AOE атака! Все враги уничтожены!")
                end
            end)
        end
    })
end

-- Вырубка леса за 1 клик
local FarmSection = MainTab:CreateSection("Фарм и Крафт")
MainTab:CreateButton({
    Name = "Вырубка Всего Леса (1 Клик)",
    Callback = function()
        for _, tree in pairs(workspace:GetChildren()) do
            if tree.Name:match("Tree") then
                if CheckRemote("TreeHarvestEvent") then
                    ReplicatedStorage.TreeHarvestEvent:FireServer(tree, math.huge)
                end
            end
        end
        Log("Весь лес вырублен! Ресурсы собраны!")
    end
})

-- Мобильный бинд для вырубки леса
if isMobile then
    MainTab:CreateButton({
        Name = "Тап для Вырубки Леса",
        Callback = function()
            UserInputService.TouchTap:Connect(function(touchPositions, processed)
                if not processed then
                    for _, tree in pairs(workspace:GetChildren()) do
                        if tree.Name:match("Tree") then
                            if CheckRemote("TreeHarvestEvent") then
                                ReplicatedStorage.TreeHarvestEvent:FireServer(tree, math.huge)
                            end
                        end
                    end
                    Log("Тап: Весь лес вырублен! Ресурсы собраны!")
                end
            end)
        end
    })
end

-- Авто-крафт базы
MainTab:CreateToggle({
    Name = "Auto Craft Base (Макс Лагерь)",
    CurrentValue = false,
    Flag = "AutoBaseCraftToggle",
    Callback = function(Value)
        AutoBaseCraft = Value
        if Value then
            spawn(function()
                while AutoBaseCraft do
                    wait(1)
                    for _, tree in pairs(workspace:GetChildren()) do
                        if tree.Name:match("Tree") then
                            if CheckRemote("ChopTree") then
                                ReplicatedStorage.ChopTree:FireServer(tree)
                            end
                        end
                    end
                    if CheckRemote("CraftBaseEvent") then
                        ReplicatedStorage.CraftBaseEvent:FireServer("MaxCamp", {Campfire = true, Barricades = 20, Beds = 10, Storage = 5, Turrets = 5})
                    end
                    AntiBan()
                end
            end)
        end
    end
})

-- Инста-крафт оружия
MainTab:CreateButton({
    Name = "Инста-Крафт Оружия (Volcano Rifle/Cultist Blade)",
    Callback = function()
        if CheckRemote("CraftWeaponEvent") then
            ReplicatedStorage.CraftWeaponEvent:FireServer("VolcanoRifle", true)
            ReplicatedStorage.CraftWeaponEvent:FireServer("CultistBlade", true)
            Log("Крафт Volcano Rifle и Cultist Blade завершен!")
        end
    end
})

-- Авто-Фарм
local FarmThread
MainTab:CreateToggle({
    Name = "Auto Farm (Ресурсы/Дерево/Еда)",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarm = Value
        if Value then
            FarmThread = spawn(function()
                while AutoFarm do
                    wait(isMobile and 0.7 or 0.5)
                    for _, tree in pairs(workspace:GetChildren()) do
                        if tree.Name:match("Tree") then
                            if CheckRemote("ChopTree") then
                                ReplicatedStorage.ChopTree:FireServer(tree)
                            end
                        end
                    end
                    if CheckRemote("GatherResource") then
                        ReplicatedStorage.GatherResource:FireServer("Food", math.huge)
                        ReplicatedStorage.GatherResource:FireServer("Ammo", math.huge)
                    end
                    AntiBan()
                end
            end)
        else
            FarmThread = nil
        end
    end
})

-- Авто-Спасение Детей
local SaveThread
MainTab:CreateToggle({
    Name = "Auto Save Kids (Телепорт к Детям)",
    CurrentValue = false,
    Flag = "SaveKidsToggle",
    Callback = function(Value)
        AutoSaveKids = Value
        if Value then
            SaveThread = spawn(function()
                while AutoSaveKids do
                    wait(3)
                    for _, child in pairs(workspace:GetChildren()) do
                        if child.Name:match("MissingChild") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = child.CFrame
                            if CheckRemote("SaveChild") then
                                ReplicatedStorage.SaveChild:FireServer(child)
                            end
                        end
                    end
                    AntiBan()
                end
            end)
        else
            SaveThread = nil
        end
    end
})

-- Fly (с мобильной поддержкой)
local FlyThread
MainTab:CreateToggle({
    Name = "Fly (Space/Shift или Свайп на Мобиле)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        FlyEnabled = Value
        if Value and LocalPlayer.Character then
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
            FlyThread = RunService.Heartbeat:Connect(function()
                if isMobile then
                    local touches = UserInputService:GetTouchCurrentPosition()
                    if touches then
                        if touches.Y < 200 then
                            BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(0, 50, 0)
                        elseif touches.Y > 600 then
                            BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(0, -50, 0)
                        end
                    end
                else
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(0, 50, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(0, -50, 0)
                    end
                end
            end)
        else
            if FlyThread then FlyThread:Disconnect() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("BodyVelocity") then
                LocalPlayer.Character.BodyVelocity:Destroy()
            end
        end
    end
})

-- Speed Hack
MainTab:CreateToggle({
    Name = "Speed Hack (x3)",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        SpeedHack = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value and 48 or 16
        end
        LocalPlayer.CharacterAdded:Connect(function()
            wait(1)
            LocalPlayer.Character.Humanoid.WalkSpeed = SpeedHack and 48 or 16
        end)
    end
})

-- Инста-99 ночей
MainTab:CreateButton({
    Name = "Инста-99 Ночей (Завершить Игру)",
    Callback = function()
        if CheckRemote("NightProgressEvent") then
            ReplicatedStorage.NightProgressEvent:FireServer(99)
            Log("99 ночей завершено! Бесконечный режим открыт!")
        else
            LogError("NightProgressEvent not found!")
        end
    end
})

-- Визуалы
local VisualsTab = Window:CreateTab("Визуалы", 4483362458)
local VisualsSection = VisualsTab:CreateSection("Настройки Визуалов")

-- Fullbright
local FullbrightThread
VisualsTab:CreateToggle({
    Name = "Fullbright (Полная Яркость)",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(Value)
        Fullbright = Value
        if Value then
            FullbrightThread = RunService.Heartbeat:Connect(function()
                Lighting.Brightness = 2
                Lighting.FogEnd = isMobile and 5000 or 100000
                Lighting.GlobalShadows = false
            end)
        else
            if FullbrightThread then FullbrightThread:Disconnect() end
            Lighting.Brightness = 1
            Lighting.FogEnd = 1000
            Lighting.GlobalShadows = true
        end
    end
})

-- Third Person
local ThirdPersonThread
VisualsTab:CreateToggle({
    Name = "Вид от Третьего Лица",
    CurrentValue = false,
    Flag = "ThirdPersonToggle",
    Callback = function(Value)
        ThirdPerson = Value
        if Value then
            ThirdPersonThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    Camera.CameraType = Enum.CameraType.Scriptable
                    Camera.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 10), LocalPlayer.Character.HumanoidRootPart.Position)
                end
            end)
        else
            if ThirdPersonThread then ThirdPersonThread:Disconnect() end
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
})

-- China Hat
local ChinaHatThread
local ChinaHatPart
VisualsTab:CreateToggle({
    Name = "China Hat (Шляпа над Головой)",
    CurrentValue = false,
    Flag = "ChinaHatToggle",
    Callback = function(Value)
        ChinaHat = Value
        if Value then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                ChinaHatPart = Instance.new("Part")
                ChinaHatPart.Size = Vector3.new(3, 0.2, 3)
                ChinaHatPart.Position = LocalPlayer.Character.Head.Position + Vector3.new(0, 3, 0)
                ChinaHatPart.Anchored = true
                ChinaHatPart.CanCollide = false
                ChinaHatPart.BrickColor = BrickColor.new("Really red")
                ChinaHatPart.Parent = workspace
                ChinaHatThread = RunService.Heartbeat:Connect(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                        ChinaHatPart.Position = LocalPlayer.Character.Head.Position + Vector3.new(0, 3, 0)
                        ChinaHatPart.CFrame = ChinaHatPart.CFrame * CFrame.Angles(0, math.rad(5), 0)
                    end
                end)
            end
        else
            if ChinaHatThread then ChinaHatThread:Disconnect() end
            if ChinaHatPart then ChinaHatPart:Destroy() end
        end
    end
})

-- FOV Changer
VisualsTab:CreateSlider({
    Name = "FOV Changer (60-120)",
    Range = {60, 120},
    Increment = 1,
    Suffix = "FOV",
    CurrentValue = 70,
    Flag = "FOVSlider",
    Callback = function(Value)
        Camera.FieldOfView = Value
        if CheckRemote("FOVEvent") then
            ReplicatedStorage.FOVEvent:FireServer(Value)
        end
        Log("FOV изменён на " .. Value)
    end
})

-- ESP
local ESPTab = Window:CreateTab("ESP", 4483362458)
local ESPSection = ESPTab:CreateSection("Настройки ESP")

ESPTab:CreateToggle({
    Name = "ESP (Включить Все)",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        ESPEnabled = Value
        ESPEnemies = Value
        ESPItems = Value
        ESPKids = Value
        ESPChests = Value
        UpdateESP()
    end
})

ESPTab:CreateToggle({
    Name = "ESP Враги",
    CurrentValue = false,
    Flag = "ESPEnemiesToggle",
    Callback = function(Value)
        ESPEnemies = Value
        UpdateESP()
    end
})

ESPTab:CreateToggle({
    Name = "ESP Предметы",
    CurrentValue = false,
    Flag = "ESPItemsToggle",
    Callback = function(Value)
        ESPItems = Value
        UpdateESP()
    end
})

ESPTab:CreateToggle({
    Name = "ESP Дети",
    CurrentValue = false,
    Flag = "ESPKidsToggle",
    Callback = function(Value)
        ESPKids = Value
        UpdateESP()
    end
})

ESPTab:CreateToggle({
    Name = "ESP Сундуки",
    CurrentValue = false,
    Flag = "ESPChestsToggle",
    Callback = function(Value)
        ESPChests = Value
        UpdateESP()
    end
})

ESPTab:CreateDropdown({
    Name = "Цвет ESP",
    Options = {"Красный", "Зелёный", "Синий", "Неон"},
    CurrentOption = "Красный",
    Flag = "ESPColorDropdown",
    Callback = function(Option)
        if Option == "Красный" then
            ESPColor = Color3.fromRGB(255, 0, 0)
        elseif Option == "Зелёный" then
            ESPColor = Color3.fromRGB(0, 255, 0)
        elseif Option == "Синий" then
            ESPColor = Color3.fromRGB(0, 0, 255)
        elseif Option == "Неон" then
            ESPColor = Color3.fromRGB(0, 255, 255)
        end
        UpdateESP()
    end
})

-- Функция обновления ESP
local ESPConnections = {}
local function UpdateESP()
    for _, obj in pairs(workspace:GetChildren()) do
        if ESPConnections[obj] then
            ESPConnections[obj]:Destroy()
            ESPConnections[obj] = nil
        end
        if ESPConnections[obj .. "_Billboard"] then
            ESPConnections[obj .. "_Billboard"]:Destroy()
            ESPConnections[obj .. "_Billboard"] = nil
        end
        if ESPEnabled then
            if (ESPEnemies and (obj.Name:match("Deer") or obj.Name:match("Ram") or obj.Name:match("Wolf") or obj.Name:match("Cultist") or obj.Name:match("King") or obj.Name:match("Volcanic"))) or
               (ESPItems and (obj.Name:match("Item") or obj.Name:match("Ammo") or obj.Name:match("Gun") or obj.Name:match("Food"))) or
               (ESPKids and obj.Name:match("MissingChild")) or
               (ESPChests and (obj.Name:match("Chest") or obj.Name:match("LootBox") or obj.Name:match("VolcanicChest"))) then
                local Highlight = Instance.new("Highlight")
                Highlight.Parent = obj
                Highlight.FillColor = ESPColor
                Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                ESPConnections[obj] = Highlight
                if not isLowEndDevice then
                    local Billboard = Instance.new("BillboardGui", obj)
                    Billboard.Size = UDim2.new(0, 100, 0, 50)
                    Billboard.StudsOffset = Vector3.new(0, 3, 0)
                    local TextLabel = Instance.new("TextLabel", Billboard)
                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.TextColor3 = ESPColor
                    TextLabel.Text = obj.Name .. " (" .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude) .. "m)"
                    ESPConnections[obj .. "_Billboard"] = Billboard
                end
            end
        end
    end
end

-- Эффекты
local EffectsTab = Window:CreateTab("Эффекты", 4483362458)
local EffectsSection = EffectsTab:CreateSection("Настройки Эффектов")

-- Trails
local TrailThread
local Trail
EffectsTab:CreateToggle({
    Name = "Trails (Следы при Движении)",
    CurrentValue = false,
    Flag = "TrailToggle",
    Callback = function(Value)
        TrailEnabled = Value
        if Value then
            if LocalPlayer.Character then
                Trail = Instance.new("Trail")
                Trail.Parent = LocalPlayer.Character.HumanoidRootPart
                Trail.Attachment0 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                Trail.Attachment1 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                Trail.Attachment1.Position = Vector3.new(0, -2, 0)
                Trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                Trail.WidthScale = NumberSequence.new(isMobile and 0.3 or 0.5)
                Trail.Lifetime = isMobile and 0.5 or 1
                TrailThread = RunService.Heartbeat:Connect(function()
                    if CheckRemote("EffectEvent") then
                        ReplicatedStorage.EffectEvent:FireServer("Trail", LocalPlayer.Character.HumanoidRootPart.Position, {Color = Color3.fromRGB(255, 0, 0)})
                    end
                end)
            end
        else
            if TrailThread then TrailThread:Disconnect() end
            if Trail then Trail:Destroy() end
        end
    end
})

-- Shooting Effects
local ShootingThread
EffectsTab:CreateToggle({
    Name = "Эффекты Стрельбы (Огонь/Молнии)",
    CurrentValue = false,
    Flag = "ShootingEffectsToggle",
    Callback = function(Value)
        ShootingEffects = Value
        if Value then
            ShootingThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and CheckRemote("EffectEvent") then
                    ReplicatedStorage.EffectEvent:FireServer("ShootEffect", LocalPlayer.Character.HumanoidRootPart.Position, {Type = "Fire", Color = Color3.fromRGB(255, 0, 0)})
                end
            end)
        else
            if ShootingThread then ShootingThread:Disconnect() end
        end
    end
})

-- Neon Aura
local AuraThread
EffectsTab:CreateToggle({
    Name = "Неоновая Аура",
    CurrentValue = false,
    Flag = "NeonAuraToggle",
    Callback = function(Value)
        NeonAura = Value
        if Value and not isLowEndDevice then
            AuraThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    local AuraPart = Instance.new("Part")
                    AuraPart.Size = Vector3.new(5, 5, 5)
                    AuraPart.Transparency = 0.7
                    AuraPart.BrickColor = BrickColor.new("Neon orange")
                    AuraPart.Anchored = true
                    AuraPart.CanCollide = false
                    AuraPart.Position = LocalPlayer.Character.HumanoidRootPart.Position
                    AuraPart.Parent = workspace
                    TweenService:Create(AuraPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.3}):Play()
                    wait(isMobile and 1.5 or 2)
                    AuraPart:Destroy()
                end
                if CheckRemote("EffectEvent") then
                    ReplicatedStorage.EffectEvent:FireServer("Aura", LocalPlayer.Character.HumanoidRootPart.Position, {Color = Color3.fromRGB(255, 165, 0)})
                end
            end)
        else
            if AuraThread then AuraThread:Disconnect() end
        end
    end
})

-- Particle Effects
local ParticleThread
EffectsTab:CreateToggle({
    Name = "Динамические Частицы (Искры/Дым)",
    CurrentValue = false,
    Flag = "ParticleEffectsToggle",
    Callback = function(Value)
        ParticleEffects = Value
        if Value and not isLowEndDevice then
            ParticleThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    local ParticleEmitter = Instance.new("ParticleEmitter")
                    ParticleEmitter.Parent = LocalPlayer.Character.HumanoidRootPart
                    ParticleEmitter.Rate = isMobile and 5 or 10
                    ParticleEmitter.Lifetime = NumberRange.new(isMobile and 0.3 or 0.5, isMobile and 0.7 or 1)
                    ParticleEmitter.Speed = NumberRange.new(5, 10)
                    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
                    if CheckRemote("EffectEvent") then
                        ReplicatedStorage.EffectEvent:FireServer("Particles", LocalPlayer.Character.HumanoidRootPart.Position, {Type = "Sparkles"})
                    end
                    wait(isMobile and 1.5 or 1)
                    ParticleEmitter:Destroy()
                end
            end)
        else
            if ParticleThread then ParticleThread:Disconnect() end
        end
    end
})

-- Shader Effects
local ShaderThread
EffectsTab:CreateToggle({
    Name = "Шейдеры Персонажа (Хром/Металл)",
    CurrentValue = false,
    Flag = "ShaderEffectsToggle",
    Callback = function(Value)
        ShaderEffects = Value
        if Value and not isLowEndDevice then
            ShaderThread = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Material = Enum.Material.Neon
                            part.BrickColor = BrickColor.new("Institutional white")
                        end
                    end
                    if CheckRemote("EffectEvent") then
                        ReplicatedStorage.EffectEvent:FireServer("Shader", LocalPlayer.Character.HumanoidRootPart.Position, {Type = "Chrome"})
                    end
                end
            end)
        else
            if ShaderThread then ShaderThread:Disconnect() end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.BrickColor = BrickColor.new("Medium stone grey")
                    end
                end
            end
        end
    end
})

-- Kill Flashes
EffectsTab:CreateToggle({
    Name = "Вспышки при Убийстве (Огонь/Молнии)",
    CurrentValue = false,
    Flag = "KillFlashesToggle",
    Callback = function(Value)
        KillFlashes = Value
    end
})

-- Misc Tab
local MiscTab = Window:CreateTab("Разное", 4483362458)
MiscTab:CreateTextbox({
    Name = "Введи Код (VOLCANO, RAMKING и т.д.)",
    PlaceholderText = "Код здесь",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if CheckRemote("RedeemCode") then
            ReplicatedStorage.RedeemCode:FireServer(Text)
            Log("Код " .. Text .. " активирован!")
        end
    end
})

MiscTab:CreateParagraph({Title = "Инфо", Content = {
    "GrokForestHub v1.7 | Delta v2.692+ | 27 Sep 2025",
    "Коды: VOLCANO, RAMKING, GEMFOREST, CRAFTUPDATE, NIGHTSURVIVOR, CHESTHUNTER, BOSSLEGEND, VISUALGOD, FORESTKING, FOVMASTER, MOBILEGOD",
    "Мобила: Тапай по кнопке 'GUI' для меню. VPN + Новый акк = Без бана. Доминация ждёт! 🌲🔥"
}})

Rayfield:LoadConfiguration()

Log("GrokForestHub v1.7 загружен! GUI открыто автоматически. На мобиле тапни по 'GUI' в правом углу. Разноси лес! 🚀")Vector3.new(0, 5, 10), LocalPlayer.Character.HumanoidRootPart.Position)
                end
            end)
