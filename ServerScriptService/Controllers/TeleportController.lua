local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local teleportPlayerToPlot = require(ServerScriptService.Functional.teleportPlayerToPlot)
local TeleportRemote = ReplicatedStorage.RemoteEvents.TeleportToPlot

local TeleportController = {}

TeleportRemote.OnServerEvent:Connect(teleportPlayerToPlot)

return TeleportController
