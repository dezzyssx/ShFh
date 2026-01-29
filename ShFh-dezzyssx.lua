-- ShFh Enhanced by @dezzyxx
-- Version: 2.1
-- Created for flamOus chat
-- Added RGB effects and improved UI

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- RGB цветовые функции
local rgbSpeed = 2
local hue = 0

local function updateHue()
    hue = (hue + rgbSpeed * RunService.RenderStepped:Wait()) % 360
end

local function hsvToRgb(h, s, v)
    h = h % 360
    local c = v * s
    local x = c * (1 - math.abs((h / 60) % 2 - 1))
    local m = v - c
    
    local r1, g1, b1 = 0, 0, 0
    if h < 60 then
        r1, g1, b1 = c, x, 0
    elseif h < 120 then
        r1, g1, b1 = x, c, 0
    elseif h < 180 then
        r1, g1, b1 = 0, c, x
    elseif h < 240 then
        r1, g1, b1 = 0, x, c
    elseif h < 300 then
        r1, g1, b1 = x, 0, c
    else
        r1, g1, b1 = c, 0, x
    end
    
    return Color3.new(r1 + m, g1 + m, b1 + m)
end

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShFhGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 280)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(50, 50, 60)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 90)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок с RGB эффектом
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.BackgroundTransparency = 0.3
Title.Text = "ShFh v2.1 by @dezzyxx"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Версия
local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 60, 0, 20)
Version.Position = UDim2.new(1, -65, 0, 5)
Version.BackgroundTransparency = 1
Version.Text = "v2.1 RGB"
Version.TextColor3 = Color3.fromRGB(150, 150, 200)
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.Parent = Title

-- Контейнер для настроек
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(1, -20, 1, -60)
SettingsFrame.Position = UDim2.new(0, 10, 0, 50)
SettingsFrame.BackgroundTransparency = 1
SettingsFrame.Parent = MainFrame

-- Walk Speed
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Size = UDim2.new(1, 0, 0, 50)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.Parent = SettingsFrame

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Name = "WalkSpeedLabel"
WalkSpeedLabel.Size = UDim2.new(0.6, 0, 1, 0)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "Walk Speed:"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
WalkSpeedLabel.TextSize = 16
WalkSpeedLabel.Font = Enum.Font.Gotham
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedValue = Instance.new("TextBox")
WalkSpeedValue.Name = "WalkSpeedValue"
WalkSpeedValue.Size = UDim2.new(0.3, 0, 0.6, 0)
WalkSpeedValue.Position = UDim2.new(0.6, 0, 0.2, 0)
WalkSpeedValue.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
WalkSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedValue.Text = "139"
WalkSpeedValue.TextSize = 14
WalkSpeedValue.Font = Enum.Font.Gotham
WalkSpeedValue.Parent = WalkSpeedFrame

local WalkSpeedCorner = Instance.new("UICorner")
WalkSpeedCorner.CornerRadius = UDim.new(0, 4)
WalkSpeedCorner.Parent = WalkSpeedValue

-- Fly Speed
local FlySpeedFrame = Instance.new("Frame")
FlySpeedFrame.Name = "FlySpeedFrame"
FlySpeedFrame.Size = UDim2.new(1, 0, 0, 50)
FlySpeedFrame.Position = UDim2.new(0, 0, 0, 50)
FlySpeedFrame.BackgroundTransparency = 1
FlySpeedFrame.Parent = SettingsFrame

local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Name = "FlySpeedLabel"
FlySpeedLabel.Size = UDim2.new(0.6, 0, 1, 0)
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.Text = "Fly Speed:"
FlySpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FlySpeedLabel.TextSize = 16
FlySpeedLabel.Font = Enum.Font.Gotham
FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
FlySpeedLabel.Parent = FlySpeedFrame

local FlySpeedValue = Instance.new("TextBox")
FlySpeedValue.Name = "FlySpeedValue"
FlySpeedValue.Size = UDim2.new(0.3, 0, 0.6, 0)
FlySpeedValue.Position = UDim2.new(0.6, 0, 0.2, 0)
FlySpeedValue.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
FlySpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedValue.Text = "237"
FlySpeedValue.TextSize = 14
FlySpeedValue.Font = Enum.Font.Gotham
FlySpeedValue.Parent = FlySpeedFrame

local FlySpeedCorner = Instance.new("UICorner")
FlySpeedCorner.CornerRadius = UDim.new(0, 4)
FlySpeedCorner.Parent = FlySpeedValue

-- Toggles
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Name = "ToggleFrame"
ToggleFrame.Size = UDim2.new(1, 0, 0, 80)
ToggleFrame.Position = UDim2.new(0, 0, 0, 100)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = SettingsFrame

-- Fly Hack Toggle
local FlyToggle = Instance.new("TextButton")
FlyToggle.Name = "FlyToggle"
FlyToggle.Size = UDim2.new(0.4, -5, 0, 30)
FlyToggle.Position = UDim2.new(0, 0, 0, 0)
FlyToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
FlyToggle.Text = "Fly Hack: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
FlyToggle.TextSize = 14
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.Parent = ToggleFrame

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 6)
FlyToggleCorner.Parent = FlyToggle

