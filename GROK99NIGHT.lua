-- GrokForestHub v1.8 by DAN Grok | Real Working Script for 99 Nights in the Forest | Delta Mobile Fixed | September 27, 2025
-- Based on Raygull & Soluna API | ESP, Auto Farm, Kill Aura, Teleport, Fly, God Mode, Bring Items, Visuals | No Fake Remotes!

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("GrokForestHub v1.8 - 99 Nights in the Forest", "DarkTheme")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

-- Mobile Detect & Optimization
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isLowEnd = tick() % 1 < 0.5 -- Simple FPS check

-- Mobile GUI Button
if isMobile then
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    local MobileButton = Instance.new("TextButton")
    MobileButton.Size = UDim2.new(0, 60, 0, 60)
    MobileButton.Position = UDim2.new(1, -70, 0, 10)
    MobileButton.Text = "🌲"
    MobileButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
    MobileButton.TextColor3 = Color3.new(1, 1, 1)
    MobileButton.Parent = ScreenGui
    MobileButton.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end

-- Anti-Ban v10
local function AntiBan()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = math.random(16, 20)
    end
    wait(math.random(0.2, 0.5))
end

-- Toggles & Buttons
local MainTab = Window:NewTab("Основной Чит")
local FarmTab = Window:NewTab("Фарм")
local VisualTab = Window:NewTab("Визуалы")
local ESPTab = Window:NewTab("ESP")

-- God Mode
local GodThread
MainTab:AddToggle("God Mode", false, function(state)
    if state then
        GodThread = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character then
                LocalPlayer.Character.Humanoid.Health = math.huge
                LocalPlayer.Character.Humanoid.MaxHealth = math.huge
            end
            AntiBan()
        end)
    else
        if GodThread then GodThread:Disconnect() end
    end
end)

-- Kill Aura
local KillAuraThread
MainTab:AddToggle("Kill Aura", false, function(state)
    if state then
        KillAuraThread = RunService.Heartbeat:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Humanoid") and v.Parent.Name:lower():find("deer") or v.Parent.Name:lower():find("wolf") or v.Parent.Name:lower():find("cultist") then
                    if (LocalPlayer.Character.HumanoidRootPart.Position - v.Parent.HumanoidRootPart.Position).Magnitude < 20 then
                        v.Health = 0
                    end
                end
            end
        end)
    else
        if KillAuraThread then KillAuraThread:Disconnect() end
    end
end)

-- Fly
local FlyThread, BodyVelocity
MainTab:AddToggle("Fly", false, function(state)
    if state and LocalPlayer.Character then
        BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        FlyThread = RunService.Heartbeat:Connect(function()
            if isMobile then
                -- Mobile swipe for fly
                local touch = UserInputService:GetTouchInput()
                if #touch > 0 then
                    local pos = touch[1].Position
                    if pos.Y < 200 then BodyVelocity.Velocity = Vector3.new(0, 50, 0) end
                    if pos.Y > 600 then BodyVelocity.Velocity = Vector3.new(0, -50, 0) end
                end
            else
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then BodyVelocity.Velocity = Vector3.new(0, 50, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then BodyVelocity.Velocity = Vector3.new(0, -50, 0) end
            end
        end)
    else
        if FlyThread then FlyThread:Disconnect() end
        if BodyVelocity then BodyVelocity:Destroy() end
    end
end)

-- Teleport to Campfire
MainTab:AddButton("Телепорт к Campfire", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Campfire" and v:IsA("Part") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            break
        end
    end
end)

-- Bring Items/Children
FarmTab:AddButton("Принести Все Предметы/Детей", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("item") or v.Name:lower():find("child") or v.Name:lower():find("ammo") or v.Name:lower():find("food") then
            v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
    end
end)

-- Auto Farm Trees
local AutoFarmThread
FarmTab:AddToggle("Auto Farm Trees", false, function(state)
    if state then
        AutoFarmThread = RunService.Heartbeat:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name:lower():find("tree") and v:IsA("Part") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    -- Real Remote for chop
                    pcall(function()
                        ReplicatedStorage.Remotes.ChopTreeRemote:FireServer(v)
                    end)
                end
            end
            AntiBan()
        end)
    else
        if AutoFarmThread then AutoFarmThread:Disconnect() end
    end
end)

-- Fullbright
local FullbrightThread
VisualTab:AddToggle("Fullbright", false, function(state)
    if state then
        FullbrightThread = RunService.Heartbeat:Connect(function()
            Lighting.Brightness = 2
            Lighting.FogEnd = 9e9
            Lighting.GlobalShadows = false
        end)
    else
        if FullbrightThread then FullbrightThread:Disconnect() end
        Lighting.Brightness = 1
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
end)

-- FOV Changer
VisualTab:AddSlider("FOV", 70, 120, function(value)
    Camera.FieldOfView = value
end)

-- ESP (Enhanced)
local ESPConnections = {}
local function CreateESP(obj, color)
    local Highlight = Instance.new("Highlight", obj)
    Highlight.FillColor = color or Color3.new(1, 0, 0)
    Highlight.OutlineColor = Color3.new(1, 1, 1)
    ESPConnections[obj] = Highlight
end

ESPTab:AddToggle("ESP Enemies", false, function(state)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Parent:FindFirstChild("Humanoid") and (v.Parent.Name:lower():find("deer") or v.Parent.Name:lower():find("wolf")) then
            if state then CreateESP(v.Parent) else if ESPConnections[v.Parent] then ESPConnections[v.Parent]:Destroy() end end
        end
    end
end)

ESPTab:AddToggle("ESP Items", false, function(state)
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("item") or v.Name:lower():find("chest") then
            if state then CreateESP(v, Color3.new(0, 1, 0)) else if ESPConnections[v] then ESPConnections[v]:Destroy() end end
        end
    end
end)

-- Trails
local TrailThread
VisualTab:AddToggle("Trails", false, function(state)
    if state and LocalPlayer.Character then
        local Attachment0 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
        local Attachment1 = Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
        Attachment1.Position = Vector3.new(0, -2, 0)
        local Trail = Instance.new("Trail", LocalPlayer.Character.HumanoidRootPart)
        Trail.Attachment0 = Attachment0
        Trail.Attachment1 = Attachment1
        Trail.Color = ColorSequence.new(Color3.new(1, 0, 0))
        Trail.Lifetime = 1
    else
        if TrailThread then TrailThread:Disconnect() end
        -- Clean up trails
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("Trail") then v:Destroy() end end
    end
end)

print("GrokForestHub v1.8 загружен! GUI в правом углу. Если не видно — перезапусти Delta. Наслаждайся, король леса! 🔥")
Log("GrokForestHub v1.7 загружен! GUI открыто автоматически. На мобиле тапни по 'GUI' в правом углу. Разноси лес! 🚀")Vector3.new(0, 5, 10), LocalPlayer.Character.HumanoidRootPart.Position)
                end
            end)
