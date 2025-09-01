local Players = game:GetService("Players")
local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts

local CameraUtil = require(StarterPlayerScripts.Util.CameraUtil)

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local PlotUI : ScreenGui
local MainUI : ScreenGui
local PlayButton : TextButton
local FeedbackButton : TextButton

local function onPlayButton()
	MainUI.Enabled = false
	PlotUI.Enabled = true	
end

local function onFeedBackButton()
	
end

local MainUIController = {}

function MainUIController.Initiate()
	PlotUI = PlayerGui.PlotUI
	MainUI = PlayerGui.MainUI
	PlayButton = MainUI.PlayButton
	FeedbackButton = MainUI.FeedbackButton
	
	PlayButton.Activated:Connect(onPlayButton)
end

return MainUIController
