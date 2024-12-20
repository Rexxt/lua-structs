local __struct_proxy = {}

local function deepcopy(t)
    local nt = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            nt[k] = deepcopy(v)
        else
            nt[k] = v
        end
    end
    return nt
end

return function(types)
    return function(table)
        local nt = {}

        nt[__struct_proxy] = deepcopy(table)
        
        setmetatable(nt, {
            __index = function(t, k)
                return t[__struct_proxy][k]
            end,
            __newindex = function(t, k, v)
                if (types[k] ~= nil) and (type(v) == types[k]) or (type(v) == "table" and getmetatable(v) == getmetatable(types[k])) then
                    t[__struct_proxy][k] = v
                else
                    error("type mismatch: attempted to assign " .. type(v) .. " to field of type " .. type(t[__struct_proxy][k]), 2)
                end
            end
        })

        return nt
    end
end