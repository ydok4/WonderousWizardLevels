function ConcatTableWithKeys(destinationTable, sourceTable)
    for key, value in pairs(sourceTable) do
        destinationTable[key] = value;
    end
end

function ConcatTable(destinationTable, sourceTable)
    for key, value in pairs(sourceTable) do
        destinationTable[#destinationTable + 1] = value;
    end
end

function Roll100(passValue)
    return Random(99) < passValue;
end

function TableHasAnyValue(table)
    for key, value in pairs(table) do
        return true;
    end
    return false;
end

function Random(limit, start)
    if not start then
        start = 1;
    end
    return cm:random_number(limit, start);
end

function GetRandomObjectFromList(objectList)
    local tempTable = {}
    for key, value in pairs(objectList) do
      tempTable[#tempTable + 1] = key; --Store keys in another table
    end
    local index = tempTable[Random(#tempTable)];
    return objectList[index];
end

function GetRandomObjectKeyFromList(objectList)
    local tempTable = {}
    for key, value in pairs(objectList) do
      tempTable[#tempTable + 1] = key; --Store keys in another table
    end
    local index = tempTable[Random(#tempTable)];
    return index;
end

-- This won't work with nested tables
-- Intended for use for simple tables
function GetAndRemoveRandomObjectFromList(objectList)
    local tempTable = {}
    for key, value in pairs(objectList) do
      tempTable[#tempTable + 1] = key; --Store keys in another table
    end
    local index = tempTable[Random(#tempTable)];
    local object = objectList[index];
    objectList[index] = nil;
    return object;
end

function FindTableObjectByKeyPartial(objectList, partialValue)
    for key, value in pairs(objectList) do
        if string.match(key, partialValue) then
            return value;
        end
    end
end

function CreateValidLuaTableKey(value)
    -- This removes any spaces within names, eg the surname "Von Carstein";
    -- Otherwise the key is invalid and the character won't be tracked
    value = value:gsub("%s+", "");
    -- This replaces any apostrophes in names with _
    value = value:gsub("'", "_");
    value = value:gsub("-", "_");
    value = value:gsub("á", "a");
    value = value:gsub("à", "a");
    value = value:gsub("é", "e");
    value = value:gsub("í", "i");
    value = value:gsub("ó", "o");
    value = value:gsub("‘", "_");
    value = value:gsub(",", "_");
    return value;
end

function GetKeysFromTable(tableWithKeys)
    local tableKeys = {};
    for key, value in pairs(tableWithKeys) do
        tableKeys[#tableKeys + 1] = key;
    end
    return tableKeys;
end

function GetMatchingKeyMatchingLocalisedString(keys, stringToMatch, keyPrefix)
    for index, key in pairs(keys) do
        if stringToMatch == common.get_localised_string(keyPrefix..key) then
            return key;
        end
    end
    return nil;
end

function Contains(sourceTable, checkValue)
    for index, value in pairs(sourceTable) do
        if value == checkValue then
            return true;
        end
    end
    return false;
end

function GetRandomItemFromWeightedList(items, returnKey)
    local validItems = {};
    local sumOfWeight = 0;
    for key, data in pairs(items) do
        if data["Weighting"] ~= nil then
            sumOfWeight = sumOfWeight + data["Weighting"];
            validItems[key] = data;
        end
    end

    local weightingSeed = Random(sumOfWeight, 0);
    local lastKey = "";
    local lastData = "";
    for key, data in pairs(validItems) do
        if weightingSeed < data["Weighting"]
         then
            if returnKey == true then
                return key;
            else
                return data;
            end
        end
        weightingSeed = weightingSeed - data["Weighting"];
        lastKey = key;
        lastData = data;
    end
    if returnKey == true then
        return lastKey;
    else
        return lastData;
    end
end