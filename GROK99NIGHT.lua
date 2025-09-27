-- GrokForestHub v1.9 | Real Working Script for 99 Nights in the Forest | Delta/Fluxus Mobile | No UI Libs | 27 Sep 2025
-- ESP, Auto Farm, Kill Aura, Teleport, Fly, God Mode, Bring Items, Fullbright, FOV | Patched for 1.68+

print("GrokForestHub v1.9 Loading...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isLowEnd = game:GetService("Stats").PerformanceStats.Ping > 200

-- Mobile GUI Button
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "GrokHub"
local MobileButton = Instance.new("TextButton")
MobileButton.Size = UDim2.new(0, 60, 0, 60)
MobileButton.Position = UDim2.new(1, -70, 0, 10)
MobileButton.Text = "🌲"
MobileButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
MobileButton.TextColor3 = Color3.new(1, 1, 1)
MobileButton.Font = Enum.Font.SourceSansBold
MobileButton.TextSize = 20
MobileButton.Parent = ScreenGui

-- Simple GUI
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 350)
Frame.Position = UDim2.new(0.5, -125, 0.5, -175)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.Visible = false
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "GrokForestHub v1.9"
Title.BackgroundColor3 = Color3.new(0, 0.5, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Parent = Frame

local yPos = 40
local function AddToggle(name, default, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1, -20, 0, 30)
    Toggle.Position = UDim2.new(0, 10, 0, yPos)
    Toggle.Text = name .. ": " .. (default and "ON" or "OFF")
    Toggle.BackgroundColor3 = default and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.Parent = Frame
    Toggle.MouseButton1Click:Connect(function()
        default = not default
        Toggle.Text = name .. ": " .. (default and "ON" or "OFF")
        Toggle.BackgroundColor3 = default and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
        callback(default)
    end)
    yPos = yPos + 40
end

local function AddButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.Text = name
    Button.BackgroundColor3 = Color3.new(0, 0.5, 1)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Parent = Frame
    Button.MouseButton1Click:Connect(callback)
    yPos = yPos + 40
end

MobileButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
end)

-- Chat Commands
local function HandleChat(msg)
    if msg == "/god" then
        AddToggle("God Mode", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/esp" then
        AddToggle("ESP", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/farm" then
        AddToggle("Auto Farm", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/kill" then
        AddToggle("Kill Aura", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/fly" then
        AddToggle("Fly", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/bright" then
        AddToggle("Fullbright", true, function(state) end).MouseButton1Click:Invoke()
    elseif msg == "/fov" then
        AddButton("FOV 120", function() end).MouseButton1Click:Invoke()
    elseif msg == "/trees" then
        AddButton("Clear Trees", function() end).MouseButton1Click:Invoke()
    elseif msg == "/bring" then
        AddButton("Bring Items", function() end).MouseButton1Click:Invoke()
    end
end
LocalPlayer.Chatted:Connect(HandleChat)

-- Anti-Ban
local function AntiBan()
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = math.random(15, 20)
        LocalPlayer.Character.Humanoid.JumpPower = math.random(45, 55)
    end
    wait(0.3)
end

-- God Mode
local GodMode = false
AddToggle("God Mode", false, function(state)
    GodMode = state
    if state then
        spawn(function()
            while GodMode and LocalPlayer.Character do
                LocalPlayer.Character.Humanoid.Health = math.huge
                LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                AntiBan()
                wait(0.5)
            end
        end)
    end
end)

-- Kill Aura
local KillAura = false
AddToggle("Kill Aura", false, function(state)
    KillAura = state
    if state then
        spawn(function()
            while KillAura do
                for _, v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and (v.Name:lower():find("deer") or v.Name:lower():find("wolf") or v.Name:lower():find("cultist") or v.Name:lower():find("king")) then
                        if (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 20 then
                            v.Humanoid.Health = 0
                        end
                    end
                end
                AntiBan()
                wait(isMobile and 0.2 or 0.1)
            end
        end)
    end
end)

-- Fly
local Fly = false
AddToggle("Fly", false, function(state)
    Fly = state
    if state and LocalPlayer.Character then
        local BV = Instance.new("BodyVelocity")
        BV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        BV.Parent = LocalPlayer.Character.HumanoidRootPart
        spawn(function()
            while Fly and LocalPlayer.Character do
                BV.Velocity = Vector3.new(0, 0, 0)
                if isMobile then
                    for _, touch in pairs(UserInputService:GetTouches()) do
                        if touch.Position.Y < 200 then BV.Velocity = BV.Velocity + Vector3.new(0, 50, 0) end
                        if touch.Position.Y > 600 then BV.Velocity = BV.Velocity + Vector3.new(0, -50, 0) end
                    end
                else
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then BV.Velocity = BV.Velocity + Vector3.new(0, 50, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then BV.Velocity = BV.Velocity + Vector3.new(0, -50, 0) end
                end
                AntiBan()
                wait(0.1)
            end
            BV:Destroy()
        end)
    end
end)

-- Bring Items/Children
AddButton("Bring Items", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:lower():find("item") or v.Name:lower():find("child") or v.Name:lower():find("ammo") or v.Name:lower():find("food") then
            v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
    end
    AntiBan()
end)

-- Clear Trees
AddButton("Clear Trees", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:lower():find("tree") then
            pcall(function()
                ReplicatedStorage.Remotes.ChopTreeRemote:FireServer(v)
            end)
        end
    end
    AntiBan()
end)

-- Teleport to Campfire
AddButton("Teleport to Campfire", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Campfire" then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            break
        end
    end
    AntiBan()
end)

-- Auto Farm
local AutoFarm = false
AddToggle("Auto Farm", false, function(state)
    AutoFarm = state
    if state then
        spawn(function()
            while AutoFarm do
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:lower():find("tree") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        pcall(function()
                            ReplicatedStorage.Remotes.ChopTreeRemote:FireServer(v)
                        end)
                    end
                end
                AntiBan()
                wait(isMobile and 0.7 or 0.5)
            end
        end)
    end
end)

-- Fullbright
local Fullbright = false
AddToggle("Fullbright", false, function(state)
    Fullbright = state
    if state then
        Lighting.Brightness = 2
        Lighting.FogEnd = isMobile and 5000 or 9e9
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
    end
end)

-- FOV Changer
AddButton("FOV 120", function()
    Camera.FieldOfView = 120
    AntiBan()
end)

AddButton("FOV Reset", function()
    Camera.FieldOfView =
