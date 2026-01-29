-- ShFh by @dezzyssx
-- Speed & Fly Hack for Roblox

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Check if mobile
local IS_MOBILE = UserInputService.TouchEnabled
local IS_PC = not IS_MOBILE

-- Character setup
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Settings
local Settings = {
    WalkSpeed = 50,
    FlySpeed = 50,
    WalkSpeedEnabled = false,
    FlyEnabled = false,
    NoClipEnabled = false,
    MenuExpanded = false
}

-- Store original values
local OriginalWalkSpeed = Humanoid.WalkSpeed

-- SPEED HACK
local function UpdateWalkSpeed()
    if Settings.WalkSpeedEnabled and Humanoid then
        Humanoid.WalkSpeed = Settings.WalkSpeed
    elseif Humanoid then
        Humanoid.WalkSpeed = OriginalWalkSpeed
    end
end

local function ToggleWalkSpeed()
    Settings.WalkSpeedEnabled = not Settings.WalkSpeedEnabled
    UpdateWalkSpeed()
end

-- FLY HACK
local FlyVelocity, FlyGyro
local function ToggleFly()
    Settings.FlyEnabled = not Settings.FlyEnabled
    
    if Settings.FlyEnabled then
        -- Create fly objects
        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.Name = "FlyVelocity"
        FlyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        FlyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyVelocity.Parent = RootPart
        
        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.Name = "FlyGyro"
        FlyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        FlyGyro.P = 1000
        FlyGyro.D = 50
        FlyGyro.CFrame = RootPart.CFrame
        FlyGyro.Parent = RootPart
        
        -- Fly movement loop
        local flyConnection
        flyConnection = RunService.RenderStepped:Connect(function()
            if not Settings.FlyEnabled or not FlyVelocity then
                if flyConnection then
                    flyConnection:Disconnect()
                end
                return
            end
            
            local camera = workspace.CurrentCamera
            if not camera then return end
            
            local forward = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            
            -- Movement direction
            local moveDirection = Vector3.new(0, 0, 0)
            
            if IS_PC then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + forward
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - forward
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - right
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + right
                end
                
                -- Vertical movement
                local vertical = 0
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    vertical = 1
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    vertical = -1
                end
                
                -- Apply speed
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit * Settings.FlySpeed
                end
                
                -- Update velocity
                FlyVelocity.Velocity = Vector3.new(
                    moveDirection.X,
                    vertical * Settings.FlySpeed,
                    moveDirection.Z
                )
            end
        end)
    else
        if FlyVelocity then
            FlyVelocity:Destroy()
            FlyVelocity = nil
        end
        if FlyGyro then
            FlyGyro:Destroy()
            FlyGyro = nil
        end
    end
end

-- NOCLIP
local function ToggleNoClip()
    Settings.NoClipEnabled = not Settings.NoClipEnabled
    
    if Settings.NoClipEnabled then
        local noclipConnection
        noclipConnection = RunService.Stepped:Connect(function()
            if not Settings.NoClipEnabled then
                if noclipConnection then
                    noclipConnection:Disconnect()
                end
                return
            end
            
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Handle character respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    OriginalWalkSpeed = Humanoid.WalkSpeed
    
    -- Reapply settings
    if Settings.WalkSpeedEnabled then
        UpdateWalkSpeed()
    end
end)

-- CREATE BEAUTIFUL GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShFhGUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Add to CoreGui
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game.CoreGui
else
    ScreenGui.Parent = game.CoreGui
end

-- Main Window
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 350, 0, 50) -- Start small (only title bar)
MainWindow.Position = UDim2.new(0, 20, 0, 20)
MainWindow.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainWindow.BackgroundTransparency = 0.1 -- Less transparent
MainWindow.BorderSizePixel = 0
MainWindow.Parent = ScreenGui

-- Rounded corners
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainWindow

-- Drop shadow
local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Image = "rbxassetid://6014261993"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.5
DropShadow.Size = UDim2.new(1, 10, 1, 10)
DropShadow.Position = UDim2.new(0, -5, 0, -5)
DropShadow.BackgroundTransparency = 1
DropShadow.Parent = MainWindow

