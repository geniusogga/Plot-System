local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SelectPlotRemoteFunction = ReplicatedStorage.RemoteFunctions.SelectPlot

local Plots = require(ServerScriptService.Data.Plots)
local CircuitClass = require(ServerScriptService.Classes.CircuitClass)
local teleportPlayerToPlot = require(ServerScriptService.Functional.teleportPlayerToPlot)

local PlotController = {}

local debounce = false

SelectPlotRemoteFunction.OnServerInvoke = function(player , currentPlot)
	local result = PlotController.OnPlotSelect(player , currentPlot)
	return result
end

function PlotController.OnPlotSelect(player : Player, currentPlot : number)
	local success = false
	local selectedPlot = Plots[currentPlot]
	
	if selectedPlot.Owner == nil then
		success = true
		
		selectedPlot.Owner = player.UserId
		selectedPlot.Circuit = CircuitClass.new(player)
		print(selectedPlot.Circuit)
		
		
		local connection = player.CharacterAdded:Connect(function() teleportPlayerToPlot(player) end)
		
		Players.PlayerRemoving:Connect(function(_player : Player)
			if _player.UserId ~= player.UserId then
				return
			end
			
			connection:Disconnect()
			connection = nil
			selectedPlot.Owner = nil
		end)
		
		teleportPlayerToPlot(player)
	end
	
	return success	
end

return PlotController
