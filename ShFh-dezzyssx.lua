local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShFhGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local passwordKey = "ShFh2026"
local authData = {
    authenticated = false,
    expiry = 0
}

local function saveAuth()
    pcall(function()
        writefile("shfh_auth.txt", tostring(authData.expiry))
    end)
end

local function loadAuth()
    pcall(function()
        if isfile("shfh_auth.txt") then
            local expiry = tonumber(readfile("shfh_auth.txt"))
            if expiry and os.time() < expiry then
                authData.authenticated = true
                authData.expiry = expiry
                return true
            end
        end
    end)
    return false
end

local flyEnabled = false
local noClipEnabled = false
local walkSpeed = 16
local flySpeed = 50

-- Переменные для полета
local flyConnection
local flyKeys = {
    W = false,
    A = false,
    S = false,
    D = false,
    Space = false,
    Shift = false
}

-- Полет куда смотришь + отдельные клавиши вверх/вниз
local function flyFunction()
    if not flyEnabled or not LocalPlayer.Character then return end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    humanoid.PlatformStand = true
    
    -- Получаем направление камеры
    local camera = workspace.CurrentCamera
    local cameraCFrame = camera.CFrame
    
    -- Векторы направления камеры (полные 3D)
    local lookVector = cameraCFrame.LookVector
    local rightVector = cameraCFrame.RightVector
    local upVector = cameraCFrame.UpVector
    
    local direction = Vector3.new(0, 0, 0)
    
    -- Движение куда смотришь (W/S)
    if flyKeys.W then direction = direction + lookVector end
    if flyKeys.S then direction = direction - lookVector end
    
    -- Боковое движение (A/D) без вертикальной составляющей
    local horizontalRight = Vector3.new(rightVector.X, 0, rightVector.Z).Unit
    if flyKeys.D then direction = direction + horizontalRight end
    if flyKeys.A then direction = direction - horizontalRight end
    
    -- Дополнительное вертикальное движение (Space/Shift)
    if flyKeys.Space then direction = direction + Vector3.new(0, 1, 0) end
    if flyKeys.Shift then direction = direction + Vector3.new(0, -1, 0) end
    
    -- Полностью отключаем гравитацию и вращение
    rootPart.Velocity = Vector3.new(0, 0, 0)
    rootPart.RotVelocity = Vector3.new(0, 0, 0)
    
    -- Применяем скорость движения
    if direction.Magnitude > 0 then
        direction = direction.Unit
        rootPart.Velocity = direction * flySpeed
    end
    
    -- Фиксируем поворот персонажа (предотвращаем сальто)
    -- Сохраняем только горизонтальный поворот (Y-вращение)
    local currentCFrame = rootPart.CFrame
    local _, y, _ = currentCFrame:ToEulerAnglesYXZ()
    rootPart.CFrame = CFrame.new(currentCFrame.Position) * CFrame.Angles(0, y, 0)
end

local function startFly()
    if not LocalPlayer.Character then return end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        humanoid.PlatformStand = true
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        
        -- Полностью останавливаем любую физику
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
        -- Фиксируем начальную ориентацию
        local currentCFrame = rootPart.CFrame
        local _, y, _ = currentCFrame:ToEulerAnglesYXZ()
        rootPart.CFrame = CFrame.new(currentCFrame.Position) * CFrame.Angles(0, y, 0)
    end
    
    if flyConnection then
        flyConnection:Disconnect()
    end
    flyConnection = RunService.Heartbeat:Connect(flyFunction)
end

local function stopFly()
    if not LocalPlayer.Character then return end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.WalkSpeed = walkSpeed
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end
    
    if rootPart then
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
    
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    -- Сбрасываем клавиши
    flyKeys = {
        W = false,
        A = false,
        S = false,
        D = false,
        Space = false,
        Shift = false
    }
    
    -- Принудительно восстанавливаем управление
    task.wait(0.1)
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end

local MainFrame
local MenuToggleButton

