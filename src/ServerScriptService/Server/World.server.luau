local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)
local Components = require(ReplicatedStorage.Shared.Jecs.Components)

function HookTag(Tag: string, Callback: (Instance) -> ())
	local Registered = {}

	local function ProcessAllTagged()
		for _, Tagged in pairs(CollectionService:GetTagged(Tag)) do
			if Tagged:HasTag("Entity") and not Registered[Tagged] then
				Callback(Tagged)
				Registered[Tagged] = true
			end
		end
	end

	ProcessAllTagged()

	CollectionService:GetInstanceAddedSignal(Tag):Connect(ProcessAllTagged)
	CollectionService:GetInstanceRemovedSignal(Tag):Connect(ProcessAllTagged)
end

for Tag, Component in pairs(Components) do
	local InstanceToEntity = {}

	HookTag(Tag, function(Object)
		if InstanceToEntity[Object] then
			return
		end

		local Entity = World:entity()
		InstanceToEntity[Object] = Entity

		World:set(Entity, Components.Instance.Component, { Object = Object })

		local function FetchData()
			local Attributes = Object:GetAttributes()
			local ComponentData = {}

			for Key, Value in pairs(Component.Defaults or {}) do
				ComponentData[Key] = Value
			end

			for Name, Value in pairs(Attributes) do
				if Component.Defaults and Component.Defaults[Name] ~= nil then
					ComponentData[Name] = Value
				end
			end

			return ComponentData
		end

		World:set(Entity, Component.Component, FetchData())

		for Name, _ in pairs(Object:GetAttributes()) do
			Object:GetAttributeChangedSignal(Name):Connect(function()
				World:set(Entity, Component.Component, FetchData())
			end)
		end
	end)
end