-- Title Bar (always visible)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainWindow

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 12)
TitleBarCorner.Parent = TitleBar

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ShFh by @dezzyssx"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Expand/Collapse Button
local ExpandButton = Instance.new("TextButton")
ExpandButton.Name = "ExpandButton"
ExpandButton.Size = UDim2.new(0, 40, 0, 40)
ExpandButton.Position = UDim2.new(1, -45, 0, 0)
ExpandButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
ExpandButton.BackgroundTransparency = 0.1
ExpandButton.Text = "▼"
ExpandButton.TextColor3 = Color3.fromRGB(200, 200, 255)
ExpandButton.TextSize = 18
ExpandButton.Font = Enum.Font.GothamBold
ExpandButton.Parent = TitleBar

local ExpandCorner = Instance.new("UICorner")
ExpandCorner.CornerRadius = UDim.new(0, 8)
ExpandCorner.Parent = ExpandButton

-- Content Area (hidden by default)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, 0, 0, 400)
ContentArea.Position = UDim2.new(0, 0, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.Visible = false
ContentArea.Parent = MainWindow

-- Scrollable content
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Name = "ContentScroll"
ContentScroll.Size = UDim2.new(1, -10, 1, -10)
ContentScroll.Position = UDim2.new(0, 5, 0, 5)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
ContentScroll.Parent = ContentArea

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.Parent = ContentScroll

-- Walk Speed Control
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Name = "SpeedFrame"
SpeedFrame.Size = UDim2.new(1, 0, 0, 100)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
SpeedFrame.BackgroundTransparency = 0.1
SpeedFrame.Parent = ContentScroll

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 10)
SpeedCorner.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Size = UDim2.new(1, -20, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 10)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Walk Speed: " .. Settings.WalkSpeed
SpeedLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
SpeedLabel.TextSize = 16
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedFrame

-- Speed slider
local SpeedSlider = Instance.new("Frame")
SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Size = UDim2.new(1, -30, 0, 20)
SpeedSlider.Position = UDim2.new(0, 15, 0, 45)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SpeedSlider.BackgroundTransparency = 0.1
SpeedSlider.Parent = SpeedFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 10)
SliderCorner.Parent = SpeedSlider

local SpeedFill = Instance.new("Frame")
SpeedFill.Name = "SpeedFill"
SpeedFill.Size = UDim2.new(Settings.WalkSpeed / 500, 0, 1, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
SpeedFill.BackgroundTransparency = 0.2
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedSlider

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 10)
FillCorner.Parent = SpeedFill

-- Speed toggle button
local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Name = "SpeedToggle"
SpeedToggle.Size = UDim2.new(0, 80, 0, 30)
SpeedToggle.Position = UDim2.new(1, -90, 0, 10)
SpeedToggle.BackgroundColor3 = Settings.WalkSpeedEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
SpeedToggle.BackgroundTransparency = 0.1
SpeedToggle.Text = Settings.WalkSpeedEnabled and "ON" or "OFF"
SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggle.TextSize = 14
SpeedToggle.Font = Enum.Font.GothamBold
SpeedToggle.Parent = SpeedFrame

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(0, 8)
SpeedToggleCorner.Parent = SpeedToggle

-- Fly Speed Control (similar to Walk Speed)
local FlyFrame = Instance.new("Frame")
FlyFrame.Name = "FlyFrame"
FlyFrame.Size = UDim2.new(1, 0, 0, 100)
FlyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
FlyFrame.BackgroundTransparency = 0.1
FlyFrame.Parent = ContentScroll

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 10)
FlyCorner.Parent = FlyFrame

local FlyLabel = Instance.new("TextLabel")
FlyLabel.Name = "FlyLabel"
FlyLabel.Size = UDim2.new(1, -20, 0, 30)
FlyLabel.Position = UDim2.new(0, 10, 0, 10)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "Fly Speed: " .. Settings.FlySpeed
FlyLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
FlyLabel.TextSize = 16
FlyLabel.Font = Enum.Font.GothamBold
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
FlyLabel.Parent = FlyFrame

-- Fly slider
local FlySlider = Instance.new("Frame")
FlySlider.Name = "FlySlider"
FlySlider.Size = UDim2.new(1, -30, 0, 20)
FlySlider.Position = UDim2.new(0, 15, 0, 45)
FlySlider.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
FlySlider.BackgroundTransparency = 0.1
FlySlider.Parent = FlyFrame

