-- ShFh by @dezzyxx
-- Created for flam0us chat

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShFhGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 250)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Скрыто по умолчанию
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Title.Text = "ShFh by @dezzyxx"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Made for flam0us chat"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = MainFrame

-- Walk Speed
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Size = UDim2.new(1, -20, 0, 30)
WalkSpeedFrame.Position = UDim2.new(0, 10, 0, 60)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.Parent = MainFrame

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Name = "WalkSpeedLabel"
WalkSpeedLabel.Size = UDim2.new(0.6, 0, 1, 0)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "Walk Speed:"
WalkSpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.Font = Enum.Font.Gotham
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedValue = Instance.new("TextBox")
WalkSpeedValue.Name = "WalkSpeedValue"
WalkSpeedValue.Size = UDim2.new(0.35, 0, 1, 0)
WalkSpeedValue.Position = UDim2.new(0.65, 0, 0, 0)
WalkSpeedValue.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
WalkSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedValue.Text = "500"
WalkSpeedValue.TextSize = 14
WalkSpeedValue.Font = Enum.Font.Gotham
WalkSpeedValue.ClearTextOnFocus = false
WalkSpeedValue.Parent = WalkSpeedFrame

local WalkSpeedCorner = Instance.new("UICorner")
WalkSpeedCorner.CornerRadius = UDim.new(0, 4)
WalkSpeedCorner.Parent = WalkSpeedValue

-- Fly Speed
local FlySpeedFrame = Instance.new("Frame")
FlySpeedFrame.Name = "FlySpeedFrame"
FlySpeedFrame.Size = UDim2.new(1, -20, 0, 30)
FlySpeedFrame.Position = UDim2.new(0, 10, 0, 95)
FlySpeedFrame.BackgroundTransparency = 1
FlySpeedFrame.Parent = MainFrame

local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Name = "FlySpeedLabel"
FlySpeedLabel.Size = UDim2.new(0.6, 0, 1, 0)
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.Text = "Fly Speed:"
FlySpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
FlySpeedLabel.TextSize = 14
FlySpeedLabel.Font = Enum.Font.Gotham
FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
FlySpeedLabel.Parent = FlySpeedFrame

local FlySpeedValue = Instance.new("TextBox")
FlySpeedValue.Name = "FlySpeedValue"
FlySpeedValue.Size = UDim2.new(0.35, 0, 1, 0)
FlySpeedValue.Position = UDim2.new(0.65, 0, 0, 0)
FlySpeedValue.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
FlySpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedValue.Text = "237"
FlySpeedValue.TextSize = 14
FlySpeedValue.Font = Enum.Font.Gotham
FlySpeedValue.ClearTextOnFocus = false
FlySpeedValue.Parent = FlySpeedFrame

local FlySpeedCorner = Instance.new("UICorner")
FlySpeedCorner.CornerRadius = UDim.new(0, 4)
FlySpeedCorner.Parent = FlySpeedValue

-- Fly Hack Toggle
local FlyToggle = Instance.new("TextButton")
FlyToggle.Name = "FlyToggle"
FlyToggle.Size = UDim2.new(1, -20, 0, 30)
FlyToggle.Position = UDim2.new(0, 10, 0, 130)
FlyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
FlyToggle.Text = "Fly Hack: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
FlyToggle.TextSize = 14
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.Parent = MainFrame

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 6)
FlyToggleCorner.Parent = FlyToggle

-- No Clip Toggle
local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Name = "NoClipToggle"
NoClipToggle.Size = UDim2.new(1, -20, 0, 30)
NoClipToggle.Position = UDim2.new(0, 10, 0, 165)
NoClipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
NoClipToggle.Text = "No Clip: OFF"
NoClipToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
NoClipToggle.TextSize = 14
NoClipToggle.Font = Enum.Font.GothamBold
NoClipToggle.Parent = MainFrame

local NoClipToggleCorner = Instance.new("UICorner")
NoClipToggleCorner.CornerRadius = UDim.new(0, 6)
NoClipToggleCorner.Parent = NoClipToggle

-- Controls Info
local ControlsLabel = Instance.new("TextLabel")
ControlsLabel.Name = "ControlsLabel"
ControlsLabel.Size = UDim2.new(1, -20, 0, 20)
ControlsLabel.Position = UDim2.new(0, 10, 0, 200)
ControlsLabel.BackgroundTransparency = 1
ControlsLabel.Text = "Controls:"
ControlsLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
ControlsLabel.TextSize = 14
ControlsLabel.Font = Enum.Font.GothamBold
ControlsLabel.TextXAlignment = Enum.TextXAlignment.Left
ControlsLabel.Parent = MainFrame

local ControlsText = Instance.new("TextLabel")
ControlsText.Name = "ControlsText"
ControlsText.Size = UDim2.new(1, -20, 0, 40)
ControlsText.Position = UDim2.new(0, 10, 0, 215)
ControlsText.BackgroundTransparency = 1
ControlsText.Text = "WASD - Movement\nSpace - Up / Shift - Down"
ControlsText.TextColor3 = Color3.fromRGB(200, 200, 220)
ControlsText.TextSize = 13
ControlsText.Font = Enum.Font.Gotham
ControlsText.TextXAlignment = Enum.TextXAlignment.Left
ControlsText.TextYAlignment = Enum.TextYAlignment.Top
ControlsText.Parent = MainFrame

-- Всплывающее уведомление
local Notification = Instance.new("Frame")
Notification.Name = "Notification"
Notification.Size = UDim2.new(0, 200, 0, 40)
Notification.Position = UDim2.new(0.5, -100, 0, 10)
Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Notification.BackgroundTransparency = 0.2
Notification.BorderSizePixel = 0
Notification.Visible = false
Notification.Parent = ScreenGui

