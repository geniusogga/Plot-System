local ServerScriptService = game:GetService("ServerScriptService")

for _ , object in ServerScriptService:GetDescendants() do
	if object.ClassName ~= "ModuleScript" or type(require(object)) ~= "table" then
		continue
	end

	local module = require(object)

	if module.Init ~= nil and type(module.Init) == "function" then
		module.Init()
	end
end