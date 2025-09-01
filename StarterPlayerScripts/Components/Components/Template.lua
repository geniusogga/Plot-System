local TemplateClass = {
	Tag = "Template";
}
TemplateClass.__index = TemplateClass

export type Template = typeof(setmetatable({} :: {
	Connections : {}
} , TemplateClass))

function TemplateClass.new()
	local self = setmetatable({
		Connections = {}
	} , TemplateClass)
	
	self.Initiate(self)
	
	return self
end

function TemplateClass.Initiate(self : Template)
	
end

return TemplateClass
