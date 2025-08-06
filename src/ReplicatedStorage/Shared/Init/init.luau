local Runtimes = {}

for _, Runtime in pairs(script:GetChildren()) do 
    Runtimes[Runtime.Name:lower()] = require(Runtime)
end

return Runtimes