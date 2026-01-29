-- ShFh by @dezzyxx
-- For flam0us chat

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local isMobile = UserInputService.TouchEnabled

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
MainFrame.Draggable = not isMobile
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

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
WalkSpeedValue.Text = "16"
WalkSpeedValue.TextSize = 14
WalkSpeedValue.Font = Enum.Font.Gotham
WalkSpeedValue.ClearTextOnFocus = false
WalkSpeedValue.Parent = WalkSpeedFrame

local WalkSpeedCorner = Instance.new("UICorner")
WalkSpeedCorner.CornerRadius = UDim.new(0, 4)
WalkSpeedCorner.Parent = WalkSpeedValue

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
FlySpeedValue.Text = "50"
FlySpeedValue.TextSize = 14
FlySpeedValue.Font = Enum.Font.Gotham
FlySpeedValue.ClearTextOnFocus = false
FlySpeedValue.Parent = FlySpeedFrame

local FlySpeedCorner = Instance.new("UICorner")
FlySpeedCorner.CornerRadius = UDim.new(0, 4)
FlySpeedCorner.Parent = FlySpeedValue

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
ControlsText.TextColor3 = Color3.fromRGB(200, 200, 220)
ControlsText.TextSize = 12
ControlsText.Font = Enum.Font.Gotham
ControlsText.TextXAlignment = Enum.TextXAlignment.Left
ControlsText.TextYAlignment = Enum.TextYAlignment.Top
ControlsText.Parent = MainFrame

if isMobile then
    ControlsText.Text = "PC: WASD, Space/Shift\nMobile: Tap joystick buttons\nMenu: RightControl/Button"
else
    ControlsText.Text = "WASD - Movement\nSpace - Up / Shift - Down\nRightControl - Menu"
end

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
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 14
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

local MobileControls
local MobileMenuButton

if isMobile then
    MobileControls = Instance.new("Frame")
    MobileControls.Name = "MobileControls"
    MobileControls.Size = UDim2.new(0, 200, 0, 200)
    MobileControls.Position = UDim2.new(0, 10, 1, -210)
    MobileControls.BackgroundTransparency = 1
    MobileControls.Visible = false
    MobileControls.Parent = ScreenGui
    
    local UpButton = Instance.new("TextButton")
    UpButton.Name = "UpButton"
    UpButton.Size = UDim2.new(0, 60, 0, 60)
    UpButton.Position = UDim2.new(0.5, -30, 0, 10)
    UpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    UpButton.Text = "↑"
    UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    UpButton.TextSize = 24
    UpButton.Font = Enum.Font.GothamBold
    UpButton.Parent = MobileControls
    
    local UpCorner = Instance.new("UICorner")
    UpCorner.CornerRadius = UDim.new(0, 30)
    UpCorner.Parent = UpButton
    
    local DownButton = Instance.new("TextButton")
    DownButton.Name = "DownButton"
    DownButton.Size = UDim2.new(0, 60, 0, 60)
    DownButton.Position = UDim2.new(0.5, -30, 1, -70)
    DownButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    DownButton.Text = "↓"
    DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DownButton.TextSize = 24
    DownButton.Font = Enum.Font.GothamBold
    DownButton.Parent = MobileControls
    
    local DownCorner = Instance.new("UICorner")
    DownCorner.CornerRadius = UDim.new(0, 30)
    DownCorner.Parent = DownButton
    
    local LeftButton = Instance.new("TextButton")
    LeftButton.Name = "LeftButton"
    LeftButton.Size = UDim2.new(0, 60, 0, 60)
    LeftButton.Position = UDim2.new(0, 20, 0.5, -30)
    LeftButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    LeftButton.Text = "←"
    LeftButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LeftButton.TextSize = 24
    LeftButton.Font = Enum.Font.GothamBold
    LeftButton.Parent = MobileControls
    
    local LeftCorner = Instance.new("UICorner")
    LeftCorner.CornerRadius = UDim.new(0, 30)
    LeftCorner.Parent = LeftButton
    
    local RightButton = Instance.new("TextButton")
    RightButton.Name = "RightButton"
    RightButton.Size = UDim2.new(0, 60, 0, 60)
    RightButton.Position = UDim2.new(1, -80, 0.5, -30)
    RightButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    RightButton.Text = "→"
    RightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    RightButton.TextSize = 24
    RightButton.Font = Enum.Font.GothamBold
    RightButton.Parent = MobileControls
    
    local RightCorner = Instance.new("UICorner")
    RightCorner.CornerRadius = UDim.new(0, 30)
    RightCorner.Parent = RightButton
    
    MobileMenuButton = Instance.new("TextButton")
    MobileMenuButton.Name = "MobileMenuButton"
    MobileMenuButton.Size = UDim2.new(0, 60, 0, 60)
    MobileMenuButton.Position = UDim2.new(1, -70, 1, -70)
    MobileMenuButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    MobileMenuButton.Text = "MENU"
    MobileMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobileMenuButton.TextSize = 12
    MobileMenuButton.Font = Enum.Font.GothamBold
    MobileMenuButton.Parent = ScreenGui
    
    local MenuButtonCorner = Instance.new("UICorner")
    MenuButtonCorner.CornerRadius = UDim.new(0, 30)
    MenuButtonCorner.Parent = MobileMenuButton
end

