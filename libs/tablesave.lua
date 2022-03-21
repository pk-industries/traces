--- Made by Jacob Camacho 3/21/2022
--- Serializes numbers, booleans, strings, and nested, tables into a table. Then, saves it to a file in the form of a return statement.

function table.serialize(o, indent)
    indent = indent or ""
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "boolean" then
        io.write(tostring(o))
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write(indent .. "[")
            table.serialize(k)
            io.write("] = ")
            table.serialize(v, "    ")
            io.write(",\n")
        end
        io.write("}")
    else
        error("Cannot serialize a " .. type(o))
    end
end

function table.save(data, path)
    print("Writing table to file " .. tostring(path) .. "...")
    local f = io.open(path, "w+")
    if f == nil then
        error("Could not open to write to " .. path)
    end

    local ok, err = pcall(function()
        io.output(f)
        io.write("return ")
        table.serialize(data)
    end)

    io.close(f)

    if not ok then
        error(err)
    end
end

function table.load(table, path)
    print("Loading save file " .. path .. "...")
    local f = io.open(path, "r")
    if f == nil then
        print("Save file does not exist. Skipping load.")
        return
    end
    io.close(f)

    local data, err = loadfile(path)

    if err then error(err) end

    data = data()

    for k, v in pairs(data) do
        table[k] = v
    end
end