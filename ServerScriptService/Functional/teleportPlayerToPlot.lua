local ServerScriptService = game:GetService("ServerScriptService")

local getPlayerPlot = require(ServerScriptService.Functional.getPlayerPlot)

return function(player : Player)
	local plot = getPlayerPlot(player)
	
	if plot == nil then
		return
	end
	
	player.Character:PivotTo(CFrame.lookAt(plot.Prefab.Spawn:GetPivot().Position , plot.Prefab:GetPivot().Position))
end