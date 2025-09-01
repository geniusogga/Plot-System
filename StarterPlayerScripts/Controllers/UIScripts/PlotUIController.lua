local Players = game:GetService("Players")
local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SelectPlotRemoteFunction = ReplicatedStorage.RemoteFunctions.SelectPlot

local CameraUtil = require(StarterPlayerScripts.Util.CameraUtil)

local Plots = workspace:WaitForChild("Plots")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local PlotUI : ScreenGui
local MainUI : ScreenGui
local TeleportUI : ScreenGui

local BackButton : TextButton
local SelectButton : TextButton
local NextButton : TextButton
local PrevButton : TextButton
local PlayButton : TextButton

local CurrentPlot = 1
local MaxPlots = 6
local MinPlots = 1

local function changePlot(operator : "Add" | "Subtract")
	if operator == "Add" then
		CurrentPlot += 1
	elseif operator == "Subtract" then
		CurrentPlot -= 1
	end
	
	if CurrentPlot > MaxPlots then
		CurrentPlot = MinPlots
	elseif CurrentPlot < MinPlots then
		CurrentPlot = MaxPlots
	end
	
	CameraUtil.ToPlot(Plots[`Plot{CurrentPlot}`])
end

local function onPlayButton()
	CameraUtil.ToPlot(Plots[`Plot{CurrentPlot}`])
end

local function onBackButton()
	CameraUtil.ToMainMenu()
	PlotUI.Enabled = false
	MainUI.Enabled = true
end

local function onSelectButton()
	local sucess = SelectPlotRemoteFunction:InvokeServer(CurrentPlot)
	
	if sucess == true then
		CameraUtil.ToPlayer(Player.Character.Humanoid)
		TeleportUI.Enabled = true
		PlotUI.Enabled = false
	end
end

local PlotUIController = {}

function PlotUIController.Initiate()
	PlotUI = PlayerGui.PlotUI
	MainUI = PlayerGui.MainUI
	BackButton = PlotUI.BackButton
	SelectButton = PlotUI.SelectButton
	NextButton = PlotUI.NextButton
	PrevButton = PlotUI.PrevButton
	PlayButton = MainUI.PlayButton
	TeleportUI = PlayerGui.TeleportUI
	
	PlayButton.Activated:Connect(onPlayButton)
	NextButton.Activated:Connect(function() changePlot("Add") end)
	PrevButton.Activated:Connect(function() changePlot("Subtract") end)
	BackButton.Activated:Connect(onBackButton)
	SelectButton.Activated:Connect(onSelectButton)
end

return PlotUIController
