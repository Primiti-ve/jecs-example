local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Init = require(ReplicatedStorage.Shared.Init)

local ClientSystems = script.Parent:WaitForChild("Systems")
local SharedSystems = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Jecs"):WaitForChild("Systems")

local Systems = {}

function AddSystems(Folder)
	for _, Child in pairs(Folder:GetChildren()) do
		if Child:IsA("ModuleScript") then
			table.insert(Systems, require(Child))
		else
			AddSystems(Child)
		end
	end
end

AddSystems(ClientSystems)
AddSystems(SharedSystems)

Init.systems:Init(Systems)