local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ServerSystems = ServerScriptService.Server:WaitForChild("Systems")
local SharedSystems = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Jecs"):WaitForChild("Systems")

local Init = require(ReplicatedStorage.Shared.Init)
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

AddSystems(ServerSystems)
AddSystems(SharedSystems)

Init.systems:Init(Systems)