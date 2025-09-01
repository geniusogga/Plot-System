local ServerScriptService = game:GetService("ServerScriptService")

local CircuitClass = require(ServerScriptService.Classes.CircuitClass)
local PlotPrefabs = workspace.Plots

local Plots = {
	{Prefab = PlotPrefabs.Plot1};
	{Prefab = PlotPrefabs.Plot2};
	{Prefab = PlotPrefabs.Plot3};
	{Prefab = PlotPrefabs.Plot4};
	{Prefab = PlotPrefabs.Plot5};
	{Prefab = PlotPrefabs.Plot6};
} :: {{Prefab : BasePart, Owner : number , Circuit : CircuitClass.Circuit}}

return Plots