local function loadMainUI()
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 320, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = not isMobile
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ShFh by @dezzyssx"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0.05, 0, 0, 0)
    Title.Parent = TitleBar
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(0.3, 0, 1, 0)
    SubTitle.Position = UDim2.new(0.7, 0, 0, 0)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "flam0us"
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
    SubTitle.TextSize = 12
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.TextXAlignment = Enum.TextXAlignment.Right
    SubTitle.Parent = TitleBar
    
    local PlayerInfo = Instance.new("Frame")
    PlayerInfo.Size = UDim2.new(1, -20, 0, 80)
    PlayerInfo.Position = UDim2.new(0, 10, 0, 50)
    PlayerInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    PlayerInfo.Parent = MainFrame
    
    local PlayerCorner = Instance.new("UICorner")
    PlayerCorner.CornerRadius = UDim.new(0, 8)
    PlayerCorner.Parent = PlayerInfo
    
    local Avatar = Instance.new("ImageLabel")
    Avatar.Size = UDim2.new(0, 50, 0, 50)
    Avatar.Position = UDim2.new(0, 10, 0.5, -25)
    Avatar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Avatar.BorderSizePixel = 0
    Avatar.Parent = PlayerInfo
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(0, 25)
    AvatarCorner.Parent = Avatar
    
    local PlayerName = Instance.new("TextLabel")
    PlayerName.Size = UDim2.new(0, 200, 0, 25)
    PlayerName.Position = UDim2.new(0, 70, 0.3, 0)
    PlayerName.BackgroundTransparency = 1
    PlayerName.Text = LocalPlayer.Name
    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerName.TextSize = 14
    PlayerName.Font = Enum.Font.GothamBold
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerName.Parent = PlayerInfo
    
    local UserId = Instance.new("TextLabel")
    UserId.Size = UDim2.new(0, 200, 0, 20)
    UserId.Position = UDim2.new(0, 70, 0.6, 0)
    UserId.BackgroundTransparency = 1
    UserId.Text = "ID: " .. LocalPlayer.UserId
    UserId.TextColor3 = Color3.fromRGB(200, 200, 200)
    UserId.TextSize = 12
    UserId.Font = Enum.Font.Gotham
    UserId.TextXAlignment = Enum.TextXAlignment.Left
    UserId.Parent = PlayerInfo
    
    pcall(function()
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size100x100
        local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)
        Avatar.Image = content
    end)
    
    local AuthTimer = Instance.new("TextLabel")
    AuthTimer.Size = UDim2.new(1, -20, 0, 20)
    AuthTimer.Position = UDim2.new(0, 10, 0, 140)
    AuthTimer.BackgroundTransparency = 1
    AuthTimer.TextColor3 = Color3.fromRGB(100, 255, 100)
    AuthTimer.TextSize = 12
    AuthTimer.Font = Enum.Font.Gotham
    AuthTimer.TextXAlignment = Enum.TextXAlignment.Center
    AuthTimer.Parent = MainFrame
    
    local function updateTimer()
        if authData.expiry > 0 then
            local remaining = authData.expiry - os.time()
            if remaining > 0 then
                local hours = math.floor(remaining / 3600)
                local minutes = math.floor((remaining % 3600) / 60)
                AuthTimer.Text = string.format("Access: %02dh %02dm", hours, minutes)
            else
                AuthTimer.Text = "Access expired - restart script"
            end
        else
            AuthTimer.Text = "Access: Unlimited"
        end
    end
    
    spawn(function()
        while true do
            updateTimer()
            wait(60)
        end
    end)
    
    local ControlsFrame = Instance.new("Frame")
    ControlsFrame.Size = UDim2.new(1, -20, 0, 180)
    ControlsFrame.Position = UDim2.new(0, 10, 0, 170)
    ControlsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ControlsFrame.Parent = MainFrame
    
    local ControlsCorner = Instance.new("UICorner")
    ControlsCorner.CornerRadius = UDim.new(0, 8)
    ControlsCorner.Parent = ControlsFrame
    
    local WalkSpeedLabel = Instance.new("TextLabel")
    WalkSpeedLabel.Size = UDim2.new(0.5, -5, 0, 30)
    WalkSpeedLabel.Position = UDim2.new(0, 10, 0, 10)
    WalkSpeedLabel.BackgroundTransparency = 1
    WalkSpeedLabel.Text = "Walk Speed:"
    WalkSpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    WalkSpeedLabel.TextSize = 14
    WalkSpeedLabel.Font = Enum.Font.Gotham
    WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    WalkSpeedLabel.Parent = ControlsFrame
    
    local WalkSpeedBox = Instance.new("TextBox")
    WalkSpeedBox.Size = UDim2.new(0.4, -5, 0, 30)
    WalkSpeedBox.Position = UDim2.new(0.6, 0, 0, 10)
    WalkSpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    WalkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    WalkSpeedBox.Text = tostring(walkSpeed)
    WalkSpeedBox.TextSize = 14
    WalkSpeedBox.Font = Enum.Font.Gotham
    WalkSpeedBox.Parent = ControlsFrame
    
    local WalkSpeedCorner = Instance.new("UICorner")
    WalkSpeedCorner.CornerRadius = UDim.new(0, 6)
    WalkSpeedCorner.Parent = WalkSpeedBox
    
    local FlySpeedLabel = Instance.new("TextLabel")
    FlySpeedLabel.Size = UDim2.new(0.5, -5, 0, 30)
    FlySpeedLabel.Position = UDim2.new(0, 10, 0, 50)
    FlySpeedLabel.BackgroundTransparency = 1
    FlySpeedLabel.Text = "Fly Speed:"
    FlySpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    FlySpeedLabel.TextSize = 14
    FlySpeedLabel.Font = Enum.Font.Gotham
    FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    FlySpeedLabel.Parent = ControlsFrame
    
    local FlySpeedBox = Instance.new("TextBox")
    FlySpeedBox.Size = UDim2.new(0.4, -5, 0, 30)
    FlySpeedBox.Position = UDim2.new(0.6, 0, 0, 50)
    FlySpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    FlySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlySpeedBox.Text = tostring(flySpeed)
    FlySpeedBox.TextSize = 14
    FlySpeedBox.Font = Enum.Font.Gotham
    FlySpeedBox.Parent = ControlsFrame
    
    local FlySpeedCorner = Instance.new("UICorner")
    FlySpeedCorner.CornerRadius = UDim.new(0, 6)
    FlySpeedCorner.Parent = FlySpeedBox
    
    local FlyToggle = Instance.new("TextButton")
    FlyToggle.Size = UDim2.new(0.45, -5, 0, 35)
    FlyToggle.Position = UDim2.new(0, 10, 0, 90)
    FlyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    FlyToggle.Text = "Fly Hack: OFF"
    FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
    FlyToggle.TextSize = 13
    FlyToggle.Font = Enum.Font.GothamBold
    FlyToggle.Parent = ControlsFrame
    
    local FlyToggleCorner = Instance.new("UICorner")
    FlyToggleCorner.CornerRadius = UDim.new(0, 6)
    FlyToggleCorner.Parent = FlyToggle
    
    local NoClipToggle = Instance.new("TextButton")
    NoClipToggle.Size = UDim2.new(0.45, -5, 0, 35)
    NoClipToggle.Position = UDim2.new(0.55, 0, 0, 90)
    NoClipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    NoClipToggle.Text = "No Clip: OFF"
    NoClipToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
    NoClipToggle.TextSize = 13
    NoClipToggle.Font = Enum.Font.GothamBold
    NoClipToggle.Parent = ControlsFrame
    
    local NoClipCorner = Instance.new("UICorner")
    NoClipCorner.CornerRadius = UDim.new(0, 6)
    NoClipCorner.Parent = NoClipToggle
    
    local ControlsText = Instance.new("TextLabel")
    ControlsText.Size = UDim2.new(1, -20, 0, 40)
    ControlsText.Position = UDim2.new(0, 10, 0, 135)
    ControlsText.BackgroundTransparency = 1
    ControlsText.TextColor3 = Color3.fromRGB(180, 180, 220)
    ControlsText.TextSize = 11
    ControlsText.Font = Enum.Font.Gotham
    ControlsText.TextXAlignment = Enum.TextXAlignment.Left
    ControlsText.TextYAlignment = Enum.TextYAlignment.Top
    ControlsText.Parent = ControlsFrame
    
    if isMobile then
        ControlsText.Text = "Fly: Look direction + WASD\nSpace/Up - Extra up\nShift/Down - Extra down\nTap Menu button for menu"
    else
        ControlsText.Text = "Fly: Where you look, you fly\nW/S - Forward/Backward\nA/D - Left/Right (horizontal)\nSpace - Extra up / Shift - Extra down\nRightControl - Toggle Menu"
    end
    
    WalkSpeedBox.FocusLost:Connect(function()
        local num = tonumber(WalkSpeedBox.Text)
        if num and num >= 1 and num <= 500 then
            walkSpeed = num
            WalkSpeedBox.Text = tostring(walkSpeed)
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and not flyEnabled then
                    humanoid.WalkSpeed = walkSpeed
                end
            end
        else
            WalkSpeedBox.Text = tostring(walkSpeed)
        end
    end)
    
    FlySpeedBox.FocusLost:Connect(function()
        local num = tonumber(FlySpeedBox.Text)
        if num and num >= 1 and num <= 500 then
            flySpeed = num
            FlySpeedBox.Text = tostring(flySpeed)
        else
            FlySpeedBox.Text = tostring(flySpeed)
        end
    end)
    
    FlyToggle.MouseButton1Click:Connect(function()
        flyEnabled = not flyEnabled
        if flyEnabled then
            FlyToggle.Text = "Fly Hack: ON"
            FlyToggle.TextColor3 = Color3.fromRGB(80, 255, 80)
            FlyToggle.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
            startFly()
        else
            FlyToggle.Text = "Fly Hack: OFF"
            FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
            FlyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            stopFly()
        end
    end)
    
    NoClipToggle.MouseButton1Click:Connect(function()
        noClipEnabled = not noClipEnabled
        if noClipEnabled then
            NoClipToggle.Text = "No Clip: ON"
            NoClipToggle.TextColor3 = Color3.fromRGB(80, 255, 80)
            NoClipToggle.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
        else
            NoClipToggle.Text = "No Clip: OFF"
            NoClipToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
            NoClipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        end
    end)
    
    -- Создаем кнопку меню для телефона
    if isMobile then
        MenuToggleButton = Instance.new("TextButton")
        MenuToggleButton.Name = "MenuToggleButton"
        MenuToggleButton.Size = UDim2.new(0, 60, 0, 60)
        MenuToggleButton.Position = UDim2.new(1, -70, 1, -70)
        MenuToggleButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        MenuToggleButton.Text = "MENU"
        MenuToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MenuToggleButton.TextSize = 14
        MenuToggleButton.Font = Enum.Font.GothamBold
        MenuToggleButton.Parent = ScreenGui
        
        local MenuButtonCorner = Instance.new("UICorner")
        MenuButtonCorner.CornerRadius = UDim.new(0, 30)
        MenuButtonCorner.Parent = MenuToggleButton
        
        MenuToggleButton.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
    end
    
    -- Мобильный джойстик для полета
    if isMobile then
        local MobileControls = Instance.new("Frame")
        MobileControls.Name = "MobileControls"
        MobileControls.Size = UDim2.new(0, 150, 0, 150)
        MobileControls.Position = UDim2.new(0, 20, 1, -170)
        MobileControls.BackgroundTransparency = 1
        MobileControls.Parent = ScreenGui
        
        local JoystickOuter = Instance.new("Frame")
        JoystickOuter.Size = UDim2.new(1, 0, 1, 0)
        JoystickOuter.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        JoystickOuter.BackgroundTransparency = 0.5
        JoystickOuter.Parent = MobileControls
        
        local JoystickCorner = Instance.new("UICorner")
        JoystickCorner.CornerRadius = UDim.new(1, 0)
        JoystickCorner.Parent = JoystickOuter
        
        local JoystickInner = Instance.new("Frame")
        JoystickInner.Size = UDim2.new(0.4, 0, 0.4, 0)
        JoystickInner.Position = UDim2.new(0.3, 0, 0.3, 0)
        JoystickInner.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        JoystickInner.Parent = MobileControls
        
        local InnerCorner = Instance.new("UICorner")
        InnerCorner.CornerRadius = UDim.new(1, 0)
        InnerCorner.Parent = JoystickInner
        
        -- Кнопки высоты для мобильных
        local MobileUp = Instance.new("TextButton")
        MobileUp.Size = UDim2.new(0, 60, 0, 60)
        MobileUp.Position = UDim2.new(0.5, -30, 0, 10)
        MobileUp.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        MobileUp.Text = "↑"
        MobileUp.TextColor3 = Color3.fromRGB(255, 255, 255)
        MobileUp.TextSize = 20
        MobileUp.Visible = false
        MobileUp.Parent = ScreenGui
        
        local MobileDown = Instance.new("TextButton")
        MobileDown.Size = UDim2.new(0, 60, 0, 60)
        MobileDown.Position = UDim2.new(0.5, -30, 1, -70)
        MobileDown.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        MobileDown.Text = "↓"
        MobileDown.TextColor3 = Color3.fromRGB(255, 255, 255)
        MobileDown.TextSize = 20
        MobileDown.Visible = false
        MobileDown.Parent = ScreenGui
        
        FlyToggle.MouseButton1Click:Connect(function()
            MobileUp.Visible = flyEnabled
            MobileDown.Visible = flyEnabled
            MobileControls.Visible = true
        end)
        
        MobileUp.MouseButton1Down:Connect(function()
            if flyEnabled then flyKeys.Space = true end
        end)
        
        MobileUp.MouseButton1Up:Connect(function()
            if flyEnabled then flyKeys.Space = false end
        end)
        
        MobileDown.MouseButton1Down:Connect(function()
            if flyEnabled then flyKeys.Shift = true end
        end)
        
        MobileDown.MouseButton1Up:Connect(function()
            if flyEnabled then flyKeys.Shift = false end
        end)
        
        -- Обработка джойстика для мобильных
        local touching = false
        local joystickCenter = Vector2.new(75, 75)
        
        JoystickOuter.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                touching = true
            end
        end)
        
        JoystickOuter.InputChanged:Connect(function(input)
            if touching and input.UserInputType == Enum.UserInputType.Touch then
                local touchPosition = input.Position
                local delta = touchPosition - joystickCenter
                
                local maxDistance = 50
                local distance = math.min(delta.Magnitude, maxDistance)
                local direction = delta.Unit
                
                local newPosition = direction * distance
                JoystickInner.Position = UDim2.new(0.3 + newPosition.X/100, 0, 0.3 + newPosition.Y/100, 0)
                
                local x = newPosition.X / maxDistance
                local y = -newPosition.Y / maxDistance
                
                if flyEnabled then
                    flyKeys.W = y > 0.3
                    flyKeys.S = y < -0.3
                    flyKeys.A = x < -0.3
                    flyKeys.D = x > 0.3
                end
            end
        end)
        
        JoystickOuter.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                touching = false
                JoystickInner.Position = UDim2.new(0.3, 0, 0.3, 0)
                if flyEnabled then
                    flyKeys.W = false
                    flyKeys.S = false
                    flyKeys.A = false
                    flyKeys.D = false
                end
            end
        end)
    end
    
    -- Управление для ПК
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            local key = input.KeyCode
            
            if not isMobile and key == Enum.KeyCode.RightControl then
                MainFrame.Visible = not MainFrame.Visible
            end
            
            if flyEnabled then
                if key == Enum.KeyCode.W then flyKeys.W = true
                elseif key == Enum.KeyCode.A then flyKeys.A = true
                elseif key == Enum.KeyCode.S then flyKeys.S = true
                elseif key == Enum.KeyCode.D then flyKeys.D = true
                elseif key == Enum.KeyCode.Space then flyKeys.Space = true
                elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then flyKeys.Shift = true
                end
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if not gameProcessed and flyEnabled then
            local key = input.KeyCode
            
            if key == Enum.KeyCode.W then flyKeys.W = false
            elseif key == Enum.KeyCode.A then flyKeys.A = false
            elseif key == Enum.KeyCode.S then flyKeys.S = false
            elseif key == Enum.KeyCode.D then flyKeys.D = false
            elseif key == Enum.KeyCode.Space then flyKeys.Space = false
            elseif key == Enum.KeyCode.LeftShift or key == Enum.KeyCode.RightShift then flyKeys.Shift = false
            end
        end
    end)
    
    -- Основной цикл для NoClip и скорости ходьбы
    RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character then
            -- Применяем скорость ходьбы
            if not flyEnabled then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = walkSpeed
                end
            end
            
            -- NoClip
            if noClipEnabled then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
    
    -- Установка начальной скорости
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
        end
    end
