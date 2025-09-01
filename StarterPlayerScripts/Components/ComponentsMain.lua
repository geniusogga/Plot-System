local CollectionService = game:GetService("CollectionService")

local CachedInstances = {}
local Component = {}

function load(input : {ModuleScript})
	for _ , _module in input do
		if not _module:IsA("ModuleScript") then
			continue
		end

		local module = require(_module)
		local tag = module.Tag

		if tag == nil then
			continue
		end

		local function instance_added(instance)
			CachedInstances[instance] = CachedInstances[instance] or {}
			local newComponent = module.new(instance)
			CachedInstances[instance][tag] = newComponent 
		end

		local function instance_removed(instance)
			for tag , component in CachedInstances[instance] do
				component[tag] = nil

				if component.Connections == nil then
					return
				end

				for index , connection in component.Connections :: {RBXScriptConnection} do
					connection:Disconnect()
					component.Connections[index] = nil
				end

			end
		end
		CollectionService:GetInstanceAddedSignal(tag):Connect(instance_added)
		CollectionService:GetInstanceRemovedSignal(tag):Connect(instance_removed)

		for _ , existing in CollectionService:GetTagged(tag) do
			instance_added(existing)
		end
	end
end

function Component.Init()
	load(script.Components:GetChildren())
end

return Component