local FlySliderCorner = Instance.new("UICorner")
FlySliderCorner.CornerRadius = UDim.new(0, 10)
FlySliderCorner.Parent = FlySlider

local FlyFill = Instance.new("Frame")
FlyFill.Name = "FlyFill"
FlyFill.Size = UDim2.new(Settings.FlySpeed / 500, 0, 1, 0)
FlyFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
FlyFill.BackgroundTransparency = 0.2
FlyFill.BorderSizePixel = 0
FlyFill.Parent = FlySlider

local FlyFillCorner = Instance.new("UICorner")
FlyFillCorner.CornerRadius = UDim.new(0, 10)
FlyFillCorner.Parent = FlyFill

-- Fly toggle button
local FlyToggle = Instance.new("TextButton")
FlyToggle.Name = "FlyToggle"
FlyToggle.Size = UDim2.new(0, 80, 0, 30)
FlyToggle.Position = UDim2.new(1, -90, 0, 10)
FlyToggle.BackgroundColor3 = Settings.FlyEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
FlyToggle.BackgroundTransparency = 0.1
FlyToggle.Text = Settings.FlyEnabled and "ON" or "OFF"
FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggle.TextSize = 14
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.Parent = FlyFrame

local FlyToggleCorner = Instance.new("UICorner")
FlyToggleCorner.CornerRadius = UDim.new(0, 8)
FlyToggleCorner.Parent = FlyToggle

-- NoClip Control
local NoClipFrame = Instance.new("Frame")
NoClipFrame.Name = "NoClipFrame"
NoClipFrame.Size = UDim2.new(1, 0, 0, 60)
NoClipFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
NoClipFrame.BackgroundTransparency = 0.1
NoClipFrame.Parent = ContentScroll

local NoClipCorner = Instance.new("UICorner")
NoClipCorner.CornerRadius = UDim.new(0, 10)
NoClipCorner.Parent = NoClipFrame

local NoClipLabel = Instance.new("TextLabel")
NoClipLabel.Name = "NoClipLabel"
NoClipLabel.Size = UDim2.new(0.6, 0, 1, 0)
NoClipLabel.BackgroundTransparency = 1
NoClipLabel.Text = "No Clip"
NoClipLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
NoClipLabel.TextSize = 16
NoClipLabel.Font = Enum.Font.GothamBold
NoClipLabel.TextXAlignment = Enum.TextXAlignment.Left
NoClipLabel.Parent = NoClipFrame

local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Name = "NoClipToggle"
NoClipToggle.Size = UDim2.new(0, 80, 0, 30)
NoClipToggle.Position = UDim2.new(1, -90, 0.5, -15)
NoClipToggle.BackgroundColor3 = Settings.NoClipEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
NoClipToggle.BackgroundTransparency = 0.1
NoClipToggle.Text = Settings.NoClipEnabled and "ON" or "OFF"
NoClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipToggle.TextSize = 14
NoClipToggle.Font = Enum.Font.GothamBold
NoClipToggle.Parent = NoClipFrame

local NoClipToggleCorner = Instance.new("UICorner")
NoClipToggleCorner.CornerRadius = UDim.new(0, 8)
NoClipToggleCorner.Parent = NoClipToggle

-- Info Section
local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(1, 0, 0, 150)
InfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
InfoFrame.BackgroundTransparency = 0.1
InfoFrame.Parent = ContentScroll

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoFrame

local InfoText = Instance.new("TextLabel")
InfoText.Name = "InfoText"
InfoText.Size = UDim2.new(1, -20, 1, -10)
InfoText.Position = UDim2.new(0, 10, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Text = "ShFh by @dezzyssx\n\nVersion: 2.0\n\nCreated for flam0us chat\n\nFeatures:\n• Walk Speed (1-500)\n• Fly Hack (1-500)\n• No Clip\n\nControls:\nWASD - Movement\nSpace - Up\nShift - Down\n\nRightControl - Toggle Menu"
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 12
InfoText.Font = Enum.Font.Gotham
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoFrame

-- Mobile Button (only on mobile)
local MobileButton = nil
if IS_MOBILE then
    MobileButton = Instance.new("TextButton")
    MobileButton.Name = "MobileButton"
    MobileButton.Size = UDim2.new(0, 60, 0, 60)
    MobileButton.Position = UDim2.new(1, -70, 1, -70)
    MobileButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    MobileButton.BackgroundTransparency = 0.2
    MobileButton.Text = "☰"
    MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobileButton.TextSize = 24
    MobileButton.Font = Enum.Font.GothamBold
    MobileButton.Parent = ScreenGui
    
    local MobileCorner = Instance.new("UICorner")
    MobileCorner.CornerRadius = UDim.new(0, 30)
    MobileCorner.Parent = MobileButton
    
    MobileButton.MouseButton1Click:Connect(function()
        Settings.MenuExpanded = not Settings.MenuExpanded
        ToggleMenuExpand()
    end)
end

-- Update canvas size
ContentScroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- Slider dragging
local speedDragging = false
local flyDragging = false

SpeedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = true
    end
end)

FlySlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        flyDragging = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if speedDragging then
            local pos = input.Position
            local sliderPos = SpeedSlider.AbsolutePosition
            local sliderSize = SpeedSlider.AbsoluteSize
            local relativeX = math.clamp((pos.X - sliderPos.X) / sliderSize.X, 0, 1)
            
            Settings.WalkSpeed = math.floor(1 + relativeX * 499)
            SpeedLabel.Text = "Walk Speed: " .. Settings.WalkSpeed
            SpeedFill.Size = UDim2.new(Settings.WalkSpeed / 500, 0, 1, 0)
            
            UpdateWalkSpeed()
        elseif flyDragging then
            local pos = input.Position
            local sliderPos = FlySlider.AbsolutePosition
            local sliderSize = FlySlider.AbsoluteSize
            local relativeX = math.clamp((pos.X - sliderPos.X) / sliderSize.X, 0, 1)
            
            Settings.FlySpeed = math.floor(1 + relativeX * 499)
            FlyLabel.Text = "Fly Speed: " .. Settings.FlySpeed
            FlyFill.Size = UDim2.new(Settings.FlySpeed / 500, 0, 1, 0)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        speedDragging = false
        flyDragging = false
    end
end)

-- Toggle buttons
SpeedToggle.MouseButton1Click:Connect(function()
    ToggleWalkSpeed()
    SpeedToggle.BackgroundColor3 = Settings.WalkSpeedEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    SpeedToggle.Text = Settings.WalkSpeedEnabled and "ON" or "OFF"
end)

FlyToggle.MouseButton1Click:Connect(function()
    ToggleFly()
    FlyToggle.BackgroundColor3 = Settings.FlyEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    FlyToggle.Text = Settings.FlyEnabled and "ON" or "OFF"
end)

NoClipToggle.MouseButton1Click:Connect(function()
    ToggleNoClip()
    NoClipToggle.BackgroundColor3 = Settings.NoClipEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    NoClipToggle.Text = Settings.NoClipEnabled and "ON" or "OFF"
end)

-- Expand/Collapse menu function
local function ToggleMenuExpand()
    Settings.MenuExpanded = not Settings.MenuExpanded
    
    if Settings.MenuExpanded then
        -- Expand menu
        MainWindow.Size = UDim2.new(0, 350, 0, 450)
        ContentArea.Visible = true
        ExpandButton.Text = "▲"
        
        -- Animate expansion
        TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 450)
        }):Play()
    else
        -- Collapse menu
        ContentArea.Visible = false
        ExpandButton.Text = "▼"
        
        -- Animate collapse
        TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 50)
        }):Play()
    end
end

ExpandButton.MouseButton1Click:Connect(function()
    ToggleMenuExpand()
end)

-- PC keyboard control for menu
if IS_PC then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            ToggleMenuExpand()
        end
    end)
end

-- Window dragging
local dragging = false
local dragStart, startPos, dragInput

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainWindow.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Initial setup
if IS_MOBILE and MobileButton then
    -- Show mobile button
    MobileButton.Visible = true
end

print("===================================")
print("ShFh by @dezzyssx loaded successfully!")
print("Version: 2.0")
print("Created for flam0us chat")
print("Walk Speed: 1-500")
print("Fly Speed: 1-500")
if IS_PC then
    print("Press RightControl to toggle menu")
else
    print("Tap the ☰ button to open menu")
end
print("===================================")