local NotificationCorner = Instance.new("UICorner")
NotificationCorner.CornerRadius = UDim.new(0, 6)
NotificationCorner.Parent = Notification

local NotificationText = Instance.new("TextLabel")
NotificationText.Name = "NotificationText"
NotificationText.Size = UDim2.new(1, 0, 1, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.Text = "ShFh Loaded! Press RightControl"
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 14
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

-- Переменные
local flyEnabled = false
local noClipEnabled = false
local walkSpeed = 500
local flySpeed = 237
local flyBodyVelocity

-- Функция показа уведомления
local function showNotification(message, duration)
    NotificationText.Text = message
    Notification.Visible = true
    
    task.wait(duration or 3)
    
    Notification.Visible = false
end

-- Показ уведомления при загрузке
showNotification("ShFh Loaded! Press RightControl", 4)

-- Обработчики значений
WalkSpeedValue.FocusLost:Connect(function()
    local value = tonumber(WalkSpeedValue.Text)
    if value and value >= 1 and value <= 500 then
        walkSpeed = value
        WalkSpeedValue.Text = tostring(walkSpeed)
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
        FlySpeedValue.Text = tostring(flySpeed)
    else
        FlySpeedValue.Text = tostring(flySpeed)
    end
end)

-- Функция полета
local function setupFly()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        -- Удаляем старый BodyVelocity если есть
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        
        -- Создаем новый BodyVelocity для полета
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.P = 1250
        flyBodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
    elseif not flyEnabled and flyBodyVelocity then
        flyBodyVelocity:Destroy()
        flyBodyVelocity = nil
    end
end

-- Тогглы
FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyToggle.Text = "Fly Hack: " .. (flyEnabled and "ON" or "OFF")
    
    if flyEnabled then
        FlyToggle.TextColor3 = Color3.fromRGB(80, 255, 80)
        showNotification("Fly Hack: ON", 2)
        setupFly()
    else
        FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
        showNotification("Fly Hack: OFF", 2)
        setupFly()
    end
end)

NoClipToggle.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    NoClipToggle.Text = "No Clip: " .. (noClipEnabled and "ON" or "OFF")
    
    if noClipEnabled then
        NoClipToggle.TextColor3 = Color3.fromRGB(80, 255, 80)
        showNotification("No Clip: ON", 2)
    else
        NoClipToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
        showNotification("No Clip: OFF", 2)
    end
end)

-- Управление полетом
local flying = false
local flyDirection = Vector3.new(0, 0, 0)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and flyEnabled and flyBodyVelocity then
        local key = input.KeyCode
        
        if key == Enum.KeyCode.W then
            flyDirection = flyDirection + Vector3.new(0, 0, -1)
            flying = true
        elseif key == Enum.KeyCode.S then
            flyDirection = flyDirection + Vector3.new(0, 0, 1)
            flying = true
        elseif key == Enum.KeyCode.A then
            flyDirection = flyDirection + Vector3.new(-1, 0, 0)
            flying = true
        elseif key == Enum.KeyCode.D then
            flyDirection = flyDirection + Vector3.new(1, 0, 0)
            flying = true
        elseif key == Enum.KeyCode.Space then
            flyDirection = flyDirection + Vector3.new(0, 1, 0)
            flying = true
        elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then
            flyDirection = flyDirection + Vector3.new(0, -1, 0)
            flying = true
        elseif key == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    elseif not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and flyEnabled then
        local key = input.KeyCode
        
        if key == Enum.KeyCode.W then
            flyDirection = flyDirection - Vector3.new(0, 0, -1)
        elseif key == Enum.KeyCode.S then
            flyDirection = flyDirection - Vector3.new(0, 0, 1)
        elseif key == Enum.KeyCode.A then
            flyDirection = flyDirection - Vector3.new(-1, 0, 0)
        elseif key == Enum.KeyCode.D then
            flyDirection = flyDirection - Vector3.new(1, 0, 0)
        elseif key == Enum.KeyCode.Space then
            flyDirection = flyDirection - Vector3.new(0, 1, 0)
        elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then
            flyDirection = flyDirection - Vector3.new(0, -1, 0)
        end
        
        -- Если все клавиши отпущены, останавливаем полет
        if flyDirection.Magnitude == 0 then
            flying = false
        end
    end
end)

-- Основной цикл
RunService.Heartbeat:Connect(function()
    -- Применение WalkSpeed когда не летим
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
    elseif not noClipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
    
    -- Управление полетом
    if flyEnabled and flyBodyVelocity and flying then
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character.HumanoidRootPart
            local lookVector = rootPart.CFrame.LookVector
            local rightVector = rootPart.CFrame.RightVector
            
            local moveDirection = Vector3.new(0, 0, 0)
            
            if flyDirection.Z < 0 then -- W
                moveDirection = moveDirection + lookVector
            elseif flyDirection.Z > 0 then -- S
                moveDirection = moveDirection - lookVector
            end
            
            if flyDirection.X < 0 then -- A
                moveDirection = moveDirection - rightVector
            elseif flyDirection.X > 0 then -- D
                moveDirection = moveDirection + rightVector
            end
            
            if flyDirection.Y < 0 then -- Shift
                moveDirection = moveDirection + Vector3.new(0, -1, 0)
            elseif flyDirection.Y > 0 then -- Space
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
                flyBodyVelocity.Velocity = moveDirection * flySpeed
            else
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

-- Установка начальной скорости
task.spawn(function()
    task.wait(1)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)