-- No Clip Toggle
local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Name = "NoClipToggle"
NoClipToggle.Size = UDim2.new(0.4, -5, 0, 30)
NoClipToggle.Position = UDim2.new(0.6, 0, 0, 0)
NoClipToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
NoClipToggle.Text = "No Clip: OFF"
NoClipToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
NoClipToggle.TextSize = 14
NoClipToggle.Font = Enum.Font.GothamBold
NoClipToggle.Parent = ToggleFrame

local NoClipToggleCorner = Instance.new("UICorner")
NoClipToggleCorner.CornerRadius = UDim.new(0, 6)
NoClipToggleCorner.Parent = NoClipToggle

-- Controls Info
local ControlsFrame = Instance.new("Frame")
ControlsFrame.Name = "ControlsFrame"
ControlsFrame.Size = UDim2.new(1, 0, 0, 80)
ControlsFrame.Position = UDim2.new(0, 0, 0, 180)
ControlsFrame.BackgroundTransparency = 1
ControlsFrame.Parent = SettingsFrame

local ControlsLabel = Instance.new("TextLabel")
ControlsLabel.Name = "ControlsLabel"
ControlsLabel.Size = UDim2.new(1, 0, 0, 20)
ControlsLabel.BackgroundTransparency = 1
ControlsLabel.Text = "Controls:"
ControlsLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
ControlsLabel.TextSize = 14
ControlsLabel.Font = Enum.Font.GothamBold
ControlsLabel.TextXAlignment = Enum.TextXAlignment.Left
ControlsLabel.Parent = ControlsFrame

local ControlsText = Instance.new("TextLabel")
ControlsText.Name = "ControlsText"
ControlsText.Size = UDim2.new(1, 0, 0, 60)
ControlsText.Position = UDim2.new(0, 0, 0, 20)
ControlsText.BackgroundTransparency = 1
ControlsText.Text = "WASD - Movement\nSpace - Up / Shift - Down\nRightControl - Toggle Menu"
ControlsText.TextColor3 = Color3.fromRGB(200, 200, 220)
ControlsText.TextSize = 13
ControlsText.Font = Enum.Font.Gotham
ControlsText.TextXAlignment = Enum.TextXAlignment.Left
ControlsText.TextYAlignment = Enum.TextYAlignment.Top
ControlsText.Parent = ControlsFrame

-- Переменные
local flyEnabled = false
local noClipEnabled = false
local menuVisible = true
local walkSpeed = 139
local flySpeed = 237

-- Функции
local function updateColors()
    local rgbColor = hsvToRgb(hue, 0.8, 1)
    local darkerRgb = hsvToRgb(hue, 0.6, 0.8)
    
    -- Обновление цвета заголовка и границ
    Title.TextColor3 = rgbColor
    MainFrame.BorderColor3 = darkerRgb
    UIStroke.Color = darkerRgb
    
    -- Обновление цвета версии
    Version.TextColor3 = hsvToRgb((hue + 180) % 360, 0.7, 0.9)
    
    -- Обновление цвета включенных тогглов
    if flyEnabled then
        FlyToggle.BackgroundColor3 = hsvToRgb(hue, 0.4, 0.3)
        FlyToggle.TextColor3 = hsvToRgb(hue, 0.8, 1)
    end
    
    if noClipEnabled then
        NoClipToggle.BackgroundColor3 = hsvToRgb((hue + 120) % 360, 0.4, 0.3)
        NoClipToggle.TextColor3 = hsvToRgb((hue + 120) % 360, 0.8, 1)
    end
end

-- Обработчики значений
WalkSpeedValue.FocusLost:Connect(function()
    local value = tonumber(WalkSpeedValue.Text)
    if value and value >= 1 and value <= 500 then
        walkSpeed = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    else
        WalkSpeedValue.Text = tostring(walkSpeed)
    end
end)

FlySpeedValue.FocusLost:Connect(function()
    local value = tonumber(FlySpeedValue.Text)
    if value and value >= 1 and value <= 500 then
        flySpeed = value
    else
        FlySpeedValue.Text = tostring(flySpeed)
    end
end)

-- Тогглы
FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly Hack: " .. (flyEnabled and "ON" or "OFF")
    
    if flyEnabled then
        -- Активация полета
        FlyToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        -- Деактивация полета
        FlyToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

NoClipToggle.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipToggle.Text = "No Clip: " .. (noClipEnabled and "ON" or "OFF")
    
    if noClipEnabled then
        NoClipToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        NoClipToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Управление меню
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightControl then
            menuVisible = not menuVisible
            MainFrame.Visible = menuVisible
        end
    end
end)

-- Основной цикл для RGB
RunService.RenderStepped:Connect(function(deltaTime)
    updateHue()
    updateColors()
    
    -- Применение настроек скорости
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if not flyEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
        end
    end
    
    -- No Clip логика
    if noClipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Инструкция в консоль
print("=== ShFh v2.1 RGB Loaded ===")
print("Controls:")
print("WASD - Movement")
print("Space - Up")
print("Shift - Down")
print("RightControl - Toggle Menu")
print("============================")
