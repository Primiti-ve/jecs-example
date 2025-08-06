local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Jecs = require(ReplicatedStorage.Packages.Jecs)
local Planck_RunService = require(ReplicatedStorage.Packages.Planck_RunService)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase

local Components = require(ReplicatedStorage.Shared.Jecs.Components)

type World = typeof(Jecs.world())
type System = (World) -> () | {
	system: (World) -> (),
	phase: typeof(Phase.Startup / Phase.PreStartup)?,
}

function System(World)
	for ID, Amount in World:query(Jecs.pair(Components.Eats.Component, Jecs.Wildcard)) do
		local Food = World:target(ID, Components.Eats.Component)
		local FoodName = World:get(Food, Components.Name.Component)
		local EntityName = World:get(ID, Components.Name.Component)

		print(string.format("%s eats %d %s", EntityName, Amount, FoodName))
	end
end

return {
    system = System,
    phase = Planck_RunService.Phases.Last,
}
