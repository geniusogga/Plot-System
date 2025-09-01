local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TeleportToPort = ReplicatedStorage.RemoteEvents.TeleportToPlot

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local TeleportUI : TextButton
local TeleportButton: TextButton

local debounce = false
local cooldown = 2

local function onTeleport()
	if debounce == false then
		debounce = true
		TeleportToPort:FireServer()
		task.wait(cooldown)
		debounce = false
	end	
end

local TeleportUIController = {}

function TeleportUIController.Initiate()
	TeleportUI = PlayerGui.TeleportUI
	TeleportButton = TeleportUI.TeleportButton
	
	TeleportButton.Activated:Connect(onTeleport)
end

return TeleportUIController
