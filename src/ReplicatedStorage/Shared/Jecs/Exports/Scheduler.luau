local ReplicatedStorage = game:GetService("ReplicatedStorage")
local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)

local Planck = require(ReplicatedStorage.Packages.Planck)
local PlanckRunService = require(ReplicatedStorage.Packages.Planck_RunService).Plugin.new()

local Scheduler = Planck.Scheduler.new(World):addPlugin(PlanckRunService)

return Scheduler