-- ShFh by @dezzyssx - Speed & Fly Hack
print("ShFh by @dezzyssx loading...")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")

local Settings = {
    Speed = 50,
    FlySpeed = 50,
    SpeedOn = false,
    FlyOn = false
}

-- Speed
local function ToggleSpeed()
    Settings.SpeedOn = not Settings.SpeedOn
    Hum.WalkSpeed = Settings.SpeedOn and Settings.Speed or 16
    print("Speed:", Settings.SpeedOn and "ON" or "OFF")
end

-- Fly
local FlyVelocity, FlyGyro
local function ToggleFly()
    Settings.FlyOn = not Settings.FlyOn
    
    if Settings.FlyOn then
        -- Create fly objects
        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        FlyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyVelocity.Parent = Root
        
        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        FlyGyro.CFrame = Root.CFrame
        FlyGyro.Parent = Root
        
        -- Fly loop
        RS.RenderStepped:Connect(function()
            if not Settings.FlyOn or not FlyVelocity then return end
            
            local cam = workspace.CurrentCamera
            if not cam then return end
            
            local forward = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            
            local move = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + forward end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - forward end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - right end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + right end
            
            local vertical = 0
            if UIS:IsKeyDown(Enum.KeyCode.Space) then vertical = 1 end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vertical = -1 end
            
            if move.Magnitude > 0 then
                move = move.Unit * Settings.FlySpeed
            end
            
            FlyVelocity.Velocity = Vector3.new(
                move.X,
                vertical * Settings.FlySpeed,
                move.Z
            )
        end)
        
        print("Fly: ON")
    else
        if FlyVelocity then FlyVelocity:Destroy() end
        if FlyGyro then FlyGyro:Destroy() end
        print("Fly: OFF")
    end
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShFhGUI"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 200)
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Main.Visible = false
Main.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Text = "ShFh by @dezzyssx"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0, 100, 0, 40)
SpeedBtn.Position = UDim2.new(0.5, -50, 0, 60)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
SpeedBtn.Text = "Speed: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.Parent = Main

local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0, 100, 0, 40)
FlyBtn.Position = UDim2.new(0.5, -50, 0, 120)
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
FlyBtn.Text = "Fly: OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.TextSize = 14
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Parent = Main

SpeedBtn.MouseButton1Click:Connect(function()
    ToggleSpeed()
    SpeedBtn.Text = "Speed: " .. (Settings.SpeedOn and "ON" or "OFF")
end)

FlyBtn.MouseButton1Click:Connect(function()
    ToggleFly()
    FlyBtn.Text = "Fly: " .. (Settings.FlyOn and "ON" or "OFF")
end)

-- Menu toggle
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("===================================")
print("ShFh by @dezzyssx loaded!")
print("Press RightControl to open menu")
print("Created for flam0us chat")
print("===================================")