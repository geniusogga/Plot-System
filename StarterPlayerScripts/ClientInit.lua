local StarterPlayerScripts = game:GetService("StarterPlayer").StarterPlayerScripts

for _ , object in StarterPlayerScripts:GetDescendants() do
	if object.ClassName ~= "ModuleScript" or type(require(object)) ~= "table" then
		continue
	end 

	local module = require(object)

	if module.Init and type(module.Init) == "function" then
		module.Init()
	end
end