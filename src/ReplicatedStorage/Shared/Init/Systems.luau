--!nocheck

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")

local Jabby = require(ReplicatedStorage.Packages.Jabby)

local Scheduler = require(ReplicatedStorage.Shared.Jecs.Exports.Scheduler)
local World = require(ReplicatedStorage.Shared.Jecs.Exports.World)

local Init = {}

function Init:Init(Systems)
    for _, System in pairs(Systems) do 
        Scheduler:addSystem(System, System.phase)
    end

    if RunService:IsClient() then
        local Client = Jabby.obtain_client()
    
        local function CreateWidget(_, State: Enum.UserInputState)
            if State ~= Enum.UserInputState.Begin then
                return
            end
    
            Client.spawn_app(Client.apps.home, nil)
        end
    
        ContextActionService:BindAction("Open Jabby", CreateWidget, false, Enum.KeyCode.F4)
    end
    
    Jabby.register({
        applet = Jabby.applets.world,
        name = "Jecs World",
        configuration = {
            world = World
        }
    })
end

return Init