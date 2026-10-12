---@meta _
---@class UI.Grid
---@field rows UI.Grid.Row[]
---@field AddRow fun(self: UI.Grid): UI.Grid.Row
---@field Render fun(self: UI.Grid, parent: Frame, x?: number, y?: number): number, number
UI.Grid = UI.Grid or {}
UI.Grid.__index = UI.Grid

---@class UI.Grid.Row
---@field columns UI.Grid.Column[]
---@field AddColumn fun(self: UI.Grid.Row): UI.Grid.Column
UI.Grid.Row = UI.Grid.Row or {}
UI.Grid.Row.__index = UI.Grid.Row

---@class UI.Grid.Column
---@field items any[]
---@field Add fun(self: UI.Grid.Column, item: any): any
---@field AddRow fun(self: UI.Grid.Column): UI.Grid.Row
UI.Grid.Column = UI.Grid.Column or {}
UI.Grid.Column.__index = UI.Grid.Column

local function getItemSize(item)
    if getmetatable(item) == UI.Grid.Row then
        local width = 0
        local height = 0

        for _, column in ipairs(item.columns) do
            local columnWidth, columnHeight = getItemSize(column)
            width = width + columnWidth
            height = math.max(height, columnHeight)
        end

        return width, height
    end

    if getmetatable(item) == UI.Grid.Column then
        local width = 0
        local height = 0

        for _, child in ipairs(item.items) do
            local childWidth, childHeight = getItemSize(child)
            width = math.max(width, childWidth)
            height = height + childHeight
        end

        return width, height
    end

    if type(item) ~= "table" or type(item.GetWidth) ~= "function" or type(item.GetHeight) ~= "function" then
        error("Grid can only render nested rows and Frame-like items", 3)
    end

    return item:GetWidth(), item:GetHeight()
end

local function layoutItem(item, parent, x, y)
    if getmetatable(item) == UI.Grid.Row then
        local columnX = x

        for _, column in ipairs(item.columns) do
            layoutItem(column, parent, columnX, y)
            columnX = columnX + getItemSize(column)
        end
    elseif getmetatable(item) == UI.Grid.Column then
        local itemY = y

        for _, child in ipairs(item.items) do
            layoutItem(child, parent, x, itemY)
            local _, childHeight = getItemSize(child)
            itemY = itemY + childHeight
        end
    else
        if type(item.SetPoint) ~= "function" or type(item.ClearAllPoints) ~= "function" then
            error("Grid items must support ClearAllPoints and SetPoint", 3)
        end

        item:ClearAllPoints()
        item:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
    end
end

function UI.Grid:New()
    return setmetatable({ rows = {} }, self)
end

function UI.Grid:AddRow()
    local row = setmetatable({ columns = {} }, UI.Grid.Row)
    table.insert(self.rows, row)
    return row
end

function UI.Grid.Row:AddColumn()
    local column = setmetatable({ items = {} }, UI.Grid.Column)
    table.insert(self.columns, column)
    return column
end

---@generic T
---@param item T
---@return T
function UI.Grid.Column:Add(item)
    table.insert(self.items, item)
    return item
end

function UI.Grid.Column:AddRow()
    local row = setmetatable({ columns = {} }, UI.Grid.Row)
    table.insert(self.items, row)
    return row
end

---@param parent Frame
---@param x? number
---@param y? number
---@return number width
---@return number height
function UI.Grid:Render(parent, x, y)
    x = x or 0
    y = y or 0
    local rowY = y
    local width = 0

    for _, row in ipairs(self.rows) do
        layoutItem(row, parent, x, rowY)
        local rowWidth, rowHeight = getItemSize(row)
        width = math.max(width, rowWidth)
        rowY = rowY + rowHeight
    end

    return width, rowY - y
end
