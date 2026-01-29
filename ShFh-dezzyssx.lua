local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
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
    local data = {
        authenticated = authData.authenticated,
        expiry = authData.expiry
    }
    pcall(function()
        writefile("shfh_auth.txt", HttpService:JSONEncode(data))
    end)
end

local function loadAuth()
    pcall(function()
        if isfile("shfh_auth.txt") then
            local data = HttpService:JSONDecode(readfile("shfh_auth.txt"))
            if data and data.expiry and os.time() < data.expiry then
                authData = data
                return true
            end
        end
    end)
    return false
end

if loadAuth() then
    print("ShFh: Auto-login successful")
else
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

local function flyUpdate()
    if not flyEnabled or not LocalPlayer.Character then return end
    
    local character = LocalPlayer.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if not rootPart or not humanoid then return end
    
    humanoid.PlatformStand = true
    
    local moveDirection = Vector3.new(0, 0, 0)
    
    if flyForward then
        moveDirection = moveDirection + rootPart.CFrame.LookVector
    end
    if flyBackward then
        moveDirection = moveDirection - rootPart.CFrame.LookVector
    end
    if flyRight then
        moveDirection = moveDirection + rootPart.CFrame.RightVector
    end
    if flyLeft then
        moveDirection = moveDirection - rootPart.CFrame.RightVector
    end
    if flyUp then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if flyDown then
        moveDirection = moveDirection + Vector3.new(0, -1, 0)
    end
    
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit
        rootPart.Velocity = moveDirection * flySpeed
    else
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

function loadMainUI()
    local MainFrame = Instance.new("Frame")
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
        local remaining = authData.expiry - os.time()
        if remaining > 0 then
            local hours = math.floor(remaining / 3600)
            local minutes = math.floor((remaining % 3600) / 60)
            AuthTimer.Text = string.format("Access: %02dh %02dm", hours, minutes)
        else
            AuthTimer.Text = "Access expired"
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
        ControlsText.Text = "PC: WASD + Space/Shift\nMobile: Use joystick\nMenu: RightControl/Tap"
    else
        ControlsText.Text = "WASD - Movement\nSpace - Up / Shift - Down\nRightControl - Toggle Menu"
    end
    
    WalkSpeedBox.FocusLost:Connect(function()
        local num = tonumber(WalkSpeedBox.Text)
        if num and num >= 1 and num <= 500 then
            walkSpeed = num
            WalkSpeedBox.Text = tostring(walkSpeed)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and not flyEnabled then
                LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
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
            
            if flyConnection then
                flyConnection:Disconnect()
            end
            flyConnection = RunService.Heartbeat:Connect(flyUpdate)
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.PlatformStand = true
            end
        else
            FlyToggle.Text = "Fly Hack: OFF"
            FlyToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
            FlyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            
            flyForward = false
            flyBackward = false
            flyLeft = false
            flyRight = false
            flyUp = false
            flyDown = false
            
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
            
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoid then
                    humanoid.PlatformStand = false
                    humanoid.WalkSpeed = walkSpeed
                end
                
                if rootPart then
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                end
            end
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
    
    if isMobile then
        local MobileJoystick = Instance.new("Frame")
        MobileJoystick.Name = "MobileJoystick"
        MobileJoystick.Size = UDim2.new(0, 150, 0, 150)
        MobileJoystick.Position = UDim2.new(0, 20, 1, -170)
        MobileJoystick.BackgroundTransparency = 1
        MobileJoystick.Parent = ScreenGui
        
        local JoystickOuter = Instance.new("Frame")
        JoystickOuter.Size = UDim2.new(1, 0, 1, 0)
        JoystickOuter.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        JoystickOuter.BackgroundTransparency = 0.5
        JoystickOuter.Parent = MobileJoystick
        
        local JoystickCorner = Instance.new("UICorner")
        JoystickCorner.CornerRadius = UDim.new(1, 0)
        JoystickCorner.Parent = JoystickOuter
        
        local JoystickInner = Instance.new("Frame")
        JoystickInner.Size = UDim2.new(0.4, 0, 0.4, 0)
        JoystickInner.Position = UDim2.new(0.3, 0, 0.3, 0)
        JoystickInner.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        JoystickInner.Parent = MobileJoystick
        
        local InnerCorner = Instance.new("UICorner")
        InnerCorner.CornerRadius = UDim.new(1, 0)
        InnerCorner.Parent = JoystickInner
        
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
            MobileJoystick.Visible = not flyEnabled
        end)
        
        MobileUp.MouseButton1Down:Connect(function()
            flyUp = true
        end)
        
        MobileUp.MouseButton1Up:Connect(function()
            flyUp = false
        end)
        
        MobileDown.MouseButton1Down:Connect(function()
            flyDown = true
        end)
        
        MobileDown.MouseButton1Up:Connect(function()
            flyDown = false
        end)
        
        local touching = false
        local startPos = Vector2.new(0, 0)
        local joyPos = Vector2.new(0, 0)
        
        JoystickOuter.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                touching = true
                startPos = input.Position
            end
        end)
        
        JoystickOuter.InputChanged:Connect(function(input)
            if touching and input.UserInputType == Enum.UserInputType.Touch then
                local currentPos = input.Position
                local delta = currentPos - startPos
                local maxDist = 50
                
                local distance = math.min(delta.Magnitude, maxDist)
                local direction = delta.Unit
                
                joyPos = direction * distance
                JoystickInner.Position = UDim2.new(0.3 + joyPos.X/100, 0, 0.3 + joyPos.Y/100, 0)
                
                flyForward = joyPos.Y < -10
                flyBackward = joyPos.Y > 10
                flyLeft = joyPos.X < -10
                flyRight = joyPos.X > 10
            end
        end)
        
        JoystickOuter.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                touching = false
                JoystickInner.Position = UDim2.new(0.3, 0, 0.3, 0)
                flyForward = false
                flyBackward = false
                flyLeft = false
                flyRight = false
            end
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
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and not flyEnabled then
                humanoid.WalkSpeed = walkSpeed
            end
            
            if noClipEnabled then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

if authData.authenticated then
    loadMainUI()
end