end

-- Проверяем авторизацию при запуске
if loadAuth() then
    loadMainUI()
else
    -- Показываем окно ввода пароля
    local PasswordUI = Instance.new("Frame")
    PasswordUI.Name = "PasswordUI"
    PasswordUI.Size = UDim2.new(0, 300, 0, 180)
    PasswordUI.Position = UDim2.new(0.5, -150, 0.5, -90)
    PasswordUI.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    PasswordUI.BorderSizePixel = 0
    PasswordUI.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = PasswordUI
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Title.Text = "ShFh Access"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = PasswordUI
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = Title
    
    local PasswordBox = Instance.new("TextBox")
    PasswordBox.Size = UDim2.new(0.8, 0, 0, 40)
    PasswordBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    PasswordBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    PasswordBox.PlaceholderText = "Enter password"
    PasswordBox.Text = ""
    PasswordBox.TextSize = 14
    PasswordBox.Font = Enum.Font.Gotham
    PasswordBox.Parent = PasswordUI
    
    local PassCorner = Instance.new("UICorner")
    PassCorner.CornerRadius = UDim.new(0, 6)
    PassCorner.Parent = PasswordBox
    
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.6, 0, 0, 35)
    SubmitBtn.Position = UDim2.new(0.2, 0, 0.7, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Text = "UNLOCK"
    SubmitBtn.TextSize = 14
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.Parent = PasswordUI
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 6)
    SubmitCorner.Parent = SubmitBtn
    
    SubmitBtn.MouseButton1Click:Connect(function()
        if PasswordBox.Text == passwordKey then
            authData.authenticated = true
            authData.expiry = os.time() + (24 * 60 * 60)
            saveAuth()
            PasswordUI:Destroy()
            loadMainUI()
        else
            PasswordBox.Text = ""
            PasswordBox.PlaceholderText = "Wrong password!"
        end
    end)
end
