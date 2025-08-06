local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jecs = require(ReplicatedStorage.Packages.Jecs)

local Planck = require(ReplicatedStorage.Packages.Planck)
local Phase = Planck.Phase

local Components = require(ReplicatedStorage.Shared.Jecs.Components)

type World = typeof(Jecs.world())
type System = (World) -> () | {
	system: (World) -> (),
	phase: typeof(Phase.Startup / Phase.PreStartup)?,
}

function System(World)
	World:set(
		Components.Apples.Component,
		Components.Name.Component,
		"apples"
	)
	World:set(Components.Oranges.Component, Components.Name.Component, "oranges")

	local bob = World:entity()

	World:set(bob, Jecs.pair(Components.Eats.Component, Components.Apples.Component), 10)
	World:set(bob, Jecs.pair(Components.Eats.Component, Components.Oranges.Component), 5)
	World:set(bob, Components.Name.Component, "bob")

	local alice = World:entity()

	World:set(alice, Jecs.pair(Components.Eats.Component, Components.Apples.Component), 4)
	World:set(alice, Components.Name.Component, "alice")
end

return {
	system = System,
	phase = Phase.Startup,
}
