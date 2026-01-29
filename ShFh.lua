-- ShFh by @dezzyssx
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local LP = Players.LocalPlayer

-- Get character
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Root = Char:WaitForChild("HumanoidRootPart")

-- Settings
local Settings = {
    Speed = 50,
    FlySpeed = 50,
    SpeedOn = false,
    FlyOn = false,
    NoClipOn = false,
    MenuOpen = false
}

-- Speed Hack
local function ToggleSpeed()
    Settings.SpeedOn = not Settings.SpeedOn
    Hum.WalkSpeed = Settings.SpeedOn and Settings.Speed or 16
end

-- Fly Hack
local FlyVel, FlyGyro
local function ToggleFly()
    Settings.FlyOn = not Settings.FlyOn
    
    if Settings.FlyOn then
        FlyVel = Instance.new("BodyVelocity")
        FlyVel.MaxForce = Vector3.new(40000, 40000, 40000)
        FlyVel.Velocity = Vector3.new(0, 0, 0)
        FlyVel.Parent = Root
        
        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        FlyGyro.CFrame = Root.CFrame
        FlyGyro.Parent = Root
        
        -- Fly movement loop
        RS.RenderStepped:Connect(function()
            if not Settings.FlyOn or not FlyVel then return end
            
            local cam = workspace.CurrentCamera
            if not cam then return end
            
            local forward = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            
            -- Movement direction
            local moveDir = Vector3.new(0, 0, 0)
            
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + forward
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - forward
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - right
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + right
            end
            
            -- Vertical movement
            local vertical = 0
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                vertical = 1
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                vertical = -1
            end
            
            -- Apply speed
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit * Settings.FlySpeed
            end
            
            -- Update velocity
            FlyVel.Velocity = Vector3.new(
                moveDir.X,
                vertical * Settings.FlySpeed,
                moveDir.Z
            )
            
            FlyGyro.CFrame = cam.CFrame
        end)
    else
        if FlyVel then FlyVel:Destroy() end
        if FlyGyro then FlyGyro:Destroy() end
    end
end

-- NoClip
local function ToggleNoClip()
    Settings.NoClipOn = not Settings.NoClipOn
    
    if Settings.NoClipOn then
        RS.Stepped:Connect(function()
            if not Settings.NoClipOn then return end
            for _, part in pairs(Char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ShFhGUI"
Gui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Main.Visible = false
Main.Parent = Gui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Text = "ShFh by @dezzyssx"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 16
Close.Font = Enum.Font.GothamBold
Close.Parent = Main

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Menu toggle
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("ShFh by @dezzyssx loaded! Press RightControl to open menu")
print("Created for flam0us chat")
