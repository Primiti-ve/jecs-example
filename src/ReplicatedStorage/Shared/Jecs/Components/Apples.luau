local ReplicatedStorage = game:GetService("ReplicatedStorage")
local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)

return {
    Name = "Apples",
    Component = World:component(),
    Defaults = {
        Amount = 0
    }
}