local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Guis = ReplicatedStorage.Guis
local UIScripts = script.Parent

local UIInit = {}

function UIInit.Init()
	for _ , object in Guis:GetChildren() do
		if object.ClassName == "ScreenGui" then
			object:Clone().Parent = Player.PlayerGui		
		end
	end
	
	for _ , object in UIScripts:GetChildren() do
		if object.ClassName ~= "ModuleScript" or type(require(object)) ~= "table" then
			continue
		end 
		
		local module = require(object)
		
		if module.Initiate and type(module.Initiate) == "function" then
			module.Initiate()
		end
	end
end

return UIInit
