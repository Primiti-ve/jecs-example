local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)

type Component = {
	Name: string,
	Component: typeof(World:component()),
	Defaults: { any },
}

local Components = {} :: { [string]: Component }

for _, Component in pairs(script:GetChildren()) do
	local ComponentData = require(Component) :: Component

	World:set(ComponentData.Component, Jecs.Name, ComponentData.Name)
	Components[ComponentData.Name] = ComponentData
end

return Components
