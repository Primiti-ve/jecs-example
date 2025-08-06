local ReplicatedStorage = game:GetService("ReplicatedStorage")
local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)

return {
    Name = "Eats",
    Component = World:component(),
    Defaults = {
        Name = ""
    }
}