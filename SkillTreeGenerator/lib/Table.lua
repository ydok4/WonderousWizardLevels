Table = {
    Name = "",
    Header = {},
    Colummns = {},
    Data = {},
}

function Table:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function Table:AddToHeader(header)
    table.insert(self.Header, header);
end

function Table:AddColumns(columnHeadingIndexes)
    self.Columns = columnHeadingIndexes;
end

function Table:AddRows(rows)
    table.insert(self.Data, rows);
end

function Table:GetColumnValueForRow(row, columnKey)
    local columnIndex = self.Columns[columnKey];
    if columnIndex ~= nil then
        return row[columnIndex];
    end
end

function Table:GetRowByIndex(index)
    return self.Data[index];
end

function Table:GetColumnValueForIndex(index, columnKey, rows)
    local row = {};
    if rows == nil then
        row = self.Data[index];
    else
        row = rows[index];
    end
    local columnValue = self:GetColumnValueForRow(row, columnKey)
    return columnValue;
end

function Table:GetColumnValuesForRows(columnKey, rows)
    local columnValues = {};
    for index, row in pairs(rows) do
        local columnValue = self:GetColumnValueForRow(row, columnKey);
        table.insert(columnValues, columnValue);
    end
    return columnValues;
end

function Table:GetRowsMatchingColumnValues(columnKey, columnValues, existingRowsToFilter)
    local rowsToFilter = {};
    if existingRowsToFilter ~= nil then
        rowsToFilter = existingRowsToFilter;
    else
        rowsToFilter = self.Data;
    end
    local matchingRows = {};
    for index = 1, #rowsToFilter do
        local columnValue = "";
        columnValue = self:GetColumnValueForIndex(index, columnKey, rowsToFilter);
        for valueIndex, value in pairs(columnValues) do
            if columnValue == value then
                table.insert(matchingRows, rowsToFilter[index]);
                break;
            end
        end
    end
    return matchingRows;
end

function Table:GetUniqueColumnValuesForRows(columnKey, rows)
    local uniqueColumnValues = {};
    local uniqueColumnValuesTracker = {};
    for index, row in pairs(rows) do
        local columnValue = self:GetColumnValueForRow(row, columnKey);
        if uniqueColumnValuesTracker[columnValue] == nil then
            uniqueColumnValuesTracker[columnValue] = true;
            table.insert(uniqueColumnValues, columnValue);
        end
    end
    return uniqueColumnValues;
end

function Table:CloneRow(index, rowSetToCloneFrom)
    local rowSet = {};
    if rowSetToCloneFrom ~= nil then
        rowSet = rowSetToCloneFrom;
    else
        rowSet = self.Data;
    end
    local rowToClone = rowSet[index];
    local clonedRow = {};
    if rowToClone ~= nil then
        for columnIndex, columnValue in pairs(rowToClone) do
            table.insert(clonedRow, columnValue);
        end
    end
    return clonedRow;
end

function Table:SetColumnValue(row, columnKey, newValue)
    local columnIndex = self.Columns[columnKey];
    row[columnIndex] = newValue;
end

function Table:PrepareRowsForOutput(rows)
    local tableToOutput = {};
    ConcatTable(tableToOutput, self.Header);
    ConcatTable(tableToOutput, rows);
    return tableToOutput;
end