local ServerScriptService = game:GetService("ServerScriptService")

local Plots = require(ServerScriptService.Data.Plots)

return function(Player)
	local plot
	
	for _ , _plot in Plots do
		if _plot.Owner == Player.UserId then
			plot = _plot
		end
	end
	
	return plot
end