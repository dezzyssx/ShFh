-- ShFh by @dezzyssx
local UIS,Players,RS=game:GetService("UserInputService"),game:GetService("Players"),game:GetService("RunService")
local LP=Players.LocalPlayer
local Char=LP.Character or LP.CharacterAdded:Wait()
local Hum=Char:WaitForChild("Humanoid")
local Root=Char:WaitForChild("HumanoidRootPart")

local Settings={Speed=50,FlySpeed=50,SpeedOn=false,FlyOn=false,NoClipOn=false}
local FlyVel,FlyGyro

local function ToggleSpeed()
    Settings.SpeedOn=not Settings.SpeedOn
    Hum.WalkSpeed=Settings.SpeedOn and Settings.Speed or 16
end

local function ToggleFly()
    Settings.FlyOn=not Settings.FlyOn
    if Settings.FlyOn then
        FlyVel=Instance.new("BodyVelocity")
        FlyVel.MaxForce=Vector3.new(40000,40000,40000)
        FlyVel.Velocity=Vector3.new(0,0,0)
        FlyVel.Parent=Root
        FlyGyro=Instance.new("BodyGyro")
        FlyGyro.MaxTorque=Vector3.new(40000,40000,40000)
        FlyGyro.CFrame=Root.CFrame
        FlyGyro.Parent=Root
        RS.RenderStepped:Connect(function()
            if not Settings.FlyOn then return end
            local cam=workspace.CurrentCamera
            if not cam then return end
            local forward,right=cam.CFrame.LookVector,cam.CFrame.RightVector
            local move=Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W)then move=move+forward end
            if UIS:IsKeyDown(Enum.KeyCode.S)then move=move-forward end
            if UIS:IsKeyDown(Enum.KeyCode.A)then move=move-right end
            if UIS:IsKeyDown(Enum.KeyCode.D)then move=move+right end
            local vertical=0
            if UIS:IsKeyDown(Enum.KeyCode.Space)then vertical=1 end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift)then vertical=-1 end
            if move.Magnitude>0 then move=move.Unit*Settings.FlySpeed end
            FlyVel.Velocity=Vector3.new(move.X,vertical*Settings.FlySpeed,move.Z)
            FlyGyro.CFrame=cam.CFrame
        end)
    else
        if FlyVel then FlyVel:Destroy()end
        if FlyGyro then FlyGyro:Destroy()end
    end
end

local function ToggleNoClip()
    Settings.NoClipOn=not Settings.NoClipOn
    if Settings.NoClipOn then
        RS.Stepped:Connect(function()
            if not Settings.NoClipOn then return end
            for _,p in pairs(Char:GetDescendants())do
                if p:IsA("BasePart")then p.CanCollide=false end
            end
        end)
    end
end

-- GUI
local Gui=Instance.new("ScreenGui")Gui.Name="ShFhGUI"Gui.Parent=game.CoreGui
local Win=Instance.new("Frame")Win.Size=UDim2.new(0,300,0,350)Win.Position=UDim2.new(0.5,-150,0.5,-175)Win.BackgroundColor3=Color3.fromRGB(30,30,40)Win.Visible=false Win.Parent=Gui
local Title=Instance.new("TextLabel")Title.Size=UDim2.new(1,0,0,40)Title.BackgroundColor3=Color3.fromRGB(40,40,50)Title.Text="ShFh by @dezzyssx"Title.TextColor3=Color3.fromRGB(255,215,0)Title.TextSize=18 Title.Font=Enum.Font.GothamBold Title.Parent=Win

local Close=Instance.new("TextButton")Close.Size=UDim2.new(0,30,0,30)Close.Position=UDim2.new(1,-35,0,5)Close.BackgroundColor3=Color3.fromRGB(255,60,60)Close.Text="X"Close.TextColor3=Color3.fromRGB(255,255,255)Close.TextSize=16 Close.Font=Enum.Font.GothamBold Close.Parent=Win
Close.MouseButton1Click:Connect(function()Win.Visible=false end)

UIS.InputBegan:Connect(function(input)
    if input.KeyCode==Enum.KeyCode.RightControl then Win.Visible=not Win.Visible end
end)

print("ShFh by @dezzyssx loaded! RightControl - Menu")