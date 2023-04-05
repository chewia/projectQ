local launcher = {}
launcher.__index = launcher
local _print = outputDebugString

function launcher:new(name, priority)
    local resource = {}
    setmetatable(resource, launcher)
    resource.name = name
    resource.priority = priority or 0
    return resource
end

-- Resource listesi
local resources = {
    -- isim, sıra/öncelik
    launcher:new("mysql", 1),
    launcher:new("cache", 2),
    launcher:new("dxlibrary", 3),
    launcher:new("fonts", 4),
    launcher:new("account", 5),
    launcher:new("items", 6),
    launcher:new("admins", 7),
    launcher:new("vehicleslibrary", 8),
    launcher:new("cursor", 9),
    launcher:new("living", 10),
    launcher:new("vehicles", 11),
}

local max = #resources
local delay = 0

function launcher:launch(state)
    setTimer(function()
        _print("Resource "..self.name.." stated. "..state.."/"..max.."")
        Resource.getFromName(self.name):start()
    end, delay * 1000, 1)
end

table.sort(resources, function(a,b) return a.priority < b.priority end)

for index, resource in ipairs(resources) do
    resource:launch(index, delay)
    delay = delay + 2
end