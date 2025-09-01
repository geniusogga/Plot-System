local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local Camera = workspace.CurrentCamera

-- Config
local radius = 200;
local offset = 200
local radiansPersecond = .2
local angle = 0
local mainMenuCameraCFrame = CFrame.new(0, 350, -450) * CFrame.Angles(math.rad(45) , math.rad(180) , 0)

local Connection : RBXScriptConnection
local running = true

local function Disconnect()
	running = false
	if Connection ~= nil then
		Connection:Disconnect()
		Connection = nil
	end
end

local CameraUtil = {}

function CameraUtil.Init()
	Player.CharacterAdded:Once(CameraUtil.ToMainMenu)
end
function CameraUtil.ToPlayer(Humanoid : Humanoid)
	Disconnect()
	
	local Blur = Lighting:FindFirstChildOfClass("BlurEffect")
	if Blur ~= nil  then
		Blur:Destroy()
	end
	
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = Humanoid
end

function CameraUtil.ToPlot(Prefab : BasePart)
	if Connection then
		Disconnect()
	end
	
	local Blur = Lighting:FindFirstChildOfClass("BlurEffect")
	
	if Blur ~= nil then
		Blur:Destroy()
	end
	
	local origin = Prefab.CFrame * CFrame.new(0 , offset , 0)
	running = true
	
	Connection = RunService.Heartbeat:Connect(function(dt)
		angle = (angle + dt * radiansPersecond) % (2 * math.pi);
		for i = 0 , 1 , .1 do
			if running == false then
				return
			end
			
			Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(
				origin.Position + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius),
				Prefab.Position
				),i)
			task.wait()
		end
	end)
end

function CameraUtil.ToMainMenu()
	Disconnect()
	
	local Blur = Lighting:FindFirstChildOfClass("BlurEffect")
	
	if Blur == nil then
		Blur = Instance.new("BlurEffect")
		Blur.Parent = Lighting
	end
	
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.CFrame = mainMenuCameraCFrame
end

return CameraUtil
