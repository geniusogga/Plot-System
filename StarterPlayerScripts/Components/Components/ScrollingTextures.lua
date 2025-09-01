local Runservice = game:GetService("RunService")

local ScrollingTextureClass = {
	Tag = "ScrollingTexture";
}
ScrollingTextureClass.__index = ScrollingTextureClass

export type ScrollingTexture = typeof(setmetatable({} :: {
	Connections : {RBXScriptConnection};
	Texture : Texture
} , ScrollingTextureClass))

function ScrollingTextureClass.new(texture : Texture)
	local self = setmetatable({
		Connections = {};
		Texture = texture;
	} , ScrollingTextureClass)

	self.Initiate(self)

	return self
end

function ScrollingTextureClass.Initiate(self : Template)
	local t = 0
	local size = self.Texture.StudsPerTileV
	
	self.Connections[1] = Runservice.RenderStepped:Connect(function(dt)
		t += dt * 2
		
		if dt >= size then
			t%=size
		end
		
		self.Texture.OffsetStudsV = t
	end)
end

return ScrollingTextureClass