local flyEnabled = false
local noClipEnabled = false
local walkSpeed = 16
local flySpeed = 50
local flyConnection

local flyForward = false
local flyBackward = false
local flyLeft = false
local flyRight = false
local flyUp = false
local flyDown = false

local function showNotification(message, duration)
    NotificationText.Text = message
    Notification.Visible = true
    task.wait(duration or 3)
    Notification.Visible = false
end

if isMobile then
    showNotification("ShFh Loaded! Tap MENU button", 4)
else
    showNotification("ShFh Loaded! Press RightControl", 4)
end

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

local function flyFunction()
    if not flyEnabled or not LocalPlayer.Character then return end
    
    local character = LocalPlayer.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    
    local direction = Vector3.new(0, 0, 0)
    
    if flyForward then direction = direction + (rootPart.CFrame.LookVector * 2) end
    if flyBackward then direction = direction - (rootPart.CFrame.LookVector * 2) end
    if flyRight then direction = direction + (rootPart.CFrame.RightVector * 2) end
    if flyLeft then direction = direction - (rootPart.CFrame.RightVector * 2) end
    if flyUp then direction = direction + Vector3.new(0, 2, 0) end
    if flyDown then direction = direction + Vector3.new(0, -2, 0) end
    
    if direction.Magnitude > 0 then
        direction = direction.Unit
        local velocity = direction * flySpeed
        rootPart.Velocity = Vector3.new(velocity.X, velocity.Y, velocity.Z)
    else
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

local function toggleFly()
    if flyEnabled then
        FlyToggle.Text = "Fly Hack: ON"
        FlyToggle.TextColor3 = Color3.fromRGB(80, 255, 80)
        showNotification("Fly Hack: ON", 2)
        
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = true
            end
            
            if flyConnection then
                flyConnection:Disconnect()
            end
            flyConnection = RunService.Heartbeat:Connect(flyFunction)
            
            if isMobile and MobileControls then
                MobileControls.Visible = true
            end
        end
    else
        FlyToggle.Text = "Fly Hack: OFF"
        FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
        showNotification("Fly Hack: OFF", 2)
        
        flyForward = false
        flyBackward = false
        flyLeft = false
        flyRight = false
        flyUp = false
        flyDown = false
        
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid then
                humanoid.PlatformStand = false
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            end
            
            if rootPart then
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if isMobile and MobileControls then
            MobileControls.Visible = false
        end
    end
end

FlyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    toggleFly()
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

if isMobile then
    MobileMenuButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    local UpButton = MobileControls:FindFirstChild("UpButton")
    local DownButton = MobileControls:FindFirstChild("DownButton")
    local LeftButton = MobileControls:FindFirstChild("LeftButton")
    local RightButton = MobileControls:FindFirstChild("RightButton")
    
    UpButton.MouseButton1Down:Connect(function()
        if flyEnabled then flyUp = true end
    end)
    
    UpButton.MouseButton1Up:Connect(function()
        if flyEnabled then flyUp = false end
    end)
    
    DownButton.MouseButton1Down:Connect(function()
        if flyEnabled then flyDown = true end
    end)
    
    DownButton.MouseButton1Up:Connect(function()
        if flyEnabled then flyDown = false end
    end)
    
    LeftButton.MouseButton1Down:Connect(function()
        if flyEnabled then flyLeft = true end
    end)
    
    LeftButton.MouseButton1Up:Connect(function()
        if flyEnabled then flyLeft = false end
    end)
    
    RightButton.MouseButton1Down:Connect(function()
        if flyEnabled then flyRight = true end
    end)
    
    RightButton.MouseButton1Up:Connect(function()
        if flyEnabled then flyRight = false end
    end)
    
    UpButton.TouchLongPress:Connect(function()
        if flyEnabled then flyForward = true end
    end)
    
    UpButton.TouchEnded:Connect(function()
        if flyEnabled then flyForward = false end
    end)
    
    DownButton.TouchLongPress:Connect(function()
        if flyEnabled then flyBackward = true end
    end)
    
    DownButton.TouchEnded:Connect(function()
        if flyEnabled then flyBackward = false end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        local key = input.KeyCode
        
        if not isMobile and flyEnabled then
            if key == Enum.KeyCode.W then
                flyForward = true
            elseif key == Enum.KeyCode.S then
                flyBackward = true
            elseif key == Enum.KeyCode.A then
                flyLeft = true
            elseif key == Enum.KeyCode.D then
                flyRight = true
            elseif key == Enum.KeyCode.Space then
                flyUp = true
            elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then
                flyDown = true
            end
        end
        
        if not isMobile and key == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and not isMobile and flyEnabled then
        local key = input.KeyCode
        
        if key == Enum.KeyCode.W then
            flyForward = false
        elseif key == Enum.KeyCode.S then
            flyBackward = false
        elseif key == Enum.KeyCode.A then
            flyLeft = false
        elseif key == Enum.KeyCode.D then
            flyRight = false
        elseif key == Enum.KeyCode.Space then
            flyUp = false
        elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then
            flyDown = false
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if not flyEnabled then
            humanoid.WalkSpeed = walkSpeed
            humanoid.PlatformStand = false
        end
    end
    
    if LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noClipEnabled
            end
        end
    end
end)

task.spawn(function()
    task.wait(1)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    if flyEnabled then
        task.wait(0.5)
        toggleFly()
    end
end)

game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    flyEnabled = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
end)
