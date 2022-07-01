--- Made by Jacob Camacho 6/30/2022
--- Serializes numbers, booleans, strings, and nested tables into a table. Then, saves it to a file in the form of a return statement.
--- Writes return function of table to specified path.
function table.save(data, path)
    print("Writing table to file " .. tostring(path) .. "...")

    local ok, err = pcall(playdate.datastore.write, data, path, true)

    if not ok then error(err) end
end

--- Loads return statement of source table from a file into the given receiving table. Preexisting values are overridden.
function table.load(table, path)
    print("Loading save file " .. path .. "...")
    local ok, data = pcall(playdate.datastore.read, path)

    if not ok then error(data) end

    if data == nil then
        print("Save file does not exist. Skipping load.")
        return
    end

    for k, v in pairs(data) do table[k] = v end
end
