function set(...)
    local ret = {}
    for _, k in ipairs({...}) do
        ret[k] = true
    end
    return ret
end

function addToSet(set, key)
    set[key] = true
end

function removeFromSet(set, key)
    set[key] = nil
end

function setContains(set, key)
    return set[key] ~= nil
end